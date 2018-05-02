%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Paradigmas y Lenguajes de Programación - 2018
% TP 1 - Prolog
% Alumnos: 
%   Alzugaray Luciano
%   Krmpotic Lucas
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

:- [hechos].
:- [objetivosPreliminares].
:- [objetivosIntermedios].
:- [utils].
:- [cuentaUstonSS].	


% Juega si el valor de la mano del jugador no supero a la mano del crupier
play(Jugador, Crupier, _):-
    mano_mas_alta_optima(Jugador, ValorManoJugador), 
    mano_mas_alta_optima(Crupier, ValorManoCrupier),
    not(ValorManoJugador > ValorManoCrupier).


% Ya sabemos que el valor de la mano supero a la del crupier.
% Ahora hay que ver que no sean pocos puntos. 
% Juega si el valor de la mano es menor a 11 pero no necesariamente si la mano mas alta es mayor a 18.
% Para lo siguiente calcula las probabilidades en la tercera regla
play(Jugador, _, _):- 
    hand(Jugador, ValorManoJugador),
    mano_mas_alta_optima(Jugador, ValorManoAux),
    ValorManoJugador < 11, 
    not(ValorManoAux > 18). 

% Aca vemos cuantas posibilidades hay para pedir cartas. Hay que pensar que si tenes un
% >18 soft podemos seguir pidiendo. Más si hay posibilidades de que hayan cartas bajas.
play(Jugador, _, CartasJugadas):-
	mano_mas_alta_optima(Jugador, ValorMano),	% Veo la mano mas cercana a 21. Veo si ese valor es
	ValorMano > 18,
	es_as_once(Jugador, ValorMano), 			% soft, o sea, tiene un A con valor 11. Cuento las
	contar_uston_ss(CartasJugadas, 1, Conteo),	% cartas con uston ss y me fijo si hay la posibilidad que me toque 
	posibilidadDeCartaBaja(Conteo).					% una carta baja. Si es asi juego. 

% Aca vemos la posibilidad de seguir sacando cartas para > 11 pero < 18. 
play(Jugador, _, CartasJugadas):-
	mano_mas_alta_optima(Jugador, ValorMano),	% Veo la mano mas cercana a 21. Veo si ese valor es
	ValorMano < 16,
	contar_uston_ss(CartasJugadas, 1, Conteo),	% es menor a 16 pido una carta siempre y cuando el valor de 
	not(posibilidadDeCartaAlta(Conteo)).				% el conteo me indique que no hay posibilidades de sacar una carta alta.


:- [tests].