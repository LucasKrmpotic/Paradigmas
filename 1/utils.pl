/********************************************
 *  
 * Implementación de las reglas enunciadas en 
 * los objetivos preliminares.
 *
 ********************************************/

/***************************
* Implementacion de hand 
****************************/
hand([],0).
hand([card(N,_)|Resto],Valor):- 
	value(card(N,_),Valor1),
    hand(Resto,Valor2),
    Valor is Valor1+Valor2.


/******************************
* Implementacion de twentyOne 
*******************************/
twentyOne(Mano):- 
	hand(Mano,ValorMano),
    ValorMano = 21.

/*************************
* Implementacion de over 
**************************/
over(Mano):- 
	hand(Mano,ValorMano),
    ValorMano > 21.

/******************************
* Implementacion de blackJack 
*******************************/
blackJack(Mano):- 
	length(Mano, Len),
    Len = 2,
    hand(Mano,ValorMano),
    ValorMano = 21.