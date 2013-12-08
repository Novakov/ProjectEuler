%% Copyright
-module(problem14).
-author("Novakov").

%% API
-export([main/1, collect/2]).

next(1) -> done;
next(N) when N rem 2 =:= 0 ->
        N div 2;
next(N) ->
        3 * N + 1.


generate(N, State, Callback) ->
        Next = next(N),
        case Next of
           done -> State;
           X -> generate(Next, Callback(State, X), Callback)
        end.

countLength(StartFrom) ->
        generate(StartFrom, 1, fun(S, _) -> S +1 end).

iterate(To, To, State, Callback) ->
          Callback(State, To);
iterate(From, To, State, Callback) ->
        iterate(From + 1, To, Callback(State, From), Callback).

collect({Number, Length}, I) ->
        X = countLength(I),
        case Length < X of
                true -> {I, X};
                false -> {Number, Length}
        end.

solve() ->
        iterate(1,1000000, {0, -1}, fun ?MODULE:collect/2).

main(_)->
        io:format("~p~n",[solve()]).
