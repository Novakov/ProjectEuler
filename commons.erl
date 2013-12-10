%% Copyright
-module(commons).
-author("Novakov").

-mode(compile).

%% API
-export([factors/1, is_prime/1, divisableByAny/2, sumOfDigits/2, factorial/1]).


factors(N) ->
        Top = erlang:trunc(math:sqrt(N)),
        Possible = lists:seq(2, Top),
        lists:filter(fun(X) -> N rem X == 0 end, Possible).

is_prime(N) ->
        Factors = factors(N),
        lists:all(fun(X) -> X == 1 orelse X == N end, Factors).

divisableByAny(_, []) ->
        false;
divisableByAny(N, [Num | _])
        when N rem Num =:= 0 ->
        true;
divisableByAny(N, [Num | Nums])
        when N rem Num =/= 0 ->
        divisableByAny(N, Nums).

sumOfDigits(X, Acc) when X < 10 -> Acc + X;
sumOfDigits(X, Acc) -> sumOfDigits(X div 10, Acc + X rem 10).

factorial(0, Acc) -> Acc;
factorial(1, Acc) -> Acc;
factorial(N, Acc)->
        factorial(N - 1, Acc * N).

factorial(N) ->
        factorial(N, 1).
