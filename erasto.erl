%% Copyright
-module(erasto).
-author("Novakov").

%% API
-export([erasto/1, main/1, sieve/1]).

filter(Acc, []) ->
                Acc;
filter(Acc, [H|Tail]) ->
        NewTail = lists:filter(fun(X) -> X rem H =/= 0 end, Tail),
        filter([H|Acc], NewTail).

expand(Acc, _, []) ->
                Acc;
expand(Acc, N, [H|Tail])
        when N rem H =:= 0 ->
        expand([H|Acc], N div H, [H|Tail]);
expand(Acc, N, [_|Tail]) ->
        expand(Acc, N, Tail).


erasto(N)->
        Possible = lists:seq(2, erlang:trunc((N))),

        PreFiltered = lists:filter(fun(X)-> N rem X =:= 0 end, Possible),

        PrimeFactors = filter([], PreFiltered),

        Expanded = expand([], N, PrimeFactors),

        Expanded.

reduce(Acc, []) -> Acc;
reduce(Acc, [H|T]) ->
        Filtered = lists:filter(fun(X) -> X rem H =/= 0 end, T),
        %io:format("~p~n", [Filtered]),
        reduce(Acc ++ [H], Filtered).


sieve(Max) ->
        Numbers = lists:seq(2, Max),

        Primes = reduce([], Numbers),

        Primes.

main(_) ->
        io:format("~p~n", [sieve(20)]).