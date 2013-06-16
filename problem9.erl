%% Copyright
-module(problem9).
-author("Novakov").

-mode(compile).

%% API
-export([]).

solve(N) ->
        solve(N, N - 1, N - 1).

solve(Sum, 0, B) ->
        solve(Sum, Sum - 1, B - 1);
solve(Sum, A, B) ->
        C = Sum - A - B,
        case (A * A + B * B) =:= C * C of
                true -> {A, B, C};
                false -> solve(Sum, A - 1, B)
        end.

main(_) ->
        io:format("~p\n", [solve(1000)]).
