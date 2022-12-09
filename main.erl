-module(main).
-import(io, [fwrite/1]).
-import(string, [tokens/2]).
-import(file, [open/2, close/1, read_line/1]).
-import(lists, [reverse/1, last/1, nth/2, nthtail/2, sublist/3, split/2, append/2]).
-export([start/0]).

start() ->
  fwrite(["Part 1: ", solve(fun(L) -> reverse(L) end), "\n",
          "Part 2: ", solve(fun(L) -> L end), "\n"]).

solve(Fn) ->
  {_, Device} = open("input.txt", read),
  Stacks = parse_stacks(Device, [[], [], [], [], [], [], [], [], []]),
  {_, _} = read_line(Device),
  Answer = read_answer(make_moves(Device, Stacks, Fn)),
  close(Device),
  Answer.

read_answer([Stack|Stacks]) when length(Stacks) > 0 ->
  [last(Stack)] ++ read_answer(Stacks);
read_answer([Stack|_]) ->
  [last(Stack)].

make_moves(Device, Stacks, Fn) ->
  case read_line(Device) of
    {_, Line} ->
      Tokens = tokens(
                      re:replace(Line, "\\r|\\n", "", [global,{return,list}]),
                      [$\s]),
      NewStacks = move_boxes(
                             list_to_integer(nth(4, Tokens)),
                             list_to_integer(nth(6, Tokens)),
                             list_to_integer(nth(2, Tokens)),
                             Stacks,
                             Fn),
      make_moves(Device, NewStacks, Fn);
    eof ->
      Stacks
  end.
  
move_boxes(From, To, Amount, Stacks, Fn) ->
  {BeforeFrom, [FromStack|AfterFrom]} = split(From-1, Stacks),
  {Rest, PoppedBoxes} = split(length(FromStack) - Amount, FromStack),
  {BeforeTo, [ToStack|AfterTo]} = split(To-1, BeforeFrom ++ [Rest] ++ AfterFrom),
  BeforeTo ++ [append(ToStack, Fn(PoppedBoxes))] ++ AfterTo.

parse_stacks(Device, Stacks) ->
  {_, Line} = read_line(Device),
  parse_stack_rows(Device, Line, Stacks, nth(2, Line)).

parse_stack_rows(Device, Line, Stacks, FirstChar) when FirstChar /= 49 ->
  {_, NextLine} = read_line(Device),
  parse_stack_rows(Device, NextLine, parse_stack_columns(Line, Stacks), nth(2, NextLine));
parse_stack_rows(_, _, Stacks, 49) ->
  Stacks.

parse_stack_columns([_|Line], Stacks) when length(Line) > 34 ->
  parse_stack_columns(Line, Stacks);
parse_stack_columns([Char|Line], [Stack|Stacks]) when length(Line) > 5 ->
  case Char of
    32 ->
      [Stack] ++ parse_stack_columns(nthtail(3, Line), Stacks);
    _ ->
      [[Char] ++ Stack] ++
        parse_stack_columns(nthtail(3, Line), Stacks)
  end;
parse_stack_columns([Char|_], [Stack|_]) ->
  case Char of
    32 ->
      [Stack];
    _ ->
      [[Char] ++ Stack]
  end.