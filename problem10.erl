%% Copyright
-module(problem10).
-author("Novakov").

-mode(compile).

-import(commons, [divisableByAny/2]).

%% API
-export([main/1]).

solve(N) ->
        solve(N, 2, [], 0).

solve(Max, Current, _, Acc)
        when Max =< Current ->
        Acc;

solve(Max, Current, AlreadyFound, Acc) ->
        case Current rem 1000 =:= 0 of
                true -> io:format("~p\n", [Current]);
                false -> 1 + 1
        end,
        case divisableByAny(Current, AlreadyFound) of
                true -> solve(Max, Current + 1, AlreadyFound, Acc);
                false -> solve(Max, Current + 1, AlreadyFound ++ [Current], Acc + Current)
        end.

main(_) ->
        io:format("~p\n", [solve(2000000)]).