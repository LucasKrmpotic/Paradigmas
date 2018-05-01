%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Implementacion de uston ss %
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%
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

contame_uston_ss([], ConteoActual, ConteoActual).

contame_uston_ss(Cartas, ConteoActual, Conteo):-
	[card(Carta,_)| Resto] = Cartas,
	valor_uston_ss(Carta, ValorHuston),
	ConteoNuevo is ConteoActual + ValorHuston,
	contame_uston_ss(Resto, ConteoNuevo, Conteo).

% La cantidad de barajas hacen que el conteo inicial sea de cantidadDeBarajas * -2
% segun el algoritmo de conteo Huston SS.
contar_uston_ss(Cartas, Barajas, Conteo):-
	ValorInicial is Barajas * -2,
	contame_uston_ss(Cartas, ValorInicial, Conteo).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

es_as_once(Jugador,ValorMano):-
	hand(Jugador, ValorMano),
	ValorSoft is ValorMano - 10,
	hand(Jugador, ValorSoft),
	!.

% Hay posibilidad de baja si el conteo es bajo, eso significa que se jugaron bastantes altas.
% Este valor es ajustable.
posibilidadBaja(Conteo):-
	Conteo < -2.				

% Hay posibilidad de baja si el conteo es bajo, eso significa que se jugaron bastantes altas.
% Este valor es ajustable.
posibilidadAlta(Conteo):-
	Conteo > 0.			