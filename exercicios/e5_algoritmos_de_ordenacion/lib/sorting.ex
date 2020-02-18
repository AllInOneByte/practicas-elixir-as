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
end
