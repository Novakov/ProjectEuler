%% Copyright
-module(problem3).
-author("Novakov").

-mode(compile).

-import(commons, [is_prime/1, factors/1]).

%% API
-export([main/1]).

solve(N) ->
        Factors = factors(N),
        PrimeFactors = lists:filter(fun is_prime/1,  Factors),
        lists:max(PrimeFactors).

main(_) ->
        io:format("~p\n", [solve(600851475143 )]).