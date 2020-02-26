defmodule Mi6 do
    use Agent
    use GenServer

    def fundar() do
        GenServer.start_link(Mi6, Db.new(), name: :mi6)
    end

    def recrutar(axente, destino) do
        GenServer.cast(:mi6, {:recrutar, axente, destino})
    end

    def asignar_mision(axente, mision) do
        GenServer.cast(:mi6, {mision, axente})
    end

    def consultar_estado(axente) do
        GenServer.call(:mi6, {:consultar, axente})
    end

    def disolver() do
        GenServer.stop(:mi6, :normal, :infinity)
    end

    def init(state) do
        {:ok, state}
    end

    def handle_cast({:recrutar, axente, destino}, state) do
        {_, elem} = Db.read(state, axente)
        if elem == :not_found do
            {_, e} = Agent.start_link(fn -> Enum.shuffle(Create.create(String.length(destino))) end)
            {:noreply, Db.write(state, axente, e)}
        else
            {:noreply, state}
        end
    end

    def handle_cast({:espiar, axente}, state) do
        {_, elem} = Db.read(state, axente)
        if elem != :not_found do
            Agent.update(elem, fn ([h | t]) -> Manipulating.filter([h | t], h) end, :infinity)
        end
        {:noreply, state}
    end

    def handle_cast({:contrainformar, axente}, state) do
        {_, elem} = Db.read(state, axente)
        if elem != :not_found do
            Agent.update(elem, fn (l) -> Manipulating.reverse(l) end, :infinity)
        end
        {:noreply, state}
    end

    def handle_call({:consultar, axente}, _from, state) do
        {_, elem} = Db.read(state, axente)
        if elem == :not_found do
            {:reply, :you_are_here_we_are_not, state}
        else
            {:reply, Agent.get(elem, fn (l) -> l end, :infinity), state}
        end
    end

    def terminate(_reason, []) do
        :ok
    end

    def terminate(reason, [h | t]) do
        Agent.stop(hd(tl(h)), :normal, :infinity)
        terminate(reason, t)
    end
end
