
/*************************************************************
 *  	
 * 	Estas reglas utilitarias unifican una mano de blackjack 
 *  con su valor más cercano a 21. 
 *  
 * 	Inicialmente mejor_jugada/2 crea una lista con los todos 	
 *  los valores posibles dada una mano. 
 *  
 *  Luego mejor_valor_mano/3 unifica la lista con el valor más cercano
 *  a 21. 
 * 
 *************************************************************/

/**
 *  Caso Base: ListaValoresDeLaMano es vacía entonces MejorValor es
 * 	el actual.
 */
mejor_valor_mano([], MejorValor, MejorValor):-
	MejorValor = MejorValor, 
	!.

/**
 * Caso Base: cabecera es 21 
 */
mejor_valor_mano([Cabecera|_], _, Cabecera ):-
	Cabecera =:= 21.

/**
 * Caso Recursivo: la cabecera es mayor a Acumulador pero 
 * menor a 21 sigo la recursion con el valor de la cabecera 
 */
mejor_valor_mano(ListaDeValoresDeLaMano, Acumulador, MejorValor):-
	[Cabecera|Resto] = ListaDeValoresDeLaMano,
	Cabecera > Acumulador,
	Cabecera < 21,
	mejor_valor_mano(Resto, Cabecera, MejorValor),!.

/**
 * Caso Recursivo: cabecera es menor a Acumulador
 */
mejor_valor_mano([_|Resto], Acumulador, MejorValor):-
	mejor_valor_mano(Resto, Acumulador, MejorValor).

/**
 * @param Mano: lista de cartas  
 * @param MejorValor: valor de mano mas cercano a 21 
 */
mejor_jugada(Mano, MejorValor):-
	findall(X, hand(Mano, X), ListaValoresDeLaMano),
	mejor_valor_mano(ListaValoresDeLaMano, 0, MejorValor).


/**
 * Unifica si un ValorMano para ManoJugador
 * se compone de un AS con valor 11
 */
es_as_once(ManoJugador,ValorMano):-
		hand(ManoJugador, ValorMano),
		ValorSoft is ValorMano - 10,
		hand(ManoJugador, ValorSoft),
		!.
