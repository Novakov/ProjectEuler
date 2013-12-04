%% Copyright
-module(problem12).
-author("Novakov").

-import(commons, [factors/1]).

%% API
-export([main/1]).

solve(CurrentNumber, Sum) ->
        Factors = factors(Sum),
        Count = lists:flatlength(Factors),
        io:format("~p~n", [Count]),
        case Count of
                500 -> CurrentNumber;
                _ -> solve(CurrentNumber+1, Sum + CurrentNumber)
        end.

solve() ->
        solve(1, 1).

main(_) ->
        io:format("~p~n", [solve()]).
