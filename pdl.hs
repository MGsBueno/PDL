import Data.Set (Set)
import qualified Data.Set as Set


-- Definição de tipos para estados e rótulos de arestas
type State = String
type Label = String


-- Definição do tipo para representar um frame PDL
data Frame = Frame { states :: Set State, edges :: [(State, Label, State)] }
  deriving Show


-- Função para verificar se um frame é válido para um programa PDL
isValidFrame :: Frame -> Either String Bool
isValidFrame frame =
  let frameStates = states frame
      frameEdges = edges frame
      invalidEdge = findInvalidEdge frameStates frameEdges
  in case invalidEdge of
    Just (s1, l, s2) -> Left $ "Aresta inválida: " ++ s1 ++ " --" ++ l ++ "--> " ++ s2
    Nothing -> Right True


-- Função auxiliar para encontrar a primeira aresta inválida
findInvalidEdge :: Set State -> [(State, Label, State)] -> Maybe (State, Label, State)
findInvalidEdge frameStates frameEdges = foldr findInvalid Nothing frameEdges
  where
    findInvalid (s1, l, s2) acc =
      if s1 `Set.member` frameStates && s2 `Set.member` frameStates
        then acc
        else Just (s1, l, s2)


-- Função para imprimir o frame
printFrame :: Frame -> IO ()
printFrame frame = do
  putStrLn "Frame:"
  putStrLn $ "States: " ++ show (states frame)
  putStrLn $ "Edges: " ++ show (edges frame)


-- Função auxiliar para verificar se a entrada é vazia (apenas Enter pressionado)
isInputEmpty :: String -> Bool
isInputEmpty = all (== ' ')


-- Função principal do loop
loop :: IO ()
loop = do
  putStrLn "Pressione Enter para encerrar ou qualquer outra tecla para continuar."
  input <- getLine
  if isInputEmpty input
    then putStrLn "Encerrando o programa."
    else do
      let stateList = ["A", "B", "C"]
          edgeList = [("A", "edge", "B"), ("B", "edge", "C"), ("C", "edge", "D")]
          frame = Frame { states = Set.fromList stateList, edges = edgeList }
      printFrame frame
      case isValidFrame frame of
        Right True -> putStrLn "O frame é válido para o programa"
        Left errorMsg -> putStrLn $ "Erro: " ++ errorMsg
      loop


-- Função principal que inicia o loop
main :: IO ()
main = loop

