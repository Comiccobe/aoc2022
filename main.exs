dirs = "input.txt"
  |> File.stream!
  |> Stream.map(&String.trim/1)
  |> Stream.map(&String.split(&1, " "))
  |> Enum.reduce(
       %{ dirs: Map.put(%{}, "home", 0), cwd: ["home"]},
       fn
         ["$", "cd", "/"], acc -> acc
         ["$", "ls"], acc -> acc
         ["dir", _], acc -> acc
         ["$", "cd", ".."], acc -> Map.put(acc, :cwd, tl(acc.cwd))
         ["$", "cd", dir], acc -> Map.put(acc, :cwd, [dir] ++ acc.cwd)
         [size, _], acc ->
           setsize = fn
             [h|t], dacc, sf ->
               key = Enum.join(Enum.reverse(t), "/") <> "/" <> h
               Map.put(sf.(t, dacc, sf), key, (dacc[key] || 0) + String.to_integer(size))
             [], dacc, _ -> dacc
           end
           Map.put(acc, :dirs, setsize.(acc.cwd, acc.dirs, setsize))
       end)
  |> Map.fetch!(:dirs)

IO.puts(
  "Part 1: #{
    dirs
    |> Enum.map(fn {_, v} -> v end)
    |> Enum.filter(&(&1 <= 100000))
    |> Enum.sum
  }"
)

IO.puts(
  "Part 2: #{
    dirs
    |> Enum.map(fn {_, v} -> v end)
    |> Enum.filter(&(&1 >= 30000000 - (70000000 - dirs["/home"])))
    |> Enum.sort
    |> hd
  }"
)