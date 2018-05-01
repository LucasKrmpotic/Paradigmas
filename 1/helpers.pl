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