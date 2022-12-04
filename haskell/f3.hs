-- 3.1
mapAndFilter :: (a -> b) -> (a -> Bool) -> [a] -> [b]
mapAndFilter f p xs = map f (filter p xs)

-- 3.2
dec2int :: [Int] -> Int 
dec2int = foldl (\x y -> x*10 + y) 0 

-- 3.3
myZipWith :: (a -> b -> c) -> [a] -> [b] -> [c]
myZipWith _ _ [] = []
myZipWith _ [] _ = []
myZipWith f (x:xs) (y:ys) = f x y : myZipWith f xs ys

-- 3.4
insert :: Ord a =>  a -> [a] -> [a]
insert y [] = []
insert y (x:xs) 
    | x < y =  x : insert y xs
    | otherwise =  y:x:xs

isort :: Ord a => [a] -> [a]
isort = foldr insert []

-- 3.5 a)
myMax :: Ord a => a -> a -> a
myMax a b 
    | a > b = a
    | otherwise = b

maximumRight1 :: Ord a =>  [a] -> a
maximumRight1 = foldr1 myMax

maximumLeft1 :: Ord a =>  [a] -> a
maximumLeft1 = foldl1 myMax

myMin :: Ord a => a -> a -> a
myMin a b 
    | a < b = a
    | otherwise = b

minimumRight1 :: Ord a => [a] -> a
minimumRight1 = foldr1 myMin

minimumLeft1 :: Ord a => [a] -> a
minimumLeft1 = foldl1 myMin

-- b)
myFoldr1 :: (a -> a -> a)  -> [a] -> a
myFoldr1 f xs = foldr f (last xs) (init xs) 

myFoldl1 :: (a -> a -> a)  -> [a] -> a
myFoldl1 f xs = foldl f (head xs) (tail xs)

-- 3.6 
mdc :: Int -> Int -> Int
mdc a b = fst (until (\(a,b) -> b == 0) (\(a,b) -> (b,a`mod`b)) (a,b))

-- 3.7 a)
(+++) :: [a] -> [a] -> [a] 
xs +++ ys = foldr (:) ys xs

-- b)
concatFoldr :: [[a]] -> [a] 
concatFoldr = foldr (++) []

-- c)qua
reverseFoldr :: [a] -> [a]
reverseFoldr = foldr (\y ys -> ys ++ [y]) []  

-- d)
reverseFoldl :: [a] -> [a] 
reverseFoldl = foldl (\ys y -> y:ys) []

--e) 
myElem :: Eq a => a -> [a] -> Bool
myElem x = any (x ==)

-- 3.8 a)
palavras :: String -> [String]
palavras [] = []
palavras (' ':xs) = palavras xs
palavras xs = [y | y <- word] : palavras rest
    where word = takeWhile (' ' /=) xs 
          rest = dropWhile (' ' /=) xs
    
-- b) 
despalavras :: [String] -> String
despalavras [] = []
despalavras xs = foldr1 (\x y -> x ++ " " ++ y) xs 
-- O contra exemplo é que a função palavras pode eliminar n espacos entre 2
-- palavras a funcao despalavras não tem como saber quantos espacos estavam
-- entre cada 2 palavras

-- 3.9 
myScanl :: (b -> a -> b) -> b -> [a] -> [b]
myScanl _ z [] = [z]
myScanl f z (x:xs) = z: myScanl f (f z x) xs
