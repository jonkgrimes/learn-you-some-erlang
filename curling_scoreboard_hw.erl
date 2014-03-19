-module(curling_scoreboard_hw).
-export([add_point/1,next_round/0,set_teams/2,reset_board/0]).

%% This is simply a dumb endpoint of where a hardware controller would go

set_teams(TeamA,TeamB) ->
  io:format("Scoreboard: Team ~s vs. Team ~s~n", [TeamA,TeamB]).

next_round() ->
  io:format("Scoreboard: round over~n")
