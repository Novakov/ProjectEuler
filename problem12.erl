%% Copyright
-module(problem12).
-author("Novakov").

%% API

-export([main/1, factorize/2, countDivisors/2, test/3]).

factorize(_, 1, Factors) -> Factors;

factorize([H|T], Number, [{H, Count}|Factors]) when Number rem H =:= 0 ->
        factorize([H|T], Number div H, [{H, Count + 1}|Factors]);

factorize([H|T], Number, Factors) when Number rem H =:= 0 ->
        factorize([H|T], Number div H, [{H, 1}|Factors]);

factorize([_|T], Number, Factors) ->
        factorize(T, Number, Factors);

factorize([], Number, Factors) -> {error, not_enough_elements}.

factorize(Elements, Number) ->
        factorize(Elements, Number, []).

countDivisors(Primes, Number) ->
        Factors = factorize(Primes, Number),
        F = fun({_, Count}, Acc) ->
                Acc * (Count + 1)
        end,
        Count = lists:foldl(F, 1, Factors),
        Count.

test(Primes, N, Step) ->
        D = countDivisors(Primes, N),
        case N rem 1000 =:= 0 of
                true -> io:format("~p (~p),", [N, D]);
                false -> ok
        end,
        case D of
                D when D > 500 -> {ok, N};
                _ -> test(Primes, N + Step, Step + 1)
        end.

findSolution(RequestedNumberOfDivisors, Primes, CurrentNumber) ->
        Divisors = countDivisors(Primes, CurrentNumber),
        case CurrentNumber rem 1000 =:= 0 of
           true -> io:format("~p -> ~p divisors~n", [CurrentNumber, Divisors]);
                false -> ok
        end,
        case Divisors of
                D when D > RequestedNumberOfDivisors ->
                        {ok, D};
                _ ->  findSolution(RequestedNumberOfDivisors, Primes, CurrentNumber + 1)
        end.


solve(RequestedNumberOfDivisors)->
        Primes = erasto:sieve(75000),

        Number = findSolution(RequestedNumberOfDivisors, Primes, 1),

        Number.

main(_)->
        io:format("~p~n", [test(erasto:sieve(1000000),2,1)])
%%         io:format("~p~n", [factorize(erasto:sieve(50), 28)])
.