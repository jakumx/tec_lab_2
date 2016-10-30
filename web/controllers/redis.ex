defmodule Redis do
  import Exredis

  def lrange(key), do: start_link |> elem(1) |> query(["LRANGE", key, 0, -1])
  def lpush(key, value), do: start_link |> elem(1) |> query(["LPUSH", key, value])
  def del(key), do: start_link |> elem(1) |> query(["DEL", key])

end
