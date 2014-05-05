-module(exercise_3_9).

-export([readfile_into_rawdocument/1]).
-export([readfile_into_document/1]).
-export([index/1]).

%% readfile_into_rawdocument
readfile_into_rawdocument(Filename) ->
    {_ok, Device} = file:open(Filename, [read]),
    get_all_lines(Device, []).

%% readfile_into_document
readfile_into_document(Filename) ->
    Raw_document = readfile_into_rawdocument(Filename),
    exercise_3_5:concatenate(lists:map(fun(String) ->
        string:tokens(String, "-()_0123456789.[]/,<>\\ {}=:\";+-%~~|")
    end, Raw_document)).

% AUX: get_all_lines
get_all_lines(Device, L) ->
    case io:get_line(Device, "") of
        eof -> L;
        Line -> get_all_lines(Device, L ++ [re:replace(Line, "\\n", "", [global, {return, list}])])
    end.

% index
index(L) -> beautify_tuple_list(index(L, [], 1)).

index([], L, _X) -> L;
index([H | T], L, X) ->
    case lists:keyfind(H, 1, L) of
        {K, V} -> NL = lists:keyreplace(H, 1, L, {K, V ++ [X]});
        false -> NL = [{H, [X]} | L]
    end,
    index(T, NL, X + 1).

% beautify
beautify([H | T]) -> beautify(T, [], H, H).

beautify([], Bea, Init, PrevH) -> Bea ++ [{Init, PrevH}];

beautify([H | T], Bea, Init, PrevH) when (H == PrevH) or (H == PrevH + 1) -> beautify(T, Bea, Init, H);
beautify([H | T], Bea, Init, PrevH) -> beautify(T, Bea ++ [{Init, PrevH}], H, H).

% stringify_tuple_list
stringify_tuple_list(L) -> stringify_tuple_list(L, "", "").

stringify_tuple_list([], Str, _Comma) -> Str;
stringify_tuple_list([H | T], Str, Comma) -> stringify_tuple_list(T, Str ++ io_lib:format("~s~B-~B", [Comma, element(1, H), element(2, H)]), ", ").

% beautify_tuple_list
beautify_tuple_list(L) -> beautify_tuple_list(L, []).

beautify_tuple_list([], Bea) -> io:format("~s", [Bea]);
beautify_tuple_list([H | T], Bea) -> beautify_tuple_list(T, Bea ++ [io_lib:format("~.20s~s~s", [element(1, H), stringify_tuple_list(beautify(element(2, H))), "\n"])]).

