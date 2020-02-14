defmodule Manipulating do
    def filter([], _) do
        []
    end

    def filter([h | t], n) do
        if h <= n do
            [h | filter(t, n)]
        else
            filter(t, n)
        end
    end

    def reverse(l) do
        reverse(l, [])
    end

    defp reverse([], acc) do
        acc
    end

    defp reverse([h | t], acc) do
        reverse(t, [h | acc])
    end

    defp append([], []) do
        []
    end

    defp append(l, []) do
        l
    end

    defp append([], l) do
        l
    end

    defp append([h | t], l) do
        [h | append(t, l)]
    end

    def concatenate(l) do
        concatenate(l, [])
    end

    defp concatenate([h | t], laux) do
        concatenate(t, append(laux, h))
    end
    defp concatenate(l, laux) do
        append(laux, l)
    end
end
