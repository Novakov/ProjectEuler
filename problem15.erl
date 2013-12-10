%% Copyright

%%! -c
-module(problem15).
-author("Novakov").

%-behaviour(enumerable).

-import(enumerable,[yield/1]).
-import(commons, [factorial/1]).

%% API
-export([main/1, enumerate/1]).

enumerate({Size, 0, 0, _}) ->
        enumerate({Size, 0, 1, [{0,0}]}),
        enumerate({Size, 1, 0, [{0,0}]}),
        ok;
enumerate({Size, X, Y, Route}) when {X,Y} =:= {Size, Size} ->
        yield({value, Route ++ [{X,Y}]});

enumerate({Size, 0, Size, Route}) ->
        enumerate({Size, 1, Size, Route ++ [{0, Size}]});
enumerate({Size, 0, Y, Route}) ->
        enumerate({Size, 1, Y, Route ++ [{0, Y}]}),
        enumerate({Size, 0, Y+1, Route ++ [{0, Y}]});

enumerate({Size, X, Size, Route}) ->
        enumerate({Size, X+1, Size, Route ++ [{X, Size}]});

%% enumerate({Size, X, 0, Route}) ->
%%         enumerate({Size, X, })

enumerate({Size, Size, Y, Route}) ->
        enumerate({Size, Size, Y +1, Route ++ [{Size, Y}]});

enumerate({Size, X, Y, Route}) when (X < Size) and (Y < Size) ->
        enumerate({Size, X + 1, Y, Route ++ [{X, Y}]}),
        enumerate({Size, X , Y + 1, Route ++ [{X, Y}]});

enumerate({_, X, Y, _}) ->io:format("P(~p, ~p)~n",[X,Y]).

%% search(Size, {Size - 1, Size - 1}, Route) ->
%%         Route;
%% search(Size, {0, 0}, Route)->
%%         A = search(Size, {0, 1}, Route),
%%         B = search(Size, {1, 0}, Route),
%%         Route ++ A ++ B.
%% search(Size, {0, Size - 1}, Route) ->
%%         Route ++.

brute_solve(Size) ->
        E = enumerable:start(?MODULE, {Size, 0, 0, []}),
        %List= enumerable:to_list(E),
        %Count = length(List),
        Count = enumerable:count(E),
        Count.

solve(N) ->
        factorial(2 * N) / math:pow(factorial(N), 2).

main([N]) ->
        code:add_pathz("enumerable"),
        io:format("~p~n", [solve(list_to_integer(N))]).
