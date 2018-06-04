module Modelos where

-- Definicion del TipoCLiente
data TipoCliente = Cliente { 
	nombreCliente :: String, 
	resistencia :: Int, 
	listaAmigos :: [TipoCliente],
	bebidasTomadas :: [Bebidas]
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
comoEsta (Cliente _  resistencia  amigos) 
	| resistencia > 50 = "fresco"
	| resistencia < 50 &&  length amigos > 1 = "piola"
	| otherwise = "duro"

-- Agregar un amigo: Dado un cliente y un amigo que no tenga el cliente, devuelve el cliente con el amigo agregado
agregarAmigo :: TipoCliente -> TipoCliente -> TipoCliente
agregarAmigo cliente amigo 
	| ((nombreCliente cliente) == (nombreCliente amigo)) || (any (((==) (nombreCliente amigo)) . nombreCliente) (listaAmigos cliente)) = cliente
	| otherwise = cliente { listaAmigos = amigo : (listaAmigos cliente) } 

-- Dado un cliente y una cantidad de horas, aumenta la resistencia del cliente según lo rescatado que esté
rescatarse :: TipoCliente -> Int -> TipoCliente
rescatarse cliente horas | horas > 3 = cliente { resistencia = (resistencia cliente) + 200 }
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

beber :: TipoBebida -> TipoCliente -> TipoCliente
beber GrogXD cliente = cliente { resistencia = 0, bebidasTomadas = GrogXD:(bebidasTomadas cliente)}

beber JarraLoca cliente = cliente { listaAmigos = map (bajar_resistencia 10) (listaAmigos cliente), bebidasTomadas = JarraLoca:(bebidasTomadas cliente) }

beber klusener cliente = bajar_resistencia  (length (sabor klusener)) cliente { bebidasTomadas = klusener:(bebidasTomadas cliente)}

beber Tintico cliente = cliente { resistencia = (resistencia cliente) + (5 * (length (listaAmigos cliente))), bebidasTomadas = tintico:(bebidasTomadas cliente) }

beber soda cliente = cliente { nombreCliente = (efectoSoda (fuerza soda) (nombreCliente cliente)), bebidasTomadas = soda:(bebidasTomadas cliente) } 

          
tomarTragos :: TipoCliente -> [TipoBebida] -> TipoCliente
tomarTragos cliente [] = cliente
tomarTragos cliente [x] = beber x cliente
tomarTragos cliente [x:xs] = tomarTragos((beber cliente) xs)

dameOtro :: TipoCliente -> TipoCliente
dameOtro cliente = beber (last (bebidasTomadas cliente))

cualesPuedeTomar :: TipoCliente -> [TipoBebida] -> [TipoBebida]
cualesPuedeTomar cliente listaTragos = filter (puedoTomar cliente) listaTragos
 
puedoTomar cliente trago = resistencia (beber trago cliente) > 0


cuantasPuedeTomar :: TipoCliente -> [TipoBebida] -> Int
cuantasPuedeTomar cliente listaTragos = length (cualesPuedeTomar cliente listaTragos)