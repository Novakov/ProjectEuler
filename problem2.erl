%% Copyright
-module(problem2).
-author("Novakov").

-mode(compile).
%% API
-export([main/1]).

fibo(Max)->
    fibo(Max, [2, 1,1]).

fibo(Max, [P1 | T])
        when P1 > Max ->
        T;
fibo(Max, [P1 | [P2 | T]]) ->
        Elem = P1 + P2,
        Arr = [Elem | [P1 | [P2 | T]]],
        fibo(Max, Arr).

solve(Max)->
        Fibo = fibo(Max),
        Even = lists:filter(fun(X)->X rem 2 == 0 end, Fibo),
        lists:foldr(fun(X,T)->X+T end, 0, Even).

main(_)->
        io:format("~p\n", [solve(4000000)]).
