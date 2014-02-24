-module(cases).
-export([insert/2,beach/1]).

insert(X,[]) ->
  [X];
insert(X,Set) ->
  case lists:member(X,Set) of
    true -> Set;
    false -> [X|Set]
  end.

beach(Temprature) ->
  case Temprature of
    { celsius, N } when N >= 20, N =< 45 ->
      'favorable';
    { kelvin, N } when N >= 294, N =< 318 ->
      'scientifically favorable';
    { fahrenheit, N } when N >= 68, N =< 113 ->
      'favorable in the US';
    _ ->
      'avoid beach'
  end.
