module
 Clientes where 

-- Definicion del TipoCLiente
data TipoCliente = Cliente { 
	nombreCliente :: String, 
	resistencia :: Int, 
	listaAmigos :: [TipoCliente]
} deriving (Show)


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

bajar_resistencia:: Int -> TipoCliente -> TipoCliente
bajar_resistencia cantidad cliente = cliente {resistencia = (resistencia cliente) - cantidad}

listarAmigosRecursion :: [TipoCliente] -> String -> String 
listarAmigosRecursion [] cadenaAmigos = "No tiene amigos"
listarAmigosRecursion [x] cadenaAmigos = cadenaAmigos ++ (nombreCliente x)
listarAmigosRecursion (x:xs) cadenaAmigos = listarAmigosRecursion xs (cadenaAmigos ++ (nombreCliente x) ++ ", ")
