defmodule Sorting do
    def quicksort([]) do
        []
    end

    def quicksort([h | t]) do
        quicksort(h, t, [], [])
    end

    defp quicksort(piv, [], lless, lmore) do
        lless ++ [piv | lmore]
    end

    defp quicksort(piv, [h], lless, lmore) do
        if h < piv do
            quicksort(lless ++ [h]) ++ [piv | quicksort(lmore)]
        else
            quicksort(lless) ++ [piv | quicksort(lmore ++ [h])]
        end
    end

    defp quicksort(piv, [h | t], lless, lmore) do
        if h < piv do
            quicksort(piv, t, lless ++ [h], lmore)
        else
            quicksort(piv, t, lless, lmore ++ [h])
        end
    end

    def mergesort([]) do
        []
    end

    def mergesort([h | []]) do
        [h]
    end

    def mergesort(l) do
        {l1, l2} = Enum.split(l, div(length(l), 2))
        sort(mergesort(l1), mergesort(l2))
    end

    defp sort(l, []) do
        l
    end

    defp sort([], l) do
        l
    end

    defp sort([h1 | t1], [h2 | t2]) do
        if h1 < h2 do
            [h1 | sort(t1, [h2 | t2])]
        else
            sort([h2 | [h1 | t1]], t2)
        end
    end
end
