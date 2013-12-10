%% Copyright

%%! -c
-module(problem22).
-author("Novakov").

%% API
-export([main/1]).

name_score([], Total) -> Total;
name_score([H|T], Total) ->
        name_score(T, Total + H - $A + 1).

sum_scores(Position, [], Total) -> Total;
sum_scores(Position, [Name|Rest], Total) ->
        Score = name_score(Name, 0),

        sum_scores(Position + 1, Rest, Total + Position * Score).

solve() ->
        {ok, Data} = file:open("data22.txt", read),
        {ok, Line} = file:read_line(Data),
        file:close(Data),

        Strip = fun(Name) ->
            string:strip(Name, both, $")
        end,

        Names = lists:sort(lists:map(Strip, string:tokens(Line, ","))),

        sum_scores(1, Names, 0).

main(_)  ->
        io:format("~p~n", [solve()]).