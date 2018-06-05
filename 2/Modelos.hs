module Modelos where
import Data.List

-- Definicion del TipoCLiente
data TipoCliente = Cliente { 
	nombreCliente :: String, 
	resistencia :: Int, 
	listaAmigos :: [TipoCliente]
} | ClienteBebidasTomadas {
	nombreCliente :: String, 
	resistencia :: Int, 
	listaAmigos :: [TipoCliente],
	bebidasTomadas :: [TipoBebida]
} deriving (Show)


data TipoBebida = 
        GrogXD 
      | JarraLoca
      | Klusener {sabor :: String}
      | Tintico
      | Soda  {fuerza :: Int}
      | JarraPopular {espirituosidad :: Int}

instance Show TipoBebida where
    show GrogXD = "GrogXD"
    show JarraLoca = "Jarra Loca"
    show (Klusener sabor) = ("Klusener de " ++ sabor)
    show Tintico = "Tintico"
    show (Soda fuerza) = ("Soda de fuerza " ++ show(fuerza))
    show (JarraPopular espirituosidad) = ("Jarra popular de espirituosidad " ++ show(espirituosidad))

-- ComoEsta: Devuelve el estado de ebriedad del cliente en cadena
comoEsta :: TipoCliente -> String
comoEsta cliente 
	| resistencia cliente > 50 = "fresco"
	| resistencia cliente < 50 &&  length (listaAmigos cliente) > 1 = "piola"
	| otherwise = "duro"

-- Agregar un amigo: Dado un cliente y un amigo que no tenga el cliente, devuelve el cliente con el amigo agregado
agregarAmigo :: TipoCliente -> TipoCliente -> TipoCliente
agregarAmigo cliente amigo 
	| ((nombreCliente cliente) == (nombreCliente amigo)) || (any (((==) (nombreCliente amigo)) . nombreCliente) (listaAmigos cliente)) = cliente
	| otherwise = cliente { listaAmigos = amigo : (listaAmigos cliente) } 

-- Dado un cliente y una cantidad de horas, aumenta la resistencia del cliente según lo rescatado que esté
rescatarse :: Int -> TipoCliente -> TipoCliente
rescatarse horas cliente | horas > 3 = cliente { resistencia = (resistencia cliente) + 200 }
						 | horas > 0 = cliente { resistencia = (resistencia cliente) + 100 }
						 | otherwise = cliente 

-- Devuelve una cadena con la información actual del cliente
infoCliente :: TipoCliente -> String
infoCliente cliente = 
	"Nombre: " ++ (nombreCliente cliente) 
    ++ "\nresistencia: " ++ (show (resistencia cliente)) 
    ++ "\namigos: " ++ listarAmigos cliente

-- Devuelve la lista de amigos en cadena de una forma amigable
listarAmigos :: TipoCliente -> String
listarAmigos cliente = listarAmigosRecursion (listaAmigos cliente) ""

listarAmigosRecursion :: [TipoCliente] -> String -> String 
listarAmigosRecursion [] cadenaAmigos = "No tiene amigos"
listarAmigosRecursion [x] cadenaAmigos = cadenaAmigos ++ (nombreCliente x)
listarAmigosRecursion (x:xs) cadenaAmigos = listarAmigosRecursion xs (cadenaAmigos ++ (nombreCliente x) ++ ", ")

-- Baja la resistencia una cantidad dada
bajar_resistencia:: Int -> TipoCliente -> TipoCliente
bajar_resistencia cantidad cliente = cliente {resistencia = (resistencia cliente) - cantidad}


efectoSoda :: Int -> String -> String
efectoSoda fuerza nombre = "e" ++ (replicate fuerza 'r') ++ "p" ++ nombre

jarraPopular = JarraPopular 2

beber :: TipoBebida -> TipoCliente -> TipoCliente
beber GrogXD cliente = cliente { resistencia = 0, bebidasTomadas = (bebidasTomadas cliente)++[GrogXD]}

beber JarraLoca cliente = cliente { listaAmigos = map (bajar_resistencia 10) (listaAmigos cliente), bebidasTomadas = (bebidasTomadas cliente)++[JarraLoca] }

beber klusener cliente = bajar_resistencia  (length (sabor klusener)) cliente { bebidasTomadas = (bebidasTomadas cliente)++[klusener]}

beber Tintico cliente = cliente { resistencia = (resistencia cliente) + (5 * (length (listaAmigos cliente))), bebidasTomadas = (bebidasTomadas cliente)++[Tintico] }

beber soda cliente = cliente { nombreCliente = (efectoSoda (fuerza soda) (nombreCliente cliente)), bebidasTomadas = (bebidasTomadas cliente)++[soda]} 

beber jarraPopular cliente = foldr agregarAmigo cliente (sumarAmigosDeAmigos (espirituosidad jarraPopular)(listaAmigos cliente))
          
tomarTragos :: TipoCliente -> [TipoBebida] -> TipoCliente
tomarTragos cliente [] = cliente
tomarTragos cliente [x] = beber x cliente
tomarTragos cliente (x:xs) = tomarTragos (beber x cliente) xs 

dameOtro :: TipoCliente -> TipoCliente
dameOtro cliente = beber (last (bebidasTomadas cliente)) cliente

cualesPuedeTomar :: TipoCliente -> [TipoBebida] -> [TipoBebida]
cualesPuedeTomar cliente listaTragos = filter (puedoTomar cliente) listaTragos
 
puedoTomar cliente trago = resistencia (beber trago cliente) > 0


cuantasPuedeTomar :: TipoCliente -> [TipoBebida] -> Int
cuantasPuedeTomar cliente listaTragos = length (cualesPuedeTomar cliente listaTragos)

-- Objetivo 3 - ITINERARIOS

robertoCarlos = ClienteBebidasTomadas "Roberto Carlos" 165 [] []

data TipoItinerario = Itinerario {
	nombre :: String, 
	tiempo :: Float, 
	acciones :: [(TipoCliente -> TipoCliente)]
}

mezclaExplosiva = Itinerario{
	nombre = "Mezcla Explosiva", 
	tiempo = 2.5, 
	acciones = [
		beber GrogXD,
		beber GrogXD, 
		beber (Klusener "huevo"), 
		beber (Klusener "frutilla")
	]
}

itinerarioBasico = Itinerario{
    nombre="Basico",
    tiempo= 5, 
    acciones = [
        beber JarraLoca, 
        beber (Klusener "chocolate"), 
        (rescatarse 3), 
        beber (Klusener "huevo")
    ]
}

salidaDeAmigos = Itinerario{
    nombre="Salida de amigos", 
    tiempo=1, 
    acciones = [
        beber (Soda 1), 
        beber Tintico, 
        (agregarAmigo robertoCarlos), 
        beber JarraLoca
    ]
}

itinerarioAna = Itinerario{
    nombre="Itinerario Ana",
    tiempo= 1, 
    acciones = [
        beber JarraLoca, 
        beber (Klusener "chocolate"), 
        (rescatarse 2), 
        beber (Klusener "huevo")
    ]
}


hacerItinerario :: TipoItinerario -> TipoCliente -> TipoCliente
hacerItinerario itinerario cliente = hacerAccionesItinerario (acciones itinerario) cliente

hacerAccionesItinerario :: [(TipoCliente-> TipoCliente)] -> TipoCliente -> TipoCliente
hacerAccionesItinerario [] cliente = cliente
hacerAccionesItinerario [f] cliente = f cliente
hacerAccionesItinerario (f:fs) cliente = hacerAccionesItinerario fs (f cliente)

-- Objetivo 4
intensidad:: TipoItinerario -> Float
intensidad itinerario = genericLength(acciones itinerario) / (tiempo itinerario)

hacerItinerarioMasIntenso :: [TipoItinerario] -> TipoCliente -> TipoCliente
hacerItinerarioMasIntenso [] cliente = cliente
hacerItinerarioMasIntenso itinerarios cliente = hacerItinerario (getItinerarioMasIntenso itinerarios) cliente

getItinerarioMasIntenso :: [TipoItinerario] -> TipoItinerario
getItinerarioMasIntenso [i] = i
getItinerarioMasIntenso (i:j:cola) = if intensidad i > intensidad j
                                     then getItinerarioMasIntenso (i:cola)
                                     else getItinerarioMasIntenso (j:cola)


-- Objetivo 5
getAmigosDeAmigos :: [TipoCliente] -> [TipoCliente]
getAmigosDeAmigos amigos = concat(map listaAmigos amigos)

sumarAmigosDeAmigos :: Int -> [TipoCliente] -> [TipoCliente]
sumarAmigosDeAmigos 0 amigos = amigos

sumarAmigosDeAmigos indireccion amigos = (getAmigosDeAmigos amigos) ++ (sumarAmigosDeAmigos (indireccion - 1) (getAmigosDeAmigos amigos))