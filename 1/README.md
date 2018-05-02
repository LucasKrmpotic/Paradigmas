### Paradigmas y Lenguajes de Programación - UNPSJB Trelew

## Laboratorio 04 

---

# Blackjack

**Cátedra:**
+ Romina Stickar
+ Lautaro Pecile

**Alumnos:**
+ Alzugaray Luciano
+ Krmpotic Lucas

---

+ ## Estructura del proyecto
    + hechos.pl: 
    + objetivosPreliminares.pl
    + objetivosIntermedios.pl
    + helpers.pl
    + cuentaUstonSS.pl
    + black.pl
    + tests.pl

---


### Casos de prueba de la regla *play()/3.* 

    Caso 1: 
    
        Mano jugador: [(a, _), (5, _)]
        Mano crupier: [(a, _), (4, _)]

        Debe jugar porque se estable

    

### Lógica de la regla *play/3*

Pide cartas siempre que la mano del crupier sea superior.

```prolog
play(Jugador, Crupier, _):-
    mano_mas_alta_optima(Jugador, ValorManoJugador), 
    mano_mas_alta_optima(Crupier, ValorManoCrupier),
    not(ValorManoJugador > ValorManoCrupier).

```
Habiendo superado al crupier, pide carta si el valor de la mano es menor o igual a 11, salvo que sea con un **as** ( también es 18 !! ) y el conteo de cartas arroje que es probable que venga una carta mas baja.

```prolog
play(Jugador, _, _):- 
    hand(Jugador, ValorManoJugador),
    mano_mas_alta_optima(Jugador, ValorManoAux),
    ValorManoJugador < 11, 
    not(ValorManoAux > 18). 
```


```prolog
% Aca vemos cuantas posibilidades hay para pedir cartas. Hay que pensar que si tenes un
% >18 soft podemos seguir pidiendo. Más si hay posibilidades de que hayan cartas bajas.
play(Jugador, _, CartasJugadas):-
	mano_mas_alta_optima(Jugador, ValorMano),	% Veo la mano mas cercana a 21. Veo si ese valor es
	ValorMano > 18,
	es_as_once(Jugador, ValorMano), 			% soft, o sea, tiene un A con valor 11. Cuento las
	contar_uston_ss(CartasJugadas, 1, Conteo),	% cartas con uston ss y me fijo si hay la posibilidad que me toque 
	posibilidadBaja(Conteo).					% una carta baja. Si es asi juego. 
```

```prolog
% Aca vemos la posibilidad de seguir sacando cartas para > 11 pero < 18. 
play(Jugador, _, CartasJugadas):-
	mano_mas_alta_optima(Jugador, ValorMano),	% Veo la mano mas cercana a 21. Veo si ese valor es
	ValorMano < 16,
	contar_uston_ss(CartasJugadas, 1, Conteo),	% es menor a 16 pido una carta siempre y cuando el valor de 
	not(posibilidadAlta(Conteo)).				% el conteo me indique que no hay posibilidades de sacar una carta alta.
```

