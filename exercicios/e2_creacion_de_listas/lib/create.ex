defmodule Create do
    def create(n) do
        create_aux(n, 1, [])
    end

    defp create_aux(0, c, l) do
        l
    end

    defp create_aux(n, c, l) do
        create_aux(n - 1, c + 1, l ++ [c])
    end

    def reverse_create(0) do
        []
    end

    def reverse_create(1) do
        [1]
    end 

    def reverse_create(n) do
        [n] ++ reverse_create(n - 1)
    end
end
