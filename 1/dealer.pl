/*******************************
* Implementacion de soft_dealer 
*******************************/
soft_dealer(Hand):-
	hand(Hand, Value),
	Value < 17,
	not(hand(Hand, 17)).


/*******************************
* Implementacion de hard_dealer 
*******************************/
hard_dealer(Hand):-
	hand(Hand, 17),
	hand(Hand, 7) .

hard_dealer(Hand):- 
	hand(Hand, Value),
	Value < 17.
