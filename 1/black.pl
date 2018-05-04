/********************************************
 *  
 * Implementación las reglas main para parseo
 * de comando y ejecución.
 *
 ********************************************/


:- set_prolog_flag(verbose, silent).

:- initialization main.

:- [play].

/*Convierte una cadena en número si es que la cadena contiene un nro */
get_number_atom(S, A) :- 
  atom_number(S, A), 
  !.

get_number_atom(S, S).

string_to_card(S, card(Numero,P)) :-
  string_chars(S, [N, P]),  /* separa en caracteres la cadena S */ 
  get_number_atom(N, Numero).

/* Regla para 10 (son dos digitos) */
string_to_card(S, card(Numero,P)) :-
  string_chars(S, ['1', '0', P]),  /* separa en caracteres la cadena S */ 
  Numero = 10.

/* Funciones recursivas para obtener las cartas y devolver el resto de argumentos*/
get_cards_aux([Carta| Resto], Argumentos, ListaAux ,Devolucion):-
  string_to_card(Carta, CartaAux),
  ListaAux2 = [CartaAux| ListaAux],
  get_cards_aux(Resto, Argumentos, ListaAux2, Devolucion).

get_cards_aux(RestoArgumentos, RestoArgumentos, Devolucion , Devolucion).

/* Obtiene las cartas y argumentos restantes de una lista*/
get_cards(Cartas, Argumentos, Devolucion):-
  get_cards_aux(Cartas, Argumentos, [] ,Devolucion).

get_cards([], [], []).

ejecutarDealer([hard | Cartas]):-
  get_cards(Cartas, _, Hand),
  hard_dealer(Hand).

ejecutarDealer([soft | Cartas]):-
  get_cards(Cartas, _, Hand),
  soft_dealer(Hand).

ejecutarDealer([_]):-
  format('Comando incorrecto', []),
  nl.

parse_args_play_hand([hand|Resto], Argumentos_Dealer, Hand):-
  get_cards(Resto, Argumentos_Dealer, Hand),!.

parse_args_play_dealer([dealer|Resto], Argumentos_Cards, Dealer):-
  get_cards(Resto, Argumentos_Cards, Dealer),!.

parse_args_play_cards([cards|Resto], Cards):-
  get_cards(Resto, _, Cards),!.

parse_args_play(Argumentos, Lista):-
  parse_args_play_hand(Argumentos, Argumentos_Dealer, Hand),
  parse_args_play_dealer(Argumentos_Dealer, Argumentos_Cards, Dealer),
  parse_args_play_cards(Argumentos_Cards,Cards),

  Lista = [Hand, Dealer, Cards].
  
ejecutarPlay(Argumentos):-
  parse_args_play(Argumentos, [Hand, Dealer, Cards]),
  play(Hand, Dealer, Cards).

ejecutarPlay(_):-
  format('Comando incorrecto', []),
  nl.

ejecutarComando([dealer | Resto]) :-
    ejecutarDealer(Resto).
ejecutarComando([play | Resto]) :-
	ejecutarPlay(Resto).
ejecutarComando(_) :-
	format('Comando no entendido.\n', []).

main :-
  current_prolog_flag(argv, Argv),
  ejecutarComando(Argv).

main :-
  halt(1).


