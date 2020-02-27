defmodule Measure do
    def run(lf, n) do
        pre_creation_time = :erlang.timestamp()
        tasks =
            for {_m, f} <- lf do
                Task.async(fn ->
                    if f == :flatten do
                        1..n |> Enum.map(fn _ -> :rand.uniform(1000) end) |> Enum.chunk_every(1)
                    else
                        1..n |> Enum.map(fn _ -> :rand.uniform(1000) end)
                    end
                end)
            end
        complex_results = Task.yield_many(tasks, :infinity)
        results = Enum.map(complex_results, fn {_task, {_msg, result}} -> result end)
        pos_creation_time = :erlang.timestamp()
        creation_time = :timer.now_diff(pos_creation_time, pre_creation_time) / 1000000
        func_tasks = task_generator(lf, results)
        complex_results_func = Task.yield_many(func_tasks, 10000)
        results_func = mixer(complex_results_func, lf)
        IO.puts " ---------------------------------------"
		IO.puts "| Creación de datos     : #{creation_time}       sec |"
        for {m, f, r} <- results_func do
            if r != nil || r != :error do
                IO.puts("| #{m |> to_string() |> String.split(".") |> List.last}:#{Atom.to_string(f)}  : #{inspect r}       sec |")
            else
                IO.puts("| #{m |> to_string() |> String.split(".") |> List.last}:#{Atom.to_string(f)}  : interrompida       sec |")
            end
        end
        IO.puts " ---------------------------------------"
    end

    def task_generator([{m, f} | []], [h | []]) do
        [Task.async(Measure, :runner, [m, f, [h]])]
    end

    def task_generator([{m, f} | ft], [h | nt]) do
        [Task.async(Measure, :runner, [m, f, [h]]) | task_generator(ft, nt)]
    end

    def runner(m, f, h) do
        pre_time = :erlang.timestamp()
        apply(m, f, h)
        pos_time = :erlang.timestamp()
        :timer.now_diff(pos_time, pre_time) / 1000000
    end

    def mixer([], []) do
        []
    end

    def mixer([{nil} | tr], [{m, f} | tf]) do
        [{m, f, nil} | mixer(tr, tf)]
    end

    def mixer([{:exit, _reason} | tr], [{m, f} | tf]) do
        [{m, f, :exit} | mixer(tr, tf)]
    end

    def mixer([{_task, {:ok, term}} | tr], [{m, f} | tf]) do
        [{m, f, term} | mixer(tr, tf)]
    end
end
