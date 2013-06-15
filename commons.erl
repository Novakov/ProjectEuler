%% Copyright
-module(commons).
-author("Novakov").

-mode(compile).

%% API
-export([factors/1, is_prime/1]).


factors(N) ->
        Top = erlang:trunc(math:sqrt(N)),
        Possible = lists:seq(2, Top),
        lists:filter(fun(X) -> N rem X == 0 end, Possible).

is_prime(N) ->
        Factors = factors(N),
        lists:all(fun(X) -> X == 1 orelse X == N end, Factors).