import Modelos
-- import Bebidas

iniciarFiesta = do

    -- Objetivo 2
    -- Crear los clientes rodri, marcos, cristian y ana
    imprimirConEnter "El boliche acaba de abrir en la noche de viernes, ¿Quién vendrá a la joda de esta noche?"  
    
    let rodri = Cliente "Rodri" 55 [] 
    imprimirConEnter ("Acaba de llegar " ++ (nombreCliente rodri) ++ " a la fiesta\n¡Vamos a conocerlo!")
    imprimirConEnter(infoCliente rodri)
    
    let marcos = Cliente "Marcos"    40 [rodri]
    imprimirConEnter ("Acaba de llegar " ++ (nombreCliente marcos) ++ " a la fiesta\n¡Vamos a conocerlo!")
    imprimirConEnter ( infoCliente marcos)
    
    let cristian = Cliente "Cristian"  2  [] 
    imprimirConEnter ("Acaba de llegar " ++ (nombreCliente cristian) ++ " a la fiesta\n¡Vamos a conocerlo!")
    imprimirConEnter(infoCliente cristian)
    
    let ana = Cliente "Ana"       120 [marcos, rodri]
    imprimirConEnter ("Acaba de llegar " ++ (nombreCliente ana) ++ " a la fiesta\n¡Vamos a conocerlo!")
    imprimirConEnter(infoCliente ana)

    imprimirConEnter "¡Todos los viernes la noche es de la Haskell House!"
    
    -- Objetivo 3
    -- Crear la función comoEsta
    imprimirConEnter ("¡Vamos a ver como llegaron!")

    imprimirConEnter ("Ana está " ++ (comoEsta ana))
    imprimirConEnter ("Cristian está " ++ (comoEsta cristian))
    imprimirConEnter ("Marcos está " ++ (comoEsta marcos))
    
    imprimirConEnter "¡El grupo de amigos que haga más quilombo se lleva un champagne!"

    -- Objetivo 4
    -- Crear una función para agregar amigos
    imprimirConEnter "Hagamos que estos chicos se lleven bien"
    imprimirConEnter "Vamos a hacer que se amiguen rodri con marcos"

    let clienteAux = agregarAmigo rodri marcos
    let rodri = clienteAux
    imprimirConEnter (infoCliente rodri)

    imprimirConEnter "¡Muy Bien! Ahora hagamos que Cristian tenga algún amigo"
    let clienteAux = agregarAmigo cristian marcos
    let cristian = clienteAux
    let clienteAux = agregarAmigo cristian ana
    let cristian = clienteAux

    imprimirConEnter (infoCliente cristian)
    imprimirConEnter "¡Excelente! ¿Cómo estás Cristian?"
    imprimirConEnter ("Cristian responde \" " ++ (comoEsta cristian) ++ " \" ")

    imprimirConEnter "¡Esta noche hay ofertas en bebidas! ¡A reventar la barra!"

    -- Objetivo 5
    -- Crear abstracción adecuada para las bebidas
    imprimirConEnter "¿Qué opciones de bebidas hay?"
    let grog_xd = GrogXD
    print grog_xd
    let jarra_loca = JarraLoca
    print jarra_loca
    let klusener = Klusener "Huevo"
    print klusener
    let tintico = Tintico
    print tintico

    let clienteAux = beber GrogXD cristian
    let cristian = clienteAux
    imprimirConEnter (infoCliente cristian)

    let clienteAux = beber JarraLoca ana
    let ana = clienteAux

    -- Objetivo 6
    -- Agregar una función para que puedan rescatarse
    imprimirConEnter "Che pibe, calmate o te saco afuera -- Juan \"Roca\" Mori, Personal de Seguridad"
    imprimirConEnter "Cristian se va a tener que rescatar"
    let clienteAux = rescatarse 3 cristian
    let cristian = clienteAux

    imprimirConEnter "¿Cómo estás Cristian?"
    imprimirConEnter (infoCliente cristian) 

    -- Objetivo 7
    -- Hacer el itinerario con Ana
    imprimirConEnter "¡Ana parece que vino a pasarla bien!"
    imprimirConEnter "Ana se toma una jarra loca, un klusener de chocolate, se rescata 2 horas y toma un klusener de huevo"
    let clienteAux = ((beber (Klusener "huevo")) . (rescatarse 2) . (beber (Klusener "chocolate")) . (beber JarraLoca)) ana
    let ana = clienteAux
    imprimirConEnter (infoCliente ana)
    imprimirConEnter "Cierra el boliche en su magnifica noche de viernes"

    -- Parte 2
    -- Objetivo 1 
    -- Crear el historial de bebidas

    imprimirConEnter "Hoy noche de sábado la Haskell House la rompe"
    imprimirConEnter "¡Habría que contar que lleva tomando cada uno!"

    let rodri = ClienteBebidasTomadas "Rodri" 55 [] [Tintico]
    imprimirConEnter ("Acaba de llegar " ++ (nombreCliente rodri) ++ " a la fiesta\n¡Vamos a conocerlo!")
    imprimirConEnter(infoCliente rodri)
    
    let marcos = ClienteBebidasTomadas "Marcos"    40 [rodri] [(Klusener "guinda")]
    imprimirConEnter ("Acaba de llegar " ++ (nombreCliente marcos) ++ " a la fiesta\n¡Vamos a conocerlo!")
    imprimirConEnter ( infoCliente marcos)
    
    let cristian = ClienteBebidasTomadas "Cristian"  2  [] []
    imprimirConEnter ("Acaba de llegar " ++ (nombreCliente cristian) ++ " a la fiesta\n¡Vamos a conocerlo!")
    imprimirConEnter(infoCliente cristian)
    
    let ana = ClienteBebidasTomadas "Ana"       120 [marcos, rodri] [GrogXD, JarraLoca]
    imprimirConEnter ("Acaba de llegar " ++ (nombreCliente ana) ++ " a la fiesta\n¡Vamos a conocerlo!")
    imprimirConEnter(infoCliente ana)

    imprimirConEnter "Hey Rodri, veni a tomar un klusener de guinda"
    let clienteAux = beber (Klusener "guinda") rodri 
    let rodri = clienteAux
    imprimirConEnter (infoCliente rodri)
    
    imprimirConEnter "¡Hey Cristian, mira lo que hay en la barra para vos! ¡Tomatelo!"
    let clienteAux = tomarTragos cristian [GrogXD, (Klusener "chocolate"), (Klusener "huevo"), Tintico] 
    let cristian = clienteAux
    imprimirConEnter (infoCliente cristian)

    imprimirConEnter "Rodri quiere tomar otro klusener, denselo"
    let clienteAux = dameOtro rodri 
    let rodri = clienteAux
    imprimirConEnter (infoCliente rodri)

    -- Objetivo 2
    imprimirConEnter "Ahora vamos a ver, ana, ¿Qué queres tomar entre un klusener de huevo, uno de guinda o un GrogXD, sin emborracharte?"
    imprimirConEnter (listarBebidas (cualesPuedeTomar ana [(Klusener "huevo"), (Klusener "guinda"), GrogXD]))
    let ana = clienteAux
    imprimirConEnter (infoCliente rodri)

    
imprimirConEnter:: String -> IO ()
imprimirConEnter que = do 
    putStrLn que
    key <- getLine 
    return ()
 
 