/**********************************************
* Paradigmas y Lenguajes de Programación - 2018
* TP 1 - Prolog
* 
* Alumnos: 
*	Alzugaray Luciano
*  	Krmpotic Lucas 
***********************************************/ 


:- [cartas].
:- [utils].
:- [mejorJugada].
:- [dealer].
:- [cuentaUstonSS].	


/**
 * Hasta este valor de mano ninguna carta que se agregue 
 * generaria un sobrepaso de 21
 */
cota_inferior(ValorMano):-
	ValorMano < 11.

/**
 * Hasta este valor la decisión de pedir carta depende de 
 * la cuenta Uston SS
 */
valor_umbral(ValorMano):-
	 ValorMano >= 17.

/**
 * A partir este valor se planta independientemente
 * del valor de la cuenta Uston SS.
 */
cota_superior(ValorMano):-
		ValorMano >= 19.

% Juega si el valor de la mano del ManoJugador no supero a la mano del ManoCrupier
play(ManoJugador, ManoCrupier, _):-
    mejor_jugada(ManoJugador, ValorManoJugador), 
    mejor_jugada(ManoCrupier, ValorManoManoCrupier),
    not(ValorManoJugador > ValorManoManoCrupier),
    format('hit',[]),
	nl.


% Ya sabemos que el valor de la mano supero a la del ManoCrupier.
% Ahora hay que ver que no sean pocos puntos. 
% Juega si el valor de la mano es menor a 11 pero no necesariamente si la mano mas alta es mayor a 18.
% Para lo siguiente calcula las probabilidades en la tercera regla
play(ManoJugador, _, _):- 
    hand(ManoJugador, ValorManoJugador),
    mejor_jugada(ManoJugador, ValorManoAux),
    cota_inferior(ValorManoJugador), 
    not(valor_umbral(ValorManoAux)),
	format('hit',[]),
	nl. 

% Aca vemos cuantas posibilidades hay para pedir cartas. Hay que pensar que si tenes un
% >16 soft podemos seguir pidiendo. Más si hay posibilidades de que hayan cartas bajas.
play(ManoJugador, _, CartasJugadas):-
	mejor_jugada(ManoJugador, ValorMano),	% Veo la mano mas cercana a 21. Veo si ese valor es
	valor_umbral(ValorMano),
	not(cota_superior(ValorMano)),
	es_as_once(ManoJugador, ValorMano), 			% soft, o sea, tiene un A con valor 11. Cuento las
	contar_uston_ss(CartasJugadas, 1, Conteo),	% cartas con uston ss y me fijo si hay la posibilidad que me toque 
	posibilidadDeCartaBaja(Conteo),
	format('hit',[]),
	nl.
 

% Aca vemos la posibilidad de seguir sacando cartas para > 11 pero < 18. 
play(ManoJugador, _, CartasJugadas):-
	mejor_jugada(ManoJugador, ValorMano),	% Veo la mano mas cercana a 21. Veo si ese valor es
	not(cota_superior(ValorMano)),
	contar_uston_ss(CartasJugadas, 1, Conteo),	% es menor a 16 pido una carta siempre y cuando el valor de 
	not(posibilidadDeCartaAlta(Conteo)), % el conteo me indique que no hay posibilidades de sacar una carta alta.
	format('hit',[]),
	nl. 
	
play(_, _, _):-
	format('stand',[]),
	nl.

:- [tests].