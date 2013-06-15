%% Copyright
-module(problem5).
-author("Novakov").

-mode(compile).

-import(commons, [is_prime/1]).

%% API
-export([main/1]).

factorize(N) ->
        factorize(N, 2, []).

factorize(N, D, Acc) when D =< N ->
        case is_prime(D) andalso (N rem D =:= 0) of
                false -> factorize(N, D + 1, Acc);
                true -> NewAcc = [D | Acc],
                        factorize(N div D, D, NewAcc)
        end;
factorize(N, D, Acc) when D > N ->
        Acc.

reduce(Factors) ->
        reduce(Factors, []).

reduce([Factor | Factors], [{Factor, N} | Acc]) ->
        reduce(Factors, [{Factor, N + 1} | Acc]);
reduce([Factor | Factors], Acc) ->
        reduce(Factors, [{Factor, 1} | Acc]);
reduce([], Acc) ->
        Acc.

accumulate({Factor, Multi}, Acc) ->
        case lists:keyfind(Factor, 1, Acc) of
                false -> [{Factor, Multi} | Acc];
                {_, Existing} -> lists:keystore(Factor, 1, Acc, {Factor, max(Existing, Multi)})
        end.

maxPrimeFactors(N) ->
        maxPrimeFactors(N, []).

maxPrimeFactors(0, Acc) ->
        Acc;
maxPrimeFactors(N, Acc) ->
        PrimeFactors = reduce(factorize(N)),
        NewAcc = lists:foldr(fun accumulate/2, Acc, PrimeFactors),
        maxPrimeFactors(N - 1, NewAcc).

solve(N)->
        PrimeFactors = maxPrimeFactors(N),
        lists:foldr(fun ({Factor, Multi}, T) -> T * math:pow(Factor, Multi) end, 1, PrimeFactors).

main(_) ->
        io:format("~p\n", [solve(20)]).

% Correct answer:
%% 12252240
%%

%11,7,5,5,5,3,3,3,3,2,2 =  3118500
%{2,2}, {3,4}, {5,3}, {7,1},{11,1}