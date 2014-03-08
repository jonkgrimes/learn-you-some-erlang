-module(my_behavior).
-export([behavior_info/1]).

behavior_info(callbacks) -> [{init,1},{some_fun,0},{other,3}];
behavior_info(_) -> undefined.
