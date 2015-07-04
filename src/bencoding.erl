-module(bencoding).
-export([parse/1]).

parse(List) ->
    {Item, _} = item(List),
    Item.

item([$e | T]) -> {stop, T};
item([$i | T]) -> 
    bencoding_integer(T);
item([H | T]) when (H >= $0) and (H =< $9) -> 
    string([H | T]);
item([$l | T]) ->
    list(T, []);
item([$d | T]) ->
    dict(T, dict:new());
item(_) -> error.

list(Input, List) ->
    {Item, Rest} = item(Input),
    case Item of
        stop -> {List, Rest};
        _ -> list(Rest, List ++ [Item])
    end.

string(List = [H | _]) when (H >= $0) and (H =< $9) ->
    {StrN, Rest1} = helpers:read_until(List, $:, []),
    N = list_to_integer(StrN),
    helpers:read_n(Rest1, N, []);
string(_) ->
    error.

pieces(List) ->
    {StrN, Rest1} = helpers:read_until(List, $:, []),
    N = list_to_integer(StrN),
    pieces_loop(Rest1, N, []).
pieces_loop(List, 0, Finished) ->
    {Finished, List};
pieces_loop(List, N, Finished) ->
    SHA_Len = 20,
    {SHA1_Raw, Rest} = helpers:read_n(List, SHA_Len, []),
    SHA1_Pretty = helpers:hexstring(list_to_binary(SHA1_Raw)),
    pieces_loop(Rest, N-SHA_Len, Finished ++ [SHA1_Pretty]).

bencoding_integer(List) ->
    {StrInt, Rest} = helpers:read_until(List, $e, []),
    {list_to_integer(StrInt), Rest}.

dict(Input, Dict) ->
    {Key, Rest0} = item(Input),
    case Key of
        stop -> {Dict, Rest0};
        "pieces" ->
            {Val, Rest1} = pieces(Rest0),
            dict(Rest1, dict:append(Key,Val, Dict));
        _ ->
            {Val, Rest1} = item(Rest0),
            dict(Rest1, dict:append(Key, Val, Dict))
    end.

