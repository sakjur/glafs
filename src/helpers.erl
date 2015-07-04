-module(helpers).
-export([read_n/3, read_until/3, hexstring/1]).

read_n(List, 0, Result) -> {lists:reverse(Result), List};
read_n([], _, Result) -> {lists:reverse(Result), []};
read_n([H | T], N, Result) -> read_n(T, N-1, [H | Result]).

read_until([Stop | T], Stop, Result) -> {lists:reverse(Result), T};
read_until([], _, _) -> error;
read_until([H | T], Stop, String) ->
    read_until(T, Stop, [H | String]).

hexstring(<<SHA1Bin:160/big-unsigned-integer>>) ->
    lists:flatten(io_lib:format("~40.16.0b", [SHA1Bin])).

