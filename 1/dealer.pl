

/*******************************
* Implementacion de soft_dealer 
*******************************/
soft_dealer(Hand):-
	mejor_jugada(Hand, MejorValor),
	MejorValor < 17,
	format('hit',[]),
	nl.

soft_dealer(_):- 
	format('stand',[]),
	nl.

/*******************************
* Implementacion de hard_dealer 
*******************************/
hard_dealer(Hand):-
	mejor_jugada(Hand, 17),
	hand(Hand, 7),
	format('hit',[]),
	nl.

hard_dealer(Hand):- 
	mejor_jugada(Hand, MejorValor),
	MejorValor < 17,
	format('hit',[]),
	nl. 

hard_dealer(_):- 
	format('stand',[]),
	nl.
