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

fijate_mas_alto(Mano, 0, 0).
fijate_mas_alto(Mano, ValorActual, ValorActual):-
	hand(Mano, ValorActual).

fijate_mas_alto(Mano, ValorActual, ValorMasAlto):-
	ValorActualAux is ValorActual - 1,
	fijate_mas_alto(Mano, ValorActualAux, ValorMasAlto).

mano_mas_alta(Mano, ValorMasAlto):-
	fijate_mas_alto(Mano, 21, ValorMasAlto).

play(Jugador,_,_):-
	not(twentyOne(Jugador)).

play(Jugador, Crupier, _):-
    hand(Jugador, ValorManoJugador), 
    hand(Crupier, ValorManoCrupier),
    not(ValorManoJugador > ValorManoCrupier) .

play(Jugador, _, _):- 
    hand(Jugador, ValorManoJugador),
    hand(Jugador, ValorManoAux),
    ValorManoJugador < 11, 
    not(ValorManoAux > 18). 

