defmodule TecLab_2.PageControllerTest do
  use TecLab_2.ConnCase, async: true

  test "file 1", %{} do
    {:ok, resp} = :httpc.request(:get, {'https://dl.dropboxusercontent.com/u/978896/file1.txt', []}, [], [body_format: :binary])
    {{_, resp_code, resp_ok}, _headers, body} = resp

    if (resp_code == 200 && resp_ok == 'OK') do

      if (is_bitstring(body) && String.valid?(body)) do

        info_file = String.split(body, "\n")
          |> Enum.uniq

        {list_file_number, list_file_string} = Enum.partition(info_file, fn(row) ->
          if (Integer.parse(row) != :error) do
            {parse, divided} = Integer.parse(row)
            if (divided == "") do
              parse
            end
          end
        end)

        list_redis_string = Redis.lrange('string')
        list_redis_number = Redis.lrange('number')

        Redis.del('string')
        Redis.del('number')

        list_string = Enum.concat(list_file_string, list_redis_string)
          |> Enum.uniq
          |> Enum.sort(&(byte_size(&2) <= byte_size(&1)))
          |> Enum.each(fn(row) -> Redis.lpush('string', row) end)

        list_number = Enum.concat(list_file_number, list_redis_number)
          |> Enum.uniq
          |> Enum.sort
          |> Enum.each(fn(row) -> Redis.lpush('number', row) end)

        assert true

      else
        assert false
      end
    else
      assert false
    end

  end

  test "file 2", %{} do
    {:ok, resp} = :httpc.request(:get, {'https://dl.dropboxusercontent.com/u/978896/file2.txt', []}, [], [body_format: :binary])
    {{_, resp_code, resp_ok}, _headers, body} = resp

    if (resp_code == 200 && resp_ok == 'OK') do

      if (is_bitstring(body) && String.valid?(body)) do

        info_file = String.split(body, "\n")
          |> Enum.uniq

        {list_file_number, list_file_string} = Enum.partition(info_file, fn(row) ->
          if (Integer.parse(row) != :error) do
            {parse, divided} = Integer.parse(row)
            if (divided == "") do
              parse
            end
          end
        end)

        list_redis_string = Redis.lrange('string')
        list_redis_number = Redis.lrange('number')

        Redis.del('string')
        Redis.del('number')

        list_string = Enum.concat(list_file_string, list_redis_string)
          |> Enum.uniq
          |> Enum.sort(&(byte_size(&2) <= byte_size(&1)))
          |> Enum.each(fn(row) -> Redis.lpush('string', row) end)

        list_number = Enum.concat(list_file_number, list_redis_number)
          |> Enum.uniq
          |> Enum.sort
          |> Enum.each(fn(row) -> Redis.lpush('number', row) end)

        assert true

      else
        assert false
      end
    else
      assert false
    end
  end

  test "file 3", %{} do
    {:ok, resp} = :httpc.request(:get, {'https://dl.dropboxusercontent.com/u/978896/file3.txt', []}, [], [body_format: :binary])
    {{_, resp_code, resp_ok}, _headers, body} = resp

    if (resp_code == 200 && resp_ok == 'OK') do

      if (is_bitstring(body) && String.valid?(body)) do

        info_file = String.split(body, "\n")
          |> Enum.uniq

        {list_file_number, list_file_string} = Enum.partition(info_file, fn(row) ->
          if (Integer.parse(row) != :error) do
            {parse, divided} = Integer.parse(row)
            if (divided == "") do
              parse
            end
          end
        end)

        list_redis_string = Redis.lrange('string')
        list_redis_number = Redis.lrange('number')

        Redis.del('string')
        Redis.del('number')

        list_string = Enum.concat(list_file_string, list_redis_string)
          |> Enum.uniq
          |> Enum.sort(&(byte_size(&2) <= byte_size(&1)))
          |> Enum.each(fn(row) -> Redis.lpush('string', row) end)

        list_number = Enum.concat(list_file_number, list_redis_number)
          |> Enum.uniq
          |> Enum.sort
          |> Enum.each(fn(row) -> Redis.lpush('number', row) end)

        assert true

      else
        assert is_bitstring(body) && String.valid?(body)
      end
    else
      assert resp_ok == 200
    end
  end


 
end
