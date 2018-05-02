
/*************************************************************
 *  	
 * 	Estas reglas utilitarias unifican una mano de blackjack 
 *  con su valor más cercano a 21. 
 *  
 * 	Inicialmente mano_mas_alta/2 crea una lista con los todos 	
 *  los valores posibles dada una mano. 
 *  
 *  Luego mejor_valor/3 unifica la lista con el valor 
 *  a 21. 
 * 
 *************************************************************/

/**
 *  Caso Base: ListaValoresDeLaMano es vacía entonces MejorValor es
 * 	el actual.
 */
mejor_valor([], _N, MejorValor),
	_N = MejorValor .

/**
 * Caso Base: cabecera es 21 
 */
mejor_valor([Cabecera|_], _, Cabecera ):-
	Cabecera =:= 21.

/**
 * Caso Recursivo: la cabecera es mayor a _N pero 
 * menor a 21 sigo la recursion con el valor de la cabecera 
 */
mejor_valor(ListaDeValoresDeLaMano, _N, MejorValor):-
	[Cabecera|Resto] = ListaDeValoresDeLaMano,
	Cabecera > _N,
	Cabecera < 21,
	mejor_valor(Resto, Cabecera, MejorValor),!.

/**
 * Caso Recursivo: cabecera es menor a _N
 */
mejor_valor([_|Resto], _N, MejorValor):-
	mejor_valor(Resto, _N MejorValor).

/**
 * @param Mano: lista de cartas  
 * @param MejorValor: valor de mano mas cercano a 21 
 */
mano_mas_alta(Mano, MejorValor):-
	findall(X, hand(Mano, X), ListaValoresDeLaMano),
	mejor_valor(ListaValoresDeLaMano, 0, MejorValor).


/**
 * Observa si un ValorMano para ManoJugador
 * se compone de un AS con valor 11
 */
es_as_once(ManoJugador,ValorMano):-
		hand(ManoJugador, ValorMano),
		ValorSoft is ValorMano - 10,
		hand(ManoJugador, ValorSoft),
		!.
