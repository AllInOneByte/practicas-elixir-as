defmodule Db do
    def new() do
        []
    end

    def write(db_ref, key, element) do
       [[key, element] | db_ref] 
    end

    def delete(db_ref, key) do
        for [k, v] when k != key <- db_ref, do: [k, v]
    end

    def read(db_ref, key) do
        element = for [k, v] when k == key <- db_ref, do: v
        if element != [] do
            {:ok, hd(element)}
        else
            {:error, :not_found}
        end
    end

    def match(db_ref, element) do
        for [k, v] when v == element <- db_ref, do: k
    end

    def destroy(_db_ref) do
        :ok
    end
end
