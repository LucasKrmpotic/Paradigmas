### Paradigmas y Lenguajes de Programación - UNPSJB Trelew

## Laboratorio 01

---

# Blackjack

**Cátedra:**
+ Prof: Lic. Romina Stickar
+ JTP:  Lic. Lautaro Pecile

**Alumnos:**
+ Alzugaray Luciano
+ Krmpotic Lucas

---

+ ## Estructura del proyecto
    + [cartas.pl](cartas.pl): definición de las cartas y sus valores
    + [mejorJugada.pl](mejorJugada.pl):  reglas enunciadas en los objetivos preliminares
    + [dealer.pl](dealer.pl):  reglas enunciadas en los objetivos intermedios
    + [mejorJugada.pl](mejorJugada.pl): lógica para decidir la mejor jugada en las condiciones actuales.
    + [cuentaUstonSS.pl](cuentaUstonSS.pl): lógica de conteo de cartas según el sistema Uston SS
    + [black.pl](black.pl): archivo principal de la base de conocimientos
    + [tests.pl](tests.pl): conjunto de casos de prueba para cada regla.

---


### Lógica de la regla *play/3*

- **ManoManoJugador:** lista con las cartas del Manojugador en una mano.

- **ManoManoCrupier:** lista con las cartas del Manocrupier en una mano.
    
- **CartasJugadas:** lista de las cartas jugadas.

La regla **play/3** hace uso del functor **mejor_jugada/2** que unifica con la mejor jugada posible en las condiciones actuales, según el sistema de conteo de cartas **Uston SS**.

La lógica de **mejor_jugada/2** se encuentra declarada en el archivo [mejorJugada.pl](mejorJugada.pl) 

**Las posibilidades son:**

1) Pide cartas siempre que la mano del crupier sea superior.

```prolog
play(ManoJugador, ManoCrupier, _):-
    mejor_jugada(ManoJugador, ValorManoManoJugador), 
    mejor_jugada(ManoCrupier, ValorManoManoCrupier),
    not(ValorManoManoJugador > ValorManoManoCrupier).
```

2) Habiendo superado al crupier, pide carta si el valor de la mano es menor o igual a 11, salvo que sea con un **as** ( también es 18 !! ) y el conteo de cartas arroje que es probable que venga una carta mas baja.

```prolog
play(ManoJugador, _, _):- 
    hand(ManoJugador, ValorManoManoJugador),
    mejor_jugada(ManoJugador, ValorManoAux),
    ValorManoManoJugador < 11, 
    not(ValorManoAux > 18). 
```

3) 

```prolog
% Aca vemos cuantas posibilidades hay para pedir cartas. Hay que pensar que si tenes un
% >18 soft podemos seguir pidiendo. Más si hay posibilidades de que hayan cartas bajas.
play(ManoJugador, _, CartasJugadas):-
	mejor_jugada(ManoJugador, ValorMano),	% Veo la mano mas cercana a 21. Veo si ese valor es
	ValorMano > 18,
	es_as_once(ManoJugador, ValorMano), 			% soft, o sea, tiene un A con valor 11. Cuento las
	contar_uston_ss(CartasJugadas, 1, Conteo),	% cartas con uston ss y me fijo si hay la posibilidad que me toque 
	posibilidadDeCartaBaja(Conteo).
```

```prolog
% Aca vemos la posibilidad de seguir sacando cartas para > 11 pero < 18. 
play(ManoJugador, _, CartasJugadas):-
	mejor_jugada(ManoJugador, ValorMano),	% Veo la mano mas cercana a 21. Veo si ese valor es
	ValorMano < 16,
	contar_uston_ss(CartasJugadas, 1, Conteo),	% es menor a 16 pido una carta siempre y cuando el valor de 
	not(posibilidadDeCartaAlta(Conteo)).				% el conteo me indique que no hay posibilidades de sacar una carta alta.
```

