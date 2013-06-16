%% Copyright
-module(problem7).
-author("Novakov").

-mode(compile).
%% API
-import(commons, [divisableByAny/2]).
-export([]).




solve(N) ->
        solve(2, N, []).

solve(Current, 0, _) ->
        Current - 1;
solve(Current, Remaining, AlreadyFound) ->
        case divisableByAny(Current, AlreadyFound) of
                true -> solve(Current + 1, Remaining, AlreadyFound);
                false -> solve(Current + 1, Remaining - 1, AlreadyFound ++ [Current])
        end.



main(_) ->
        io:format("~p\n", [solve(10001)]).
