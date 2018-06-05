### Paradigmas y Lenguajes de Programación - UNPSJB Trelew

## Laboratorio 02

---

# Functional Fest

**Cátedra:**
+ Prof: Lic. Romina Stickar
+ JTP:  Lic. Lautaro Pecile

**Alumnos:**
+ Alzugaray Luciano
+ Krmpotic Lucas

---

+ ## Estructura del proyecto
    + [main.hs](main.hs): Contiene la función de entrada para iniciar la fiesta.
    + [Modelos.pl](Modelos.pl): definición de la lógica en general.

---


### Iniciando la fiesta *play/3*

Iniciar la fiesta es tan simple como 

```haskell
    iniciarFiesta
```
Y hacer enter para que la fiesta vaya avanzando.

---
### Predefinidos

Tipos de datos: 

    Cliente nombre resistencia listaAmigos

    ClienteBebidasTomadas nombre resistencia listaAmigos bebidasTomadas

    TipoBebida = 
        GrogXD 
      | JarraLoca
      | Klusener {sabor :: String}
      | Tintico
      | Soda  {fuerza :: Int}
      | JarraPopular {espirituosidad :: Int}

    Itinerario {
        nombre :: String, 
        tiempo :: Float, 
        acciones :: [(TipoCliente -> TipoCliente)]
    }

Existen también una serie de datos predefinidos:

tipos de dato Clientes:
 - Cliente "Rodri" 55 [] 
 - Cliente "Marcos" 40 [rodri]
 - Cliente "Cristian" 2  []
 - Cliente "Ana"  120 [marcos, rodri]
 - Cliente "Roberto Carlos" 165 [] []

 -  Itinerario {
        nombre = "Mezcla Explosiva", 
        tiempo = 2.5, 
        acciones = [
            beber GrogXD,
            beber GrogXD, 
            beber (Klusener "huevo"), 
            beber (Klusener "frutilla")
        ]
    }

 -  Itinerario {
        nombre = "Mezcla Explosiva", 
        tiempo = 2.5, 
        acciones = [
            beber GrogXD,
            beber GrogXD, 
            beber (Klusener "huevo"), 
            beber (Klusener "frutilla")
        ]
    }

 -  Itinerario {
        nombre="Basico",
        tiempo= 5, 
        acciones = [
            beber JarraLoca, 
            beber (Klusener "chocolate"), 
            (rescatarse 3), 
            beber (Klusener "huevo")
        ]
    }

 -  Itinerario {
        nombre="Salida de amigos", 
        tiempo=1, 
        acciones = [
            beber (Soda 1), 
            beber Tintico, 
            (agregarAmigo robertoCarlos), 
            beber JarraLoca
        ]
    }

 -  Itinerario {
        nombre="Itinerario Ana",
        tiempo= 1, 
        acciones = [
            beber JarraLoca, 
            beber (Klusener "chocolate"), 
            (rescatarse 2), 
            beber (Klusener "huevo")
        ]
    }

Definición de funciones:
    
#### ComoEsta: Devuelve el estado de ebriedad del cliente en cadena

    comoEsta :: TipoCliente -> String

#### Agregar un amigo: Dado un cliente y un amigo que no tenga el cliente, devuelve el cliente con el amigo agregado
    agregarAmigo :: TipoCliente -> TipoCliente -> TipoCliente

#### Dado un cliente y una cantidad de horas, aumenta la resistencia del cliente según lo rescatado que esté
    rescatarse :: Int -> TipoCliente -> TipoCliente

#### Devuelve una cadena con la información actual del cliente

    infoCliente :: TipoCliente -> String

#### Devuelve la lista de amigos en cadena de una forma amigable
    listarAmigos :: TipoCliente -> String

#### Devuelve la lista de amigos en cadena de una forma amigable
    listarBebidas :: [TipoBebida] -> String

#### Baja la resistencia una cantidad dada
    bajar_resistencia :: Int -> TipoCliente -> TipoCliente

#### Un cliente bebe una bebida
    beber :: TipoBebida -> TipoCliente -> TipoCliente

#### Hace a un cliente beber todas las bebidas de una lista dada
    tomarTragos :: TipoCliente -> [TipoBebida] -> TipoCliente

#### Hace a un cliente beber la última bebida tomada
dameOtro :: TipoCliente -> TipoCliente

#### Dada una lista, decide cuales puede tomar sin quedarse en 0
cualesPuedeTomar :: TipoCliente -> [TipoBebida] -> [TipoBebida]

#### Dada una lista, te dice la cantidad de bebidas en la lista que puede elegir para tomar sin quedarse un cliente con la resistencia en 0
cuantasPuedeTomar :: TipoCliente -> [TipoBebida] -> Int

#### Hace que un cliente haga un itinerario dado
hacerItinerario :: TipoItinerario -> TipoCliente -> TipoCliente

#### Calcula la intensidad de un itinerario dado
intensidad:: TipoItinerario -> Float

#### Hace que un cliente haga el itinerario con más intensidad de los itinerarios dados
hacerItinerarioMasIntenso :: [TipoItinerario] -> TipoCliente -> TipoCliente

