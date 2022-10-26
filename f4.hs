import Data.Char
data Arv a = Vazia | No a (Arv a) (Arv a) deriving (Show)

-- 4.1
sumArv :: Num a => Arv a -> a
sumArv Vazia= 0
sumArv (No n left right) = n + sumArv left + sumArv right

-- 4.2
listar :: Arv a -> [a]
listar Vazia = []
listar (No n left right) = listar right ++ [n] ++ listar left

-- 4.3
nivel :: Int -> Arv a -> [a]
nivel _ Vazia = []
nivel 0 (No x _ _ ) = [x]
nivel n (No _ left right) = nivel (n-1) left ++ nivel (n-1) right

-- 4.4
mapArv :: (a -> b) -> Arv a -> Arv b
mapArv _ Vazia = Vazia
mapArv f (No x left right) = No (f x) (mapArv f left) (mapArv f right)

-- 4.5 a)
construir :: Ord a =>  [a] -> Arv a
construir [] = Vazia
construir [x] = No x Vazia Vazia
construir xs = No elementoMeio (construir primeiraMetade) (construir segundaMetade)
    where 
        meio = length xs `div` 2
        elementoMeio = xs !! meio
        primeiraMetade = take meio xs
        segundaMetade = drop (meio+1) xs

-- b)
inserir :: Ord a =>  a -> Arv a -> Arv a
inserir x Vazia = No x Vazia Vazia
inserir x (No y left right) 
    | x == y = No y left right
    | x < y = No y (inserir x left) right
    | otherwise = No y left (inserir x right)

construirLinear :: Ord a => [a] -> Arv a
construirLinear = foldr inserir Vazia

altura :: Arv a -> Int
altura Vazia = 0
altura (No _ Vazia Vazia) = 0
altura (No _ left right) = 1 + max(altura left) (altura right)

testHeight :: ([Int] -> Arv Int) -> [Int] -> [Int]
testHeight constructTree xs = [(altura . constructTree)[1..x] | x <-xs] 

-- 4.6 a)
maisDir :: Arv a -> a
maisDir Vazia = error "Arvore vazia :/ "
maisDir (No x _ Vazia) = x
maisDir (No _ _ right) = maisDir right

-- b)
remover :: Ord a => a -> Arv a -> Arv a
remover _ Vazia = Vazia
remover x (No y left right) 
    | x < y = No y (remover x left) right
    | x > y = No y left (remover x right)
    | otherwise = removerNo (No y left right)

removerNo :: Ord a=> Arv a  -> Arv a
removerNo Vazia = error "Nao tem nos para remover"
removerNo (No _ Vazia right) = right
removerNo (No _  left Vazia) = left
removerNo (No _  left right) = No n (remover n left) right
    where n = maisDir left

-- 4.7
reverseString :: String -> String
reverseString [] = []
reverseString (x:xs) = reverseString xs ++ [x]

getLines :: IO [String]
getLines = do
                line <- getLine
                if line == ""
                    then return []
                else 
                    do 
                        rest <- getLines
                        return (line:rest)
reverseLines :: IO() 
reverseLines = do
                lines <- getLines
                mapM_ (putStrLn . reverseString ) lines
                    
-- 4.8
codificaSecret :: String -> [Char] -> String
codificaSecret xs letras = [ f x | x <- xs]
    where f c | c `elem` letras = c
              | otherwise = '-'

adivinha' :: String -> [Char] -> Int -> IO()
adivinha' secret letras tentativas =
    do 
        let coded = codificaSecret secret letras
        if coded == secret then
            do 
                putStrLn ("The secret was found in " ++ show tentativas ++ " !")
                putStrLn secret 
        else 
            do
                putStrLn coded        
                putStr "Tentativa:"
                proxLetra <- getChar
                putStrLn " "
                adivinha' secret (letras ++[toLower proxLetra]) (tentativas +1)

adivinha :: String -> IO()
adivinha secret = adivinha' [toLower c | c <- secret] [] 0

-- 4.9
elefantes' :: Int -> String
elefantes' n = "Se " ++ show (n-1) ++ " elefantes incomodam muita gente,\n" ++ show n ++ " elefantes incomodam muito mais!"

elefantes :: Int -> IO()
elefantes n = sequence_ [putStrLn (elefantes' p) | p <- [3..n]]

-- 4.10
type Tabuleiro = [Int]
type Jogada = (Int,Int)

jogadaValida :: Tabuleiro -> Jogada -> Bool
jogadaValida tab (fila,estrelas)
    | fila > length tab || estrelas > (tab !! (fila-1)) = False
    | otherwise = True

jogada :: Tabuleiro -> Jogada -> Tabuleiro
jogada tab (nFila,nEstrelas) = [ f oldE oldF | (oldE,oldF) <- zip tab [1..(length tab)]]
    where f e f | f == nFila = e - nEstrelas
                | otherwise = e

getJodagaValida :: Tabuleiro -> IO Jogada
getJodagaValida tab =
    do
        putStr "Insira a fila: "
        filaS <-getLine
        let fila = read filaS
        putStr "Insira o numero de estrelas a retirar : "
        estrelasS <- getLine 
        let estrelas = read estrelasS
        let jogada = (fila,estrelas)
        if jogadaValida tab jogada then return jogada
        else getJodagaValida tab

ganhouJogo :: Tabuleiro -> Bool
ganhouJogo tab = all (==0) tab

printTabuleiro :: Tabuleiro -> Int -> IO()
printTabuleiro []  _ = return ()
printTabuleiro (x:xs) c =
    do 
        putStrLn (show c ++":" ++ take x (repeat '*'))
        printTabuleiro xs (c+1)

jogar' :: Tabuleiro -> Int -> IO()
jogar' tab jogador = 
    do 
        printTabuleiro tab 1
        putStrLn ("Turno do Jogador " ++ show jogador)
        proxJogada <- getJodagaValida tab
        let newTab = jogada tab proxJogada
        if ganhouJogo newTab then
            putStrLn ("Jogador " ++ show jogador ++ " ganhou!")
        else do
            case jogador of
                1 -> jogar' newTab 0 
                0 -> jogar' newTab 1

jogar :: Tabuleiro -> IO()
jogar tab = jogar' tab 0

-- 4.11
cifraLetra :: Int -> Char -> Char 
cifraLetra k x  
    | isLetter x && isUpper x = chr (mod (ord x +k - ord 'A' ) 26 + ord 'A' )
    | isLetter x && isLower x = chr (mod (ord x +k - ord 'a' ) 26 + ord 'a' )
    | otherwise  = x

cifrar :: Int -> String -> String
cifrar k xs = [cifraLetra k x| x <- xs]

cesar :: IO()
cesar = do
        lines <- getContents
        putStr (cifrar 13 lines)

main::IO()
main = cesar

    
test1 :: IO()
test1 = do
    -- 4.5 Teste
    let testSet = [10,100,1000]
    print "Testando construcao linear"
    -- Altura ~= n
    print (testHeight construirLinear testSet)
    
    print "Testando particoes binarias"
    -- Altura ~= log n
    print (testHeight construir testSet)
    

