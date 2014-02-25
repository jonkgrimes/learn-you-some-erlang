-module(hhfuns).
-compile(export_all).

one() -> 1.
two() -> 2.

add(X,Y) -> X() + Y().

increment([]) -> [];
increment([H|T]) -> [H+1|increment(T)].

decrement([]) -> [];
decrement([H|T]) -> [H-1|decrement(T)].

map(_, []) -> [];
map(F, [H|T]) -> [F(H)|map(F,T)].

incr(X) -> X + 1.
decr(X) -> X - 1.

filter(Pred, L) -> lists:reverse(filter(Pred,L,[])).

filter(_, [], Acc) -> Acc;
filter(Pred, [H|T], Acc) ->
  case Pred(H) of
    true -> filter(Pred, T, [H|Acc]);
    false -> filter(Pred, T, Acc)
  end.

fold(_, Start, []) -> Start;
fold(F, Start, [H|T]) -> fold(F, F(H,Start), T).

%% this blows my mind a litte
%% all the above functions can be represented with fold/3
reverse(L) ->
  fold(fun(X,Acc) -> [X|Acc] end, [], L).

map2(F,L) ->
  reverse(fold(fun(X,Acc) -> [F(X)|Acc] end, [], L)).

filter2(Pred,L) ->
  F = fun(X,Acc) ->
      case Pred(X) of
        true -> [X|Acc];
        false -> Acc
      end
    end,
  reverse(fold(F, [], L)).
