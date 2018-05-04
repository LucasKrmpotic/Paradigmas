:- set_prolog_flag(verbose, silent).

:- initialization main.

mostrarCarta(Carta):-
	string_to_card(Carta, card(N,P)),
    format('Tu carta es card(~w,~w)\n', [N, P]).

/*Convierte una cadena en número si es que la cadena contiene un nro */
get_number_atom(S, A) :- atom_number(S, A), !.
get_number_atom(S, S).

/*transforma una cadena en su functor de carta correspondiente*/
string_to_card(S, card(Numero,P)) :-
	string_chars(S, [N, P]),	/* separa en caracteres la cadena S */ 
	get_number_atom(N, Numero).

mostrarCartas([]).
mostrarCartas([Carta|Resto]):-
    mostrarCarta(Carta),
    mostrarCartas(Resto).


mostrarArgumentos([]).
mostrarArgumentos([Arg|Resto]) :-
	format('~w\n', Arg),
	mostrarArgumentos(Resto).


ejecutarComando([cartas | Resto]) :-
    mostrarCartas(Resto).
ejecutarComando([play | Resto]) :-
	mostrarArgumentos(Resto).
ejecutarComando(_) :-
	format('Comando no entendido.\n', []).

main :-
  current_prolog_flag(argv, Argv),
  ejecutarComando(Argv),
  halt.

main :-
  halt(1).


