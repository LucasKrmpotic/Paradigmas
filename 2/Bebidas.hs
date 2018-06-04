module Bebidas where
import Clientes

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

efectoSoda :: Int -> String -> String
efectoSoda fuerza nombre = "e" ++ (replicate fuerza 'r') ++ "p" ++ nombre

beber :: TipoBebida -> TipoCliente -> TipoCliente
beber GrogXD cliente = cliente { resistencia = 0 }

beber JarraLoca cliente = cliente { listaAmigos = map (bajar_resistencia 10) (listaAmigos cliente) }

beber (Klusener sabor) cliente = cliente  { resistencia = bajar_resistencia  (length sabor) } 

beber Tintico cliente = cliente { resistencia = resistencia + (5 * (length listaAmigos)) }

tomarTrago (Soda fuerza) cliente = cliente { nombreCliente = (efectoSoda fuerza nombre) } 
          
