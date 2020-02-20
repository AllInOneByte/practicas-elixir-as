defmodule Echo do
    def start() do
        Process.register(spawn(listen()), :echo)
        :ok
    end

    def stop() do
        echo = Process.registered() |> Enum.find(fn x -> x == :echo end)
        send(echo, {:stop})
        :ok
    end

    def print(term) do
        echo = Process.registered() |> Enum.find(fn x -> x == :echo end)
        send(echo, {:print, term})
        :ok
    end

    defp listen() do
        receive do
            {:stop} -> exit(:shutdown)
            {:print, term} -> printer(term)
        after
            5000 -> :timeout
        end
    end

    defp printer(term) do
        IO.puts(term)
        listen()
    end
end
