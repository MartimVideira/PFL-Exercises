-- 1.1

-- testaTriangulo :: (Ord a, Num a) => a -> -> a-> a -> Bool
testaTriangulo ::  (Real a) =>  a -> a -> a  -> Bool
testaTriangulo a b c 
    |  c >= a + b = False
    |  a >= c + b = False 
    |  b >= a + c = False 
    |  a * b * c == 0 = False
    |  otherwise = True

-- 1.2 
areaTriangulo :: Float -> Float -> Float -> Float 
areaTriangulo a b c = sqrt (s*(s-a)*(s-b)*(s-c))
    where s = (a + b + c) / 2

-- 1.3 
metades :: [a] -> ([a],[a])
metades xs = (take x xs,drop x xs)
    where 
        x 
            | even (length xs) =  length xs `div`2
            | otherwise = length xs `div` 2 + 1
            
-- 1.4  a)
last1 :: [a] -> a
last1 xs = head (reverse xs)

last2 :: [a] -> a
last2  xs =  head (drop (length xs -1 ) xs)

-- 1.4 b)
init1 :: [a] -> [a]
init1  xs =  reverse (drop 1 (reverse xs))

init2 :: [a] -> [a]
init2 xs = take (length xs -1) xs


-- 1.5 a)
binom :: Integer -> Integer -> Integer
binom n k =  fat n `div` (fat k *  fat (n-k))
    where 
        fat n  = product [1..n]

-- 1.5 b)
binom' :: Integer -> Integer -> Integer
binom' n k 
    | k < (n-k) = product [(n-k+1)..n] `div` (product [1..k])
    | otherwise = product [(k+1)..n]  `div` (product [1..(n-k)])

 
-- 1.6 
raizes :: Float -> Float -> Float -> (Float, Float)
raizes a b c = (((-b) + delta) / (2*a),((-b) - delta) / (2*a))
    where delta = sqrt (b*b - 4*a*c)

-- 1.7
-- ['a','b','c'] :: [Char]
-- ('a','b','c') :: (Char,Char,Char)
-- [(False,'0'),(True,'1')] :: [(Bool,Char)]
-- ([False,True],['0','1']) :: ([Bool],[Char])
-- [tail,init,reverse] :: [([a] ->[a])]
-- [id,not] :: [(Bool -> Bool)]

-- 1.8 
segundo ::  [a] -> a
segundo xs = head (tail xs)

trocar :: (a,b) -> (b,a)
trocar (x,y) = (y,x)

par :: a -> b -> (a,b)
par x y = (x,y)

dobro :: Num a => a -> a 
dobro x = 2 * x

metade :: Fractional a => a -> a
metade x = x / 2

minuscula :: Char -> Bool
minuscula x = x >= 'a' && x <='z'

intervalo :: Ord a => a -> a -> a ->Bool
intervalo x a b = x >= a && x <= b

palindromo :: Eq a => [a] -> Bool
palindromo xs = reverse xs == xs

twice :: (a -> a) -> a -> a 
twice f x = f (f x)

-- 1.9
classifica_if :: Int -> String
classifica_if n = 
    if n < 0 || n > 20 
        then "erro" 
    else if n <=9 then "reprovado"
    else if n <=12 then "suficiente"
    else if n <=15 then "bom"
    else if n <=18 then "muito bom"
    else if n <=20 then "muito bom com distinção"
    else "erro"

-- 1.10 
classifica_imc :: Float -> Float -> String
classifica_imc p h 
    | imc < 18.5 = "Baixo Peso"
    | imc < 25 = "Peso Normal"
    | imc < 30 = "Excesso de Peso"
    | otherwise = "Obesidade"
    where imc = p / (h * h)


-- 1.11 a)
min3_if :: Ord a => a -> a -> a -> a
min3_if x y z = if x<=y && x <= z then x 
             else if y <= x && y <= z then y
            else z

max3_if :: Ord a => a -> a -> a -> a
max3_if x y z = if x>=y && x >=z then x
                else if y >= x && y >= z then y
                else  z


-- 1.11 b)
min3 :: Ord a => a -> a -> a -> a
min3 x y z = min2 x (min2 y z)
    where min2 c d 
            | c >= d = d 
            | otherwise = c 

max3 :: Ord a => a -> a -> a -> a 
max3 x y z =  max2 x (max2 y z)
    where max2 c d 
            | c >= d = c 
            | otherwise = d 

-- 1.12
xor :: Bool -> Bool -> Bool 
xor True True  = False
xor False False = False
xor a   b = True


-- 1.13
safetail_if ::[a] -> [a]
safetail_if xs = if null xs then [] else tail xs

safetail_guard :: [a] -> [a]
safetail_guard xs 
    | null xs = []
    | otherwise = tail xs 

safetail_pattern :: [a] -> [a]
safetail_pattern [] =  [] 
safetail_pattern  xs = tail xs 
    
-- 1.14 
curta :: [a] -> Bool 
curta xs 
    | l < 3 = True  
    | otherwise = False
    where l = length xs 

curta' :: [a] -> Bool
curta' [] = True
curta' [_] = True
curta' [_,_] = True
curta' (_:_:_) = False

-- 1.15 
mediana :: Ord a => a -> a -> a -> a
mediana x y z 
    | (x >= y && x <=z) || (x >= z && x <=y)= x
    | (y >= x && y <=z) || (y >= z && y <=x)= y
    | otherwise = z

mediana' :: (Num a,Ord a) => a -> a -> a -> a
mediana' x y z =  (x+y+z) - min x (min y z) - max x (max y z)


