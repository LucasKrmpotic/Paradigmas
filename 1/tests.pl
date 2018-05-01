%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%			UNIT TESTS 			 %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%	Despues vemos como pasarlo a otro
%	archivo onda 'tests.pl'.
%
%	Para ejecutar ingresar en la linea de comandos
%	
%	run_tests.
%

:- begin_tests(blackJack).

test(hand):-
	hand([card(a,_), card(k,_)], 21),
	hand([card(a,_), card(k,_)], 11),
	hand([card(a,_), card(k,_), card(3,_), card(10,_), card(8,_)], 32).

test(twentyOne):-
	twentyOne([card(a,_), card(k,_)]),
	twentyOne([card(a,_), card(k,_), card(j,_)]),
	twentyOne([card(3,_), card(6,_), card(j,_), card(2,_)]).

test(over):-
	over([card(k,_), card(k,_), card(3,_)]).

test(blackJack):-
	blackJack([card(a,_), card(10,_)]).

test(soft_dealer):-
	not(soft_dealer([card(6,_), card(a,_)])).

test(hard_dealer):-
	hard_dealer([card(6,_), card(a,_)]).

test(hard_dealer):-
	hard_dealer([card(6,_), card(a,_)]).

test(mano_mas_alta_optima):-
	mano_mas_alta_optima([card(a,_), card(k,_), card(3,_), card(10,_), card(8,_)], 0),
	mano_mas_alta_optima([card(a,_), card(a,_), card(3,_), card(10,_), card(2,_)], 17).

:- end_tests(blackJack).