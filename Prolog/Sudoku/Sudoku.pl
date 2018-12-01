numbers([1,2,3,4,5,6,7,8,9]).
columns(Columns) :- numbers(Columns).
rows(Rows) :- numbers(Rows).
valid_num(Num) :- numbers(Numbers), member(Num, Numbers).

valid_row(List) :- length(List, 9), valid_row(List, []).
valid_row([], Already_Seen) :- length(Already_Seen, 9).
valid_row([First|List], Already_Seen) :- numbers(Numbers), member(First, Numbers), not(member(First, Already_Seen)), valid_row(List, [First|Already_Seen]).

all_rows_valid(Matrix) :- maplist(valid_row, Matrix).

get_column_values([], _, []).
get_column_values([FirstRow|Matrix], ColI, Result) :- nth1(ColI, FirstRow, ColEle), get_column_values(Matrix, ColI, NextResult), Result = [ColEle|NextResult].

% test: numbers(Numbers), transpose([Numbers,Numbers], X).
transpose(Matrix, Result) :- columns(Columns), transpose(Matrix, Columns, Result).
transpose(_Matrix, [], []).
transpose(Matrix, [ColI|Cols], Result) :- get_column_values(Matrix, ColI, CurrentColumn), transpose(Matrix, Cols, NextResult), Result = [CurrentColumn|NextResult].

all_cols_valid(Matrix) :- transpose(Matrix, TransMatrix), maplist(valid_row, TransMatrix).

block_definition(BlockIndex, Rows, Cols) :- 
    BlockX = (BlockIndex - 1) mod 3,
    BlockY = (BlockIndex - 1) // 3,
    R1 is (BlockY * 3) + 1, R2 is (BlockY * 3) + 2, R3 is (BlockY * 3) + 3,
    Rows = [R1, R2, R3],
    C1 is (BlockX * 3) + 1, C2 is (BlockX * 3) + 2, C3 is (BlockX * 3) + 3,
    Cols = [C1, C2, C3].

% test: numbers(Numbers), get_block_values([Numbers,Numbers,Numbers,Numbers,Numbers,Numbers,Numbers,Numbers,Numbers], 3, X).
get_block_values([[]], _BlockIndex, []).
get_block_values(Matrix, BlockIndex, Result) :- 
    block_definition(BlockIndex, SelectedRows, SelectedCols), 
    internal_get_values(Matrix, SelectedRows, SelectedCols, Result).

internal_get_values(Matrix, SelectedRows, SelectedCols, Result) :- 
    rows(AllRows), 
    internal_get_values_of_row(Matrix, SelectedRows, SelectedCols, AllRows, Result).

internal_get_values_of_row(_, _, _, [], []).
internal_get_values_of_row([], _, _,_,  []).
internal_get_values_of_row([FirstRow|Matrix], SelectedRows, SelectedCols, [CurrentRow|AllRows], Result) :- 
    internal_get_values_of_row(Matrix, SelectedRows, SelectedCols, AllRows, NextResult),
    (member(CurrentRow, SelectedRows) -> 
        columns(Columns), 
        internal_get_values_of_column(FirstRow, SelectedCols, Columns, CurrentRowResult),
        Result = [CurrentRowResult|NextResult]
        ;
        Result = NextResult
    ). 

    
internal_get_values_of_column(_, _, [], []).
internal_get_values_of_column(SelectedRow, SelectedCols, [CurrentColumn|AllColumns], Result) :- 
    internal_get_values_of_column(SelectedRow, SelectedCols, AllColumns, NextResult),
    (member(CurrentColumn, SelectedCols) -> 
        nth1(CurrentColumn, SelectedRow, CurrentElem),
        Result = [CurrentElem|NextResult]
        ;
        Result = NextResult
    ). 

sudokufeld(Matrix) :- all_cols_valid(Matrix), all_rows_valid(Matrix).

% Usage: example_sudoku_feld(Matrix, A, B, C, D, E, F, G, H, I, J, K), sudokufeld(Matrix).
example_sudoku_feld([
    [1,2,3,4,5,E,7,8,J],
    [2,F,4,5,6,7,8,9,1],
    [I,4,5,A,7,8,9,C,2],
    [4,5,6,7,8,9,H,2,3],
    [5,6,D,8,9,1,2,3,4],
    [G,7,8,9,1,B,3,4,5],
    [7,8,9,1,2,3,K,5,6],
    [8,9,1,2,3,4,5,6,7],
    [9,1,2,3,4,5,6,7,8]
], A, B, C, D, E, F, G, H, I, J, K).

% get_block_values([], _, []).
% get_block_values(([FirstRow|Matrix], ColI, Result)).

% two_dim_length([Firstrow|Matrix], Cols, Rows) :- length(Matrix, New_Rows), length(Firstrow, Cols), two_dim_length(Matrix, Cols, New_Rows), New_Rows is Rows - 1.

% sudokufeld(Matrix) :- two_dim_length(Matrix, 9, 9).

% tester([[]], _BlockIndex, []).