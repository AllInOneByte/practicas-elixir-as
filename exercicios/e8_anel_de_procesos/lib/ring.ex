defmodule Ring do
    def start(n, m, msg) do
        Process.flag(:trap_exit, true)
        next = spawn_link(Ring, :conf, [n - 1, m, msg, self()])
        listen(next, :dad)
    end

    def conf(0, m, msg, next) do
        Process.flag(:trap_exit, true)
        send(next, {m - 1, msg})
        listen(next)
    end

    def conf(n, m, msg, init) do
        Process.flag(:trap_exit, true)
        next = spawn_link(Ring, :conf, [n - 1, m, msg, init])
        listen(next)
    end

    def listen(next) do
        receive do
            {0, _msg} ->
                exit(:normal)
            {m, msg} ->
                send(next, {m - 1, msg})
                listen(next)
            {:EXIT, _from, _reason} -> exit(:normal)
        end
    end

    def listen(next, :dad) do
        receive do
            {0, _msg} ->
                send(next, {:EXIT, :die, :sincerely_dad})
                listen(next, :dad)
            {m, msg} ->
                send(next, {m - 1, msg})
                listen(next, :dad)
            {:EXIT, _from, _reason} -> :ok
        end
    end
end
