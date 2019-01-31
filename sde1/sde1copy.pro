
/* 
Richard Coffey
rrcoffe
ECE-352
SDE1
*/






table(sample_table4,[
[["11"],["21"],["31"],["41"]],
[["12"],["22"],["32"]],
[["13"],["23"]],
[["14"]]
]).

table(book_result,[
[["A"], ["A"], ["B", "C"], ["B", "C"]],
[["C"], ["S", "A"], ["S", "B", "A"]],
[["C", "A"], ["C", "S", "A"]],
[["C", "B", "S", "A"]]
]).

table(book3,[
[["A"], ["A"], ["B", "C"], ["B", "C"]],
[["C"], ["S", "A"], ["S", "B", "A"]],
[["C", "A"], ["C", "S", "A"]],
[["A", "S", "B", "C"]]
]).

table(bookbad1,[
[["A"], ["A"], ["B", "C"], ["B", "C"]],
[["C"], ["S", "A"], ["S", "B", "A"]],
[["C", "A"], ["C", "S", "A"]],
[["C", "B", "S", "G"]]
]).

productions(book, [["S","AB"],["S","BB"],["A","CC"],["A","AB"],["A","a"],
["B","BB"],["B","CA"],["B","b"],["C","BA"],["C","AA"],["C","b"]]).



/*
get_table_values_cell/3 
Prototype: get_table_values_cell([+I, +J], +Table, -ContentsL).
*/


get_table_values_cell([I,J], Table, CL):- 
    nth1(J,Table,RL), 
    nth1(I,RL,CL).




/*decompositions/2 
Prototype: decompositions(+N, -List_of_decomposition_sublists)
*/

%concat two opposited numlist lists? **numlist doesn't generate backwards
%could try a findall for a numlist by concat-ing opposites to elements?
%
%this should append to list here, what am I missing?


recursive_decompositions(0, [], []).
recursive_decompositions(X, Y, List):-
    X is X-1, 
    Y is Y+1,
    recursive_decompositions(X, Y, List2), 
    append([X,Y], List2, List).
  
decompositions(N, CL):-
    recursive_decompositions(1, N, CL).
    

/*one_product/3
Prototype: one_product(+Nonterminal, +Cell, -Product).
*/


one_product(NT, Cell, Product) :-
    findall(List, (member(X,Cell), string_concat(NT,X,List)),Product).




/*cell_product/3
Prototype: cell_products(+Cell1, +Cell2, -Product).
Use one_product line here but add second case to goal
*/



cell_products(Cell1, Cell2, Product) :-
    findall(List, (member(X, Cell1), member(Y, Cell2), string_concat(X,Y,List)), Product).




/*form_row1_cell/3
Prototype: form_row1_cell(+StringElement, +ProductionsList, -Row1Cell).
***3rd case needed a cut to stop choice points like the second one, dummy
*/

cell(_,[],[]).
cell(A, [[X,Y]|T],[RH|RT]):- 
    member(A,[X,Y]), !, %cut here to stop choice points
    RH=X, 
    cell(A,T,RT).

cell(A,[_|T],L):- 
    cell(A,T,L), !. %cut here again to stop choice points

form_row1_cell(StringElement, ProductionsList, Row1Cell):-
    cell(StringElement, ProductionsList, Row1Cell).





/*equivalent/2
Prototype: equivalent(+A, +B).
*/

equivalent(X,Y):- 
    sort(X, XS), 
    sort(Y, YS), 
    XS == YS.





/*row_equivalent/2
Prototype: row_equivalent(+RowA, +RowB)
*/

row_equivalent([],[]).   
row_equivalent([H1|T1],[H2|T2]):-
    equivalent(H1,H2),
    row_equivalent(T1,T2).





/*table_equivalent/2
Prototype: table_equivalent(+TableA, +TableB).
DOES NOT OUTPUT TRUE when predicate works, jeez louise that took forever to figure out
*/


table_equivalent([], []).
table_equivalent([H1|T1],[H2|T2]):-
    row_equivalent(H1,H2),
    table_equivalent(T1,T2).













