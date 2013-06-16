%% Copyright
-module(problem7).
-author("Novakov").

-mode(compile).
%% API
-export([]).

divisableBy(_, []) ->
        false;
divisableBy(N, [Num | _])
        when N rem Num =:= 0 ->
        true;
divisableBy(N, [Num | Nums])
        when N rem Num =/= 0 ->
        divisableBy(N, Nums).


solve(N) ->
        solve(2, N, []).

solve(Current, 0, _) ->
        Current - 1;
solve(Current, Remaining, AlreadyFound) ->
        case divisableBy(Current, AlreadyFound) of
                true -> solve(Current + 1, Remaining, AlreadyFound);
                false -> solve(Current + 1, Remaining - 1, AlreadyFound ++ [Current])
        end.



main(_) ->
        io:format("~p\n", [solve(10001)]).
