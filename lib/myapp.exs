defmodule MyAddProcess do

  def start_link do
    {:ok, spawn_link(fn -> loop() end)}
  end

  defp loop() do
    receive do
      {:sum, msg} ->
        fromPid = msg[:sendPid]
        startV = msg[:startValue]
        endV = msg[:endValue]
        sumResult = Enum.sum(startV..endV)
        send fromPid, {:return, %{:returnPid => self(), :sumResult => sumResult}}
    end
  end

end

defmodule Myapp do

  def start do

    selfPid = self()
    start = :lists.seq(1,10000,100)

    for x <- start do
      {:ok, pid} = MyAddProcess.start_link
      send pid, {:sum, %{:sendPid => selfPid, :startValue => x, :endValue => x+99}}
    end

    loop1(%{:prevSum => 0, :count => 0})

  end

  defp loop1(%{prevSum: sum, count: 100}) do
    IO.puts("result ==== #{sum}")
  end

  defp loop1(%{prevSum: sum, count: count} = map) do
    map =
      receive do
        {:return, %{returnPid: _, sumResult: process_result}} ->
          map
            |> Map.replace(:prevSum, sum + process_result)
            |> Map.replace(:count, count + 1)
      end

    loop1(map)
  end
end

Myapp.start
