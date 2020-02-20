defmodule Echo do
    def start() do
        Process.register(spawn(Echo, :listen, []), :echo)
        :ok
    end

    def stop() do
        send(:echo, {:stop, self()})
        receive do
            :ok -> :ok
        end
    end

    def print(term) do
        send(:echo, {:print, term})
        :ok
    end

    def listen() do
        receive do
            {:stop, pid} ->
                send(pid, :ok) 
                exit(:normal)
            {:print, term} -> 
                IO.puts(term)
                listen()
        end
    end
end
