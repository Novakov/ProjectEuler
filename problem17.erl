%% Copyright
-module(problem17).
-author("Novakov").

-import(commons, [sumOfDigits/2]).

%% API
-export([main/1]).

factorial(1, Acc) -> Acc;
factorial(N, Acc) -> factorial(N-1, Acc * N).

solve() ->
        F = factorial(100, 1),
        sumOfDigits(F, 0).

main(_) ->
        io:format("~p~n", [solve()]).