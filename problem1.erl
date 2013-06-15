-module(problem1).
-author("Novakov").

-mode(compile).

-export([main/1]).

applicable(X) when X rem 3 == 0  ->
        true;
applicable(X)
        when X rem 5 == 0  ->
        true;
applicable(_) ->
        false.

sums(N)->
       Numbers = lists:seq(1, N - 1),
       Dividable = lists:filter(fun applicable/1, Numbers),
       lists:foldr(fun(X, T)->T+X end, 0, Dividable).

main(_)->
        io:format("~p \n", [sums(1000)])
        .