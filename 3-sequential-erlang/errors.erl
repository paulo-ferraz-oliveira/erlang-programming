-module(errors).

-export([function_clause/1]).
-export([case_clause/1]).
-export([if_clause/1]).
-export([badmatch/0]).
-export([badarg/0]).
-export([badarith/0]).

% call
%     errors:function_clause(-1)
% in the Erlang shell to provoke the function_clause error.
%%
%% output
%     ** exception error: no function clause matching errors:function_clause(-1) (errors.erl, line 12)
function_clause(N) when N > 0 -> N * function_clause(N - 1);
function_clause(0) -> 1.

% call
%     errors:case_clause(0)
% in the Erlang shell to provoke the case_clause error.
%%
%% output
%    ** exception error: no case clause matching 0
%         in function  errors:case_clause/1 (errors.erl, line 23)
case_clause(N) ->
    case N of
        -1 -> false;
        1 -> true
    end.

% call
%     errors:if_clause(0)
% in the Erlang shell to provoke the if_clause error.
%%
%% output
%    ** exception error: no true branch found when evaluating an if expression
%         in function  errors:if_clause/1 (errors.erl, line 37)
if_clause(N) ->
    if
        N < 0 -> true;
        N > 0 -> false
    end.

% call
%     errors:badmatch()
% in the Erlang shell to provoke the badmatch error.
%%
%% output
%    ** exception error: no match of right hand side value {23,45}
%         in function  errors:badmatch/0 (errors.erl, line 50)
badmatch() ->
    N = 45,
    {N, _M} = {23, 45}.

% call
%     errors:badarg()
% in the Erlang shell to provoke the badarg error.
%%
%% output
%    ** exception error: bad argument
%         in function  errors:badarg/0 (errors.erl, line 61)
badarg() ->
    length(hello_world). % There is already a warning at compile time.

% call
%     errors:undef()
% in the Erlang shell to provoke the undef error.
%%
%% output
%    ** exception error: undefined function errors:undef/0

% call
%     errors:badarith()
% in the Erlang shell to provoke the badarith error.
%%
%% output
%    ** exception error: an error occurred when evaluating an arithmetic expression
%         in function  errors:badarith/0 (errors.erl, line 79)
badarith() ->
    1 + a. % There is already a warning at compile time.
