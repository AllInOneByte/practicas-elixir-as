defmodule Effects do
    def print(n) when n > 0 do
        print_aux(n, 1)
    end

    defp print_aux(1, c) do
        IO.puts(c)
    end

    defp print_aux(n, c) do
        IO.puts(c)
        print_aux(n - 1, c + 1)
    end

    def even_print(n) when n > 0 do
        eprint_aux(n, 1)
    end

    defp eprint_aux(1, c) do
        if rem(c, 2) == 0 do
            IO.puts(c)
        end
    end

    defp eprint_aux(n, c) do
        if rem(c, 2) == 0 do
            IO.puts(c)
        end
        eprint_aux(n - 1, c + 1)
    end
end
