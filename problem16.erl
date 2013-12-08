-module(problem16).

-import(commons, [sumOfDigits/2]).

-export([main/1]).

power(Base, 0, Acc) -> Acc;
power(Base, Exp, Acc) ->
	power(Base, Exp - 1, Acc * Base).


solve() ->
	P = power(2, 1000, 1),
        sumOfDigits(P, 0).

main(_) -> 
	io:format("~p~n", [solve()]).
