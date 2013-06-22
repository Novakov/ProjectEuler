-module(problem11).

-mode(compile).

-export([main/1, calc/2]).

vertical(Data) ->
	lists:foldr(fun(R, T) -> T * lists:nth(1, R) end, 1, Data).

horizontal(Data) ->
	Row = lists:nth(1, Data),
	lists:foldr(fun(R, T) -> T * R end, 1, Row).
	
crossUpLeft(Data) ->
	crossUpLeft(Data, length(Data), 1).
	
crossUpLeft(Data, 0, Acc) ->
	Acc;
crossUpLeft(Data, Rem, Acc) ->
	Row = lists:nth(Rem, Data),
	NewAcc = Acc * lists:nth(Rem, Row),
	crossUpLeft(Data, Rem - 1, NewAcc).
	
crossDownLeft(Data) ->
	crossDownLeft(Data, length(Data), 1).
	
crossDownLeft(Data, 0, Acc) ->
	Acc;
crossDownLeft(Data, Rem, Acc) ->
	Row = lists:nth(Rem, Data),
	NewAcc = Acc * lists:nth(length(Data) - Rem + 1, Row),
	crossDownLeft(Data, Rem - 1, NewAcc).
	
calc(From, Data) ->
	Max = max(vertical(Data), horizontal(Data)),
	Cross = max(crossUpLeft(Data), crossDownLeft(Data)),
	Result = max(Max, Cross),
	From ! {done, Result, Data}.

display([]) -> 
	ok;
display([H|T]) -> 
	io:format("~w\n", [H]),
	display(T).

slice(Data, X, Y, Len) ->
	Rows = lists:sublist(Data, Y + 1, Len),
	lists:map(fun (R) -> lists:sublist(R, X +1, Len) end, Rows).
	
spawnSlices(Data, X, Y, Len, AlreadySpawn) 
	when X + Len > length(Data) ->
	spawnSlices(Data, 0, Y+1, Len, AlreadySpawn);
spawnSlices(Data, _, Y, Len, AlreadySpawn) 
	when Y + Len > length(Data) ->
	AlreadySpawn;
	
spawnSlices(Data, X, Y, Len, AlreadySpawn) ->	
	Slice = slice(Data, X, Y, Len),	
	spawn_link(?MODULE, calc, [self(), Slice]),
	
	spawnSlices(Data, X+1, Y, Len, AlreadySpawn + 1).
	
receiveResults(_, 0, Results) ->
	Results;
receiveResults(F, Remaining, Result) ->
	receive 
		{done, Res, Slice}-> 
				io:format("."), 				
				io:format(F, "~p\t~w~n", [Res, Slice]),
				receiveResults(F, Remaining - 1, max(Res, Result))		
	end.
	
readData(Device, Lines) ->
	case file:read_line(Device) of
		eof -> Lines;
		{ok, Line} ->
			 StrNumbers = re:split(string:strip(Line, right, 10), "\s+", [notempty]),
			 Nums = lists:map(fun erlang:list_to_integer/1, lists:map(fun erlang:binary_to_list/1, StrNumbers)),
			 readData(Device,  Lines ++ [Nums])
	end.
	
main(_)->
	{ok, File} = file:open("data11.txt", read),
	Data = readData(File, []),
	%display(Data)
	Spawn = spawnSlices(Data, 0,0, 4, 0),
	io:format("Spawn slices: ~p~n", [Spawn]),
	{ok,F} = file:open("res.txt", write),
	Result = receiveResults(F, Spawn, 0),
	file:close(F),
	io:format("~nResult = ~p~n", [Result])
	.