% Define operators for arithmetic expressions
:- op(500, xfy, [plus, minus]).
:- op(400, yfx, [times, divided_by]).

% Define evaluation of arithmetic expressions
eval(Num, Num) :- number(Num).          % Numbers are evaluated as themselves
eval(Var, Result) :- atom(Var),         % Variables need to be assigned
                    var_value(Var, Result).  % Fetch the assigned value
eval(X + Y, Result) :- eval(X, X1), eval(Y, Y1), Result is X1 + Y1.
eval(X - Y, Result) :- eval(X, X1), eval(Y, Y1), Result is X1 - Y1.
eval(X * Y, Result) :- eval(X, X1), eval(Y, Y1), Result is X1 * Y1.
eval(X / Y, Result) :- eval(X, X1), eval(Y, Y1), Result is X1 / Y1.

% Support for parenthesis
eval('(' + X + ')', Result) :- eval(X, Result).
eval('(' - X + ')', Result) :- eval(X, Result).
eval('(' * X + ')', Result) :- eval(X, Result).
eval('(' / X + ')', Result) :- eval(X, Result).

% Assign variable to an expression
assign(Var, Expr) :- eval(Expr, Value), assertz(var_value(Var, Value)).

% Fetch the value of a variable
get_value(Var, Value) :- var_value(Var, Value).

% Example Usage:
% assign(X, 5).
% assign(Y, 3).
% eval(X + Y, Result). % Result will be 8.
