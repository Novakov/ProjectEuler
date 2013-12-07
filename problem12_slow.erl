%% Copyright
-module(problem12_slow).
-author("Novakov").

-import(commons, [factors/1]).
-import(erasto, [erasto/1]).

%% API
-export([main/1]).

count_divisors(N) ->
        TriangularNumber = N * (N + 1) div 2,
        PrimeFactors = erasto(TriangularNumber),
        PrimeFactorsCount = lists:flatlength(PrimeFactors),
        math:pow(2, PrimeFactorsCount) - 1.

solve(N)->
        case N rem 1000 =:= 1 of
                true -> io:format("~p~n", [N]);
                false -> x
        end,

        DivisorsCount = count_divisors(N),

        case DivisorsCount >= 500 of
                true -> N;
                _ -> solve(N+100)
        end.

solve() ->
        solve(2).



main(_) ->
        io:format("~p~n", [solve()]).
