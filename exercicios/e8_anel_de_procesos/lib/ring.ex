defmodule Ring do
    def start(n, m, msg) do
        next = spawn(Ring, :conf, [n - 1, self()])
        send(next, {m - 1, msg})
        listen(next)
    end

    def conf(0, origin) do
        listen(origin)
    end

    def conf(n, origin) when n > 0 do
        listen(spawn(Ring, :conf, [n - 1, origin]))
    end

    def listen(next) do
        receive do
            {:m_zero, :die} -> 
                send(next, {:m_zero, :die})
                :ok
            {0, _msg} ->
                send(next, {:m_zero, :die})
            {m, msg} ->
                send(next, {m - 1, msg})
                listen(next)
        end
    end
end
