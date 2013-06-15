%% Copyright
-module(problem6).
-author("Novakov").

-mode(compile).
%% API
-export([]).

fold(_, Acc, 0) ->
        Acc;
fold(Fun, Acc, N) ->
        fold(Fun, Fun(N, Acc), N -1).


solve(N) ->
        SumOfSquares = fold(fun (X,T) -> X * X + T end, 0, N),
        Sum = N * (N+1) / 2,
        Sum * Sum - SumOfSquares.


main(_) ->
        io:format("~p\n", [solve(100)]).