defmodule MyApp1 do

  def getFront(str,head) do

    case str do
      "" ->
        {"", ""}
      _ ->
        case String.split(str, head, parts: 2) do
          [content] -> {content , ""}
          [content, remain] -> {content, remain}
        end
    end

  end

  def getRemain(str,tail) do
    case str do
      "" ->
        {"", ""}
      _ ->
        case String.split(str, tail, parts: 2) do
          [content, remain] -> {content , remain}
          [_content] -> {"", ""}
        end
    end

  end

  def filterIn("",_head,_tail) do
    ""
  end

  def filterIn(str,head,tail) do
      {content, remain} = getFront(str,head)
      {content, remain} = getRemain(remain,tail)
      content <> filterIn(remain,head,tail)
  end

  def start do

    IO.puts filterIn("abc()"  , "(" , ")"     )
    IO.puts filterIn("()abc"  , "(" , ")"      )
    IO.puts filterIn("abc()abc()"  , "(" , ")" )
    IO.puts filterIn("abc()abc()abc"  , "(" , ")" )
    IO.puts filterIn("abc(abc)abc()abc"  , "(" , ")" )
    IO.puts filterIn("abc(abc"  , "(" , ")" )
    IO.puts filterIn("abc(def)abc(ghi)abc"  , "(" , ")" )

  end

end
