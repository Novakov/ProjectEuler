%% Copyright
-module(fibo_gen).
-author("Novakov").

-mode(compile).
%% API
-export([main/1]).

fibo(1) ->
        [1];
fibo(2) ->
        [1, 1];
fibo(3) ->
        [2, 1, 1];
fibo(N) ->
        fibo(N - 3, fibo(3)).

fibo(0, T) ->
        T;

fibo(N, [P1 | [P2 | T]]) ->
        Elem = P1 + P2,
        Arr = [Elem | [P1 | [P2 | T]]],
        fibo(N - 1, Arr).



solve(N) ->
        fibo(N).

main(_) ->
        io:format("~p\n", [fibo(19)])
.
