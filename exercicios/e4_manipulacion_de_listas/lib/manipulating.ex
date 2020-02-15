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

    defp reverse([], laux) do
        laux
    end

    defp reverse([h | t], laux) do
        reverse(t, [h | laux])
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

    def flatten(list) do
        flatten(list, [])
    end
    
    defp flatten([h | t], laux) when h == [] do
        flatten(t, laux)
    end
    
    defp flatten([h | t], laux) when is_list(h) do
        flatten(h, flatten(t, laux))
    end
    
    defp flatten([h | t], laux) do
        [h | flatten(t, laux)]
    end
    
    defp flatten([], laux) do
        laux
    end
end
