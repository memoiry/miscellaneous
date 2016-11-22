
-- 1.10 cc

index = [1,10,5,50,25]
cmount :: Int -> Int
cmount amount = cc amount 4


cc :: Int -> Int -> Int
cc amount num | amount == 0 = 1
              | (amount < 0) || (num < 0) = 0
              | otherwise = cc (amount-(index !! num)) num + cc amount (num-1)

-- 1.11

ff :: Integer -> Integer
ff n | n < 3 = n
     | otherwise = ff (n-1) + 2 * ff (n-2) + 3 * ff (n-3)


ffIterate :: Integer -> Integer
ffIterate n | n < 3 = n
            | otherwise = iterHelper n 0 1 2

iterHelper :: Integer -> Integer -> Integer -> Integer -> Integer
iterHelper n x1 x2 x3 | n == 3    = x3 + 2 * x2 + 3 * x1
                      | otherwise = iterHelper (n-1) x2 x3 (x3 + 2 * x2 + 3 * x1)

-- 1.12
pasKal :: Int -> Int -> Integer
pasKal x y | x == 1 && y == 1 = 1
           | y > x || x < 1 || y < 1 = 0
           | otherwise = pasKal (x-1) (y-1) + pasKal (x-1) y 

pasArray n = [[(pasKal y x) | x <- [1..n]]| y <- [1..n]]             

-- 2.12

sameParity :: [Int] -> [Int]
sameParity [] = []
sameParity [x] = []
sameParity (x:xs) | odd x  = filter odd xs
                  | even x = filter even xs   

sameParityRe :: [Int] -> [Int]
sameParityRe [] = []
sameParityRe [x] = []
sameParityRe (x1:x2:xs) | odd x1  = if odd x2 then x2 : sameParityRe (x1:xs) else sameParityRe (x1:xs) 
                      | even x1 = if even x2 then x2 : sameParityRe (x1:xs) else sameParityRe (x1:xs)


