-- Definicion de Personas
-- Cliente nombre, resistencia, lista de amigos
data TipoCliente = Cliente { 
  nombreCliente :: String, 
  resistencia :: Int, 
  listaAmigos :: [TipoCliente]
} deriving (Show)

data TipoBebida = Bebida {
  nombreBebida :: String,
  efecto :: (TipoCliente -> TipoCliente)
} 

rodri = Cliente "Rodri"     55 []
marcos = Cliente "Marcos"    40 [rodri]
cristian = Cliente "Cristian"  2  []
ana = Cliente "Ana"       120 [marcos, rodri]

getName :: TipoCliente -> String
getName (Cliente nombreCliente _ _ ) = nombreCliente

comoEsta :: TipoCliente -> String
comoEsta (Cliente _  resistencia  amigos) 
  | resistencia > 50 = "fresco"
  | resistencia < 50 &&  length amigos > 1 = "piola"
  | otherwise = "duro"

agregarAmigo :: TipoCliente -> TipoCliente -> TipoCliente
agregarAmigo cliente amigo 
  | ((nombreCliente cliente) == (nombreCliente amigo)) || (any (((==) (nombreCliente amigo)).nombreCliente) (listaAmigos cliente)) = cliente
  | otherwise = cliente { listaAmigos = amigo : (listaAmigos cliente) } 

cambiarResistencia :: (Int -> Int) -> TipoCliente -> TipoCliente
cambiarResistencia funcion cliente = cliente { resistencia = (funcion (resistencia  cliente)) }

grog_xd_efecto :: TipoCliente -> TipoCliente
grog_xd_efecto cliente = cliente { resistencia = 0 }

jarra_loca_efecto :: TipoCliente -> TipoCliente
jarra_loca_efecto cliente = cambiarResistencia (-) cliente

klusener_efecto :: TipoCliente -> TipoCliente
klusener_efecto cliente = cliente

tintico_efecto :: TipoCliente -> TipoCliente
tintico_efecto cliente = cliente

soda_efecto :: TipoCliente  -> TipoCliente
soda_efecto cliente = cliente

grog_xd = Bebida "Grog XD" grog_xd_efecto
jarra_loca = Bebida "Jarra Loca" jarra_loca_efecto
klusener = Bebida "klusener" klusener_efecto
tintico = Bebida "tintico" tintico_efecto
soda = Bebida "soda" soda_efecto

rescatarse :: TipoCliente -> Int -> TipoCliente
rescatarse cliente horas 
  | horas > 3 = cliente { resistencia = (resistencia cliente) + 200 }
  | horas > 0 = cliente { resistencia = (resistencia cliente) + 100 }
  | otherwise = cliente 

