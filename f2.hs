import Data.Char

-- 2.1 a)
myand :: [Bool] -> Bool
myand [] = True
myand (x:xs) = x && myand xs

-- b)
myor :: [Bool] -> Bool
myor [] = False
myor (x:xs) = x || myor xs

-- c)
myconcat :: [[a]] -> [a]
myconcat [] = [] 
myconcat (xs:xss) = xs ++ myconcat xss

-- d)
myreplicate :: Int -> a -> [a]
myreplicate 0 _ = []
myreplicate n x = x : myreplicate (n-1) x

-- e)
(?!) :: [a] -> Int -> a
(x:_) ?! 0 = x
(_:xs) ?! n =  xs ?! (n-1)

-- f)
myelem :: Eq a => a -> [a] -> Bool
myelem _ [] = False
myelem n (x:xs) = n == x || myelem n xs

-- 2.2
intersperse:: a -> [a] -> [a]
intersperse _ [] = []
intersperse _ [x] = [x]
intersperse c (x:xs)  = x:c:intersperse c xs 

-- 2.3
mdc :: Int -> Int -> Int
mdc a 0 = a
mdc a b = mdc b (mod a b)

-- 2.4 a)
insert :: Ord a => a -> [a] -> [a]
insert y [] = [y]
insert y (x:xs) 
    | x < y =  x:insert y xs
    | otherwise = y:x:xs

-- b)
isort :: Ord a => [a] -> [a]
isort [] =  []
isort (x:xs) = insert x (isort xs)

-- 2.5 a)
myMinimum :: Ord a => [a] -> a
myMinimum [x] = x
myMinimum (x:xs) 
    | z < x = z
    | otherwise  = x
    where  z = myMinimum xs

--b)
delete :: Eq a => a -> [a] -> [a]
delete n [] = []
delete n (x:xs)
    | n == x = xs
    | otherwise = x : delete n xs

-- c)
ssort :: Ord a => [a] -> [a] 
ssort [] = []
ssort xs = z:delete z xs where z = myMinimum xs

-- 2.6
somaQuadrados = sum [x*x | x <-[1..100]]

-- 2.7 a)
aprox :: Int -> Double
aprox n = sum [(-1)^k / fromIntegral (2*k +1) | k <- [0..n]]

aproxPi n = aprox n  * 4

aprox' :: Int -> Double
aprox' n = sum (take n [(-1)^k / fromIntegral((k+1)^2) | k <-[0..]]) 

aproxPi' n =  sqrt(aprox' n * 12)

-- 2.8
dotprod :: Num a => [a] -> [a] -> a
dotprod [] []  = 0
dotprod (x:xs) (y:ys)  = x*y + dotprod xs ys

dotprod' :: [Float] -> [Float] -> Float
dotprod' xs ys 
        | length xs /= length ys = error "Can't calculate scalar prod vectors of different dimensions"
        | otherwise = sum [ x * y | (x,y) <- zip xs ys]

-- 2.9
divprop :: Int -> [Int]
divprop n = [i | i <-[1..(n-1)], mod n i == 0]

-- 2.10
perfeitos :: Int -> [Int]
perfeitos n =[i | i <-[1..n] , i == sum (divprop i)]

-- 2.11
pitagoricos :: Int -> [(Int,Int,Int)]
pitagoricos n = [(x,y,z) | x <- [1..n],y <-[1..n] , z <-[1..n],x^2 + y^2 == z^2]

-- 2.12
primo :: Int -> Bool 
primo n = length (divprop n) == 1

-- 2.13
isMerssene :: Int -> Bool
isMerssene n = primo n && not (null [i | i <-[0..n],(2^i - 1) == n])

mersennes :: [Int]
mersennes = [i | i <-[1..], isMerssene i]

-- 2.14
binom :: Int -> Int -> Int
binom n k =  fact n `div` ( fact k * fact (n -k))
    where fact n = product [1..n]

pascal :: Int -> [[Int]]
pascal n =  [[ binom i j | j <- [0..i]]  | i <- [0..n]]

-- 2.15
cifraLetra :: Int -> Char -> Char 
cifraLetra k x  
    | isLetter x && isUpper x = chr (mod (ord x +k - ord 'A' ) 26 + ord 'A' )
    | isLetter x && isLower x = chr (mod (ord x +k - ord 'a' ) 26 + ord 'a' )
    | otherwise  = x

cifrar :: Int -> String -> String
cifrar k xs = [cifraLetra k x| x <- xs]

-- 2.16
compConcat :: [[a]] -> [a]
compConcat xss =  [ x | xs <- xss,x <- xs]

compReplicate :: Int -> a -> [a]
compReplicate n x = [x | _ <-[1..n]]

comBangBang :: Int -> [a] -> a
comBangBang n xs = head [x | (x,y) <- zip xs [0..n],y==n]

-- 2.17
forte :: String -> Bool
forte xs = (length xs >= 8) && letraMaiuscula xs && letraMinuscula xs  && algarismo xs
    where 
        peloMenosUm criterio lista = length [x | x <- lista ,criterio x] > 1
        letraMaiuscula = peloMenosUm isUpper
        letraMinuscula = peloMenosUm isLower
        algarismo = peloMenosUm isDigit 

-- 2.18 a)
mindiv :: Int -> Int 
mindiv n  
    | null z  = n
    | otherwise  = head z 
    where z = [ i | i <- [2..floor (sqrt (fromIntegral n))],mod n i == 0]

-- 2.18 b) 
primo2:: Int -> Bool
primo2 n = n >1 &&  (mindiv n  == n)

-- 2.19 c)
nub :: Eq a => [a] -> [a]
nub []  = []
nub (x:xs) = x:nub [y | y<-xs ,y /=x] 

-- 2.20
transpose :: [[a]] ->[[a]]
transpose xss  = [ [xs !! i | xs <- xss] | i<- [0..(z-1)]  ]
    where z = length (head xss)

-- 2.21 
algarismos :: Int -> [Int]
algarismos n 
    | n < 10  =  [n]
    | otherwise =  algarismos (div n 10) ++ [mod n 10]

-- 2.22 
toBits :: Int -> [Int]
toBits 0 = [0]
toBits 1 = [1]
toBits n = toBits(div n 2) ++ [mod n 2] 
     
-- 2.23
fromBits :: [Int] -> Int 
-- fromBits xs = dotprod (reverse $ take (length xs) (iterate (2*) 1)) xs  -- Dotprod op
fromBits xs = sum [x*y | (x,y)<- zip xs (iterate (`div` 2) (2^(length xs - 1)))]

-- 2.24  a)
merge :: Ord a => [a] -> [a] -> [a]
merge xs [] = xs
merge [] ys = ys
merge (x:xs) (y:ys) 
    | x < y = x:merge xs (y:ys)
    | otherwise = y:merge (x:xs) ys

-- b) Uma maneira engracada de dividir duas listas sem usar a funcao length
metades :: [a] -> ([a],[a]) 
metades [] = ([],[])
metades [x] = ([x],[])
metades (x:x1:xs) = (x:z,x1:z1)
    where (z,z1) = metades xs

mergeSort :: Ord a => [a] -> [a]
mergeSort [] = []
mergeSort [x] = [x]
mergeSort xs = merge (mergeSort left) (mergeSort right)
    where  (left,right) = metades xs

-- Fim 
main :: IO ()
main = do
    -- 2.7 b Teste
    let pows = iterate (10*) 1
    let test_set = take 3 pows
    let result = [abs (aproxPi' n - pi) | n <- test_set]
    print result
