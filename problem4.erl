%% Copyright
-module(problem4).
-author("Novakov").

-mode(compile).
%% API
-export([main/1]).

split(N) ->
        split(N, []).

split(N, Acc)
        when N =< 9 ->
        [N | Acc];
split(N, Acc) ->
        Digit = N rem 10,
        Rest = N div 10,
        split(Rest, [Digit | Acc]).

are_equal([H_X | T_X], [H_Y | T_Y])
        when H_X == H_Y ->
        are_equal(T_X, T_Y);
are_equal([], []) ->
        true;
are_equal(_, _) ->
        false.

is_palindrome(N) ->
        Digits = split(N),
        DigitsReverse = lists:reverse(Digits),
        are_equal(Digits, DigitsReverse).

cross(L1, L2) ->
        Products = lists:map(fun(E1) -> lists:map(fun(E2) -> {E1, E2} end, L2) end, L1),
        lists:flatten(Products).

solve(Max) ->
        Num1 = lists:seq(1, Max),
        Num2 = lists:seq(1, Max),
        Numbers = lists:map(fun({A, B}) -> A * B end, cross(Num1, Num2)),
        Palindromes = lists:filter(fun is_palindrome/1, Numbers),
        lists:max(Palindromes).

main(_) ->
        io:format("~p\n", [solve(999)]).

