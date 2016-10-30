defmodule TecLab_2.PageControllerTest do
  use TecLab_2.ConnCase, async: true

  test "file 1", %{} do
    {resp_code, resp_ok, body} = http_request('file1')

    if (resp_code == 200 && resp_ok == 'OK') do

      if (is_bitstring(body) && String.valid?(body)) do

        info_file = String.split(body, "\n")
          |> Enum.uniq

        {list_file_number, list_file_string} = list_divicion(info_file)

        {list_redis_string, list_redis_number} = redis_range_del()

        list_string = list_string_to_redis(list_file_string, list_redis_string)
        list_number = list_number_to_redis(list_file_number, list_redis_number)

        IO.inspect "-------- File 1"

        assert list_number == :ok && list_string == :ok, "File 1 problem insert data"

      else
        assert is_bitstring(body) && String.valid?(body), "File 1 no valid content"
      end
    else
      assert resp_code == 200 && resp_ok == 'OK', "File 1 not found"
    end

  end

  test "file 2", %{} do
    {resp_code, resp_ok, body} = http_request('file2')

    if (resp_code == 200 && resp_ok == 'OK') do

      if (is_bitstring(body) && String.valid?(body)) do

        info_file = String.split(body, "\n")
          |> Enum.uniq

        {list_file_number, list_file_string} = list_divicion(info_file)

        {list_redis_string, list_redis_number} = redis_range_del()

        list_string = list_string_to_redis(list_file_string, list_redis_string)
        list_number = list_number_to_redis(list_file_number, list_redis_number)

        IO.inspect "-------- File 2"

        assert list_number == :ok && list_string == :ok, "File 2 problem insert data"

      else
        assert is_bitstring(body) && String.valid?(body), "File 2 no valid content"
      end
    else
      assert resp_code == 200 && resp_ok == 'OK', "File 2 not found"
    end
  end

  test "file 3", %{} do
    {resp_code, resp_ok, body} = http_request('file3')

    if (resp_code == 200 && resp_ok == 'OK') do

      if (is_bitstring(body) && String.valid?(body)) do

        info_file = String.split(body, "\n")
          |> Enum.uniq

        {list_file_number, list_file_string} = list_divicion(info_file)

        {list_redis_string, list_redis_number} = redis_range_del()

        list_string = list_string_to_redis(list_file_string, list_redis_string)
        list_number = list_number_to_redis(list_file_number, list_redis_number)

        IO.inspect "-------- File 3"

        assert list_number == :ok && list_string == :ok, "File 3 problem insert data"

      else
        assert is_bitstring(body) && String.valid?(body), "File 3 no valid content"
      end
    else
      assert resp_code == 200 && resp_ok == 'OK', "File 3 not found"
    end
  end

  defp http_request(file) do
    url = 'https://dl.dropboxusercontent.com/u/978896/' ++ file ++ '.txt'
    {:ok, resp} = :httpc.request(:get, {url, []}, [], [body_format: :binary])
    {{_, resp_code, resp_ok}, _headers, body} = resp
    {resp_code, resp_ok, body}
  end

  defp list_divicion(info_file) do
    {list_file_number, list_file_string} = Enum.partition(info_file, fn(row) ->
      if (Integer.parse(row) != :error) do
        {parse, divided} = Integer.parse(row)
        if (divided == "") do
          parse
        end
      end
    end)
    {list_file_number, list_file_string}
  end

  defp redis_range_del() do
    list_redis_string = Redis.lrange('string')
    list_redis_number = Redis.lrange('number')
    Redis.del('string')
    Redis.del('number')
    {list_redis_string, list_redis_number}
  end

  defp list_string_to_redis(list_file_string, list_redis_string) do
    list_string = Enum.concat(list_file_string, list_redis_string)
      |> Enum.uniq
      |> Enum.sort(&(byte_size(&2) <= byte_size(&1)))
      |> Enum.each(fn(row) -> 
        Redis.lpush('string', row)
        IO.inspect row
      end)
  end

  defp list_number_to_redis(list_file_number, list_redis_number) do
    list_number = Enum.concat(list_file_number, list_redis_number)
      |> Enum.uniq
      |> Enum.sort
      |> Enum.each(fn(row) -> 
        Redis.lpush('number', row)
        IO.inspect row
      end)
  end

 
end
