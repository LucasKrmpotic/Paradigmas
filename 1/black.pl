%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Paradigmas y Lenguajes de Programación - 2018
% TP 1 - Prolog
% Alumnos: 
%   Alzugaray Luciano
%   Krmpotic Lucas
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Definición de las Cartas %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%

card(a,c).
card(2,c).
card(3,c).
card(4,c).
card(5,c).
card(6,c).
card(7,c).
card(8,c).
card(9,c).
card(10,c).
card(j,c).
card(q,c).
card(k,c).

card(a,p).
card(2,p).
card(3,p).
card(4,p).
card(5,p).
card(6,p).
card(7,p).
card(8,p).
card(9,p).
card(10,p).
card(j,p).
card(q,p).
card(k,p).

card(a,t).
card(2,t).
card(3,t).
card(4,t).
card(5,t).
card(6,t).
card(7,t).
card(8,t).
card(9,t).
card(10,t).
card(j,t).
card(q,t).
card(k,t).

card(a,d).
card(2,d).
card(3,d).
card(4,d).
card(5,d).
card(6,d).
card(7,d).
card(8,d).
card(9,d).
card(10,d).
card(j,d).
card(q,d).
card(k,d).

%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Implementacion de value %
%%%%%%%%%%%%%%%%%%%%%%%%%%%

value(card(a,_),1).
value(card(a,_),11).
value(card(2,_),2).
value(card(3,_),3).
value(card(4,_),4).
value(card(5,_),5).
value(card(6,_),6).
value(card(7,_),7).
value(card(8,_),8).
value(card(9,_),9).
value(card(10,_),10).
value(card(j,_),10).
value(card(q,_),10).
value(card(k,_),10).


%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Implementacion de hand  %
%%%%%%%%%%%%%%%%%%%%%%%%%%%

hand([],0).
hand([card(N,_)|Resto],Valor):- 
	value(card(N,_),Valor1),
    hand(Resto,Valor2),
    Valor is Valor1+Valor2.



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Implementacion de twentyOne %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

twentyOne(Mano):- 
	hand(Mano,ValorMano),
    ValorMano = 21.

%%%%%%%%%%%%%%%%%%%%%%%%%%
% Implementacion de over %
%%%%%%%%%%%%%%%%%%%%%%%%%%

over(Mano):- 
	hand(Mano,ValorMano),
    ValorMano > 21.


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Implementacion de blackJack %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

blackJack(Mano):- 
	length(Mano, Len),
    Len = 2,
    hand(Mano,ValorMano),
    ValorMano = 21.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Implementacion de soft_dealer %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

soft_dealer(Hand):-
	hand(Hand, Value),
	Value < 17,
	not(hand(Hand, 17)).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Implementacion de hard_dealer %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

hard_dealer(Hand):-
	hand(Hand, 17),
	hand(Hand, 7) .

hard_dealer(Hand):- 
	hand(Hand, Value),
	Value < 17.

%%%%%%%%%%%%%%%%%%%%%%%%%%
% Implementacion de play %
% %%%%%%%%%%%%%%%%%%%%%%%%

fijate_mas_alto(_, 0, 0).
fijate_mas_alto(Mano, ValorActual, ValorActual):-
	hand(Mano, ValorActual).

fijate_mas_alto(Mano, ValorActual, ValorMasAlto):-
	ValorActualAux is ValorActual - 1,
	fijate_mas_alto(Mano, ValorActualAux, ValorMasAlto).

mano_mas_alta(Mano, ValorMasAlto):-
	fijate_mas_alto(Mano, 21, ValorMasAlto).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

fijate_mas_alto_optimo([], MasAlto, MasAlto).
fijate_mas_alto_optimo([NuevoValor|Resto], ValorMasAltoActual, ValorMasAlto):-
	NuevoValor > ValorMasAltoActual,
	NuevoValor < 22,
	fijate_mas_alto_optimo(Resto, NuevoValor, ValorMasAlto),!.

fijate_mas_alto_optimo([_|Resto], ValorMasAltoActual, ValorMasAlto):-
	fijate_mas_alto_optimo(Resto, ValorMasAltoActual, ValorMasAlto).

mano_mas_alta_optima(Mano, ValorMasAlto):-
	findall(X, hand(Mano, X), ListaValores),
	fijate_mas_alto_optimo(ListaValores, 0, ValorMasAlto).

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
	posibilidadBaja(Conteo).					% una carta baja. Si es asi juego. 

% Aca vemos la posibilidad de seguir sacando cartas para > 11 pero < 18. 
play(Jugador, _, CartasJugadas):-
	mano_mas_alta_optima(Jugador, ValorMano),	% Veo la mano mas cercana a 21. Veo si ese valor es
	ValorMano < 16,
	contar_uston_ss(CartasJugadas, 1, Conteo),	% es menor a 16 pido una carta siempre y cuando el valor de 
	not(posibilidadAlta(Conteo)).				% el conteo me indique que no hay posibilidades de sacar una carta alta.


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