/***********************************************************
 * 
 * Sistema de Cuenta de cartasJugadas uston ss
 * 
 * Info sobre uston ss: 
 * http://www.countingedge.com/es/Cuenta-de-cartasJugadas/uston-ss/
 * 
 *
 ***********************************************************/

/**********************************************
 * Valores de las cartasJugadas en el sistema uston ss 
***********************************************/
valor_uston_ss(a,-2).
valor_uston_ss(2,2).
valor_uston_ss(3,2).
valor_uston_ss(4,2).
valor_uston_ss(5,3).
valor_uston_ss(6,2).
valor_uston_ss(7,1).
valor_uston_ss(8,0).
valor_uston_ss(9,-2).
valor_uston_ss(10,-2).
valor_uston_ss(j,-2).
valor_uston_ss(q,-2).
valor_uston_ss(k,-2).


/**
 * Caso Base: CartasJugadas es vacía, el valor actual es el valor de Cuenta
 */
uston_ss([], _, Cuenta):-
	_ = Cuenta.

/**
 * Caso Recursivo
 */
uston_ss(CartasJugadas, Acumulador, Cuenta):-
	[card(Carta,_)| Resto] = CartasJugadas,
	valor_uston_ss(Carta, ValorHuston),
	Conteo is Acumulador + ValorHuston,
	uston_ss(Resto, Conteo, Cuenta).

/**
 * uston ss obtiene el valor inicial de la cuenta multiplicando 
 * el número de barajas por  -2. 
 * 
 * Esta regla calcula el valor inicial y luego lanza la primera
 * llamada recursiva 
 */
contar_uston_ss(CartasJugadas, Barajas, Cuenta):-
	ValorInicial is Barajas * -2,
	uston_ss(CartasJugadas, ValorInicial, Cuenta).

% Hay posibilidad de baja si el Cuenta es bajo, eso significa que se jugaron bastantes altas.
% Este valor es ajustable.
posibilidadDeCartaBaja(Cuenta):-
	Cuenta < -2.				

% Hay posibilidad de baja si el Cuenta es bajo, eso significa que se jugaron bastantes altas.
% Este valor es ajustable.
posibilidadDeCartaAlta(Cuenta):-
	Cuenta > 0.			