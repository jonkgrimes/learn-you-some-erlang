-module(functions).
-compile(export_all). %% TODO: replace with -export() later

head([H|_]) -> H.

tail([_|T]) -> T.

second([_,X|_]) -> X.

same(X,X) ->
  true;

same(_,_) ->
  false.

valid_time({Date = {Y,M,D},Time = {H,Min,S}}) ->
  io:format("The date tuple (~p) says today is: ~p/~p/~p,~n",[Date,Y,M,D]),
  io:format("The time tuple (~p) indicates: ~p:~p:~p.~n",[Time,H,Min,S]);
valid_time(_) ->
  io:format("Stop feeding me wrong data!~n").
