import Clientes
import Bebidas
import Test.HUnit

rodri = Cliente "Rodri" 55 []
marcos = Cliente "Marcos"    40 [rodri]
cristian = Cliente "Cristian"  2  []
ana = Cliente "Ana"       120 [marcos, rodri]

test1 = TestCase (assertEqual "Cristian está duro," "duro" (comoEsta cristian))

parte1 = TestList [TestLabel "Cristan esta duro" test1]