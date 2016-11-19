
-- convert dec to binary
dec2bi :: Integer -> String
dec2bi 0 = show 0
dec2bi n = dec2bi (n `div` 2) ++ (show (n `rem` 2))

solveProblemBi n = tail $ dec2bi n


-- convert dec to rome
romeNotation :: [String]
romeNotation = ["M", "CM", "D", "CD", "C", "XC", "L", "XL", "X", "IX", "V", "IV", "I"]

romeAmount :: [Int]
romeAmount = [1000,900,500,400,100,90,50,40,10,9,5,4,1]

rome :: [(Int, String)]
rome = zip romeAmount romeNotation

romeString :: Int -> (Int, String)
romeString n = head $ dropWhile (\(a,_) -> a > n) rome


toRome :: Int -> String
toRome 0 = "" 
toRome n = let (n1,s1) = romeString n in 
           let      s  = toRome (n-n1) in (s1 ++ s)

-- convert rome to dec


toDec :: String -> Int
toDec s = fst $ (filter (\(_,s1) -> s1 == s) rome) !! 0

--romeToDec :: String -> Int
--romeToDec "" = 0
--romeToDec (s1:s2:ss) = romeToDec ss + fst $ ((break (\(_,a) -> a == s1 || a == (s1:s2)) rome) !! 1) !! 0


-- hanio

hanioHelper :: Int -> Int -> Int -> Int -> [(Int,Int)]
hanioHelper 0 from to via = []
hanioHelper n from to via = hanioHelper (n-1) from via to ++ [(from,to)] 
                            ++ hanioHelper (n-1)  via to from 

hanio n = hanioHelper n 1 2 3

--fastFib

fastFib :: Int -> [Int]
fastFib n = take n $ map fst $ iterate (\(a,b) -> (b,a+b)) (0,1)

--fib converge to golden number??
toGolden :: Int -> [Double]
toGolden n = take n $ map (\(a,b) -> a/b) $ iterate (\(a,b) -> (b,a+b)) (0,1)

fibGoldenEx :: Int -> [Double]
fibGoldenEx n = map (\a -> (golden-a)/golden) $ take n $ map (\(a,b) -> a/b) $ iterate (\(a,b) -> (b,a+b)) (0,1) where
             golden = abs $ (1 - sqrt 5)/2


-- hamming number

merge :: [Int] -> [Int]
merge [] = []
merge (x:xs) | x `elem` xs = merge xs 
             | otherwise   = x : merge xs

hamming :: [Int]
hamming = 1 : merge ham
          where ham1 = map (*2) hamming
                ham2 = map (*3) hamming
                ham3 = map (*5) hamming 
                ham  = ham1 ++ ham2 ++ ham3 

-- quick sort

qSort :: [Int] -> [Int]
qSort [] = []
qSort (x:xs) = qSort mini ++ [x] ++ qSort maxi
  where mini = filter (<x) xs
        maxi = filter (>=x) xs

-- insert sort

insert :: Int -> [Int] -> [Int]
insert x [] = [x] 
insert x (x1:xs) | x < x1    = x:x1:xs
                 | otherwise = x1 : insert x xs 

insertSort :: [Int] -> [Int]
insertSort x = foldr insert [] x 

-- pop sort

pop :: [Int] -> [Int]
pop [] = []
pop [x] = [x]
pop (x1:x2:xs) | x1 < x2   = x1 : pop (x2:xs)
               | otherwise = x2 : pop (x1:xs)

popSort :: [Int] -> [Int]
popSort [] = []
popSort x = pop delLast ++ [lastOne]
    where poped   = pop x
          lastOne = last poped
          delLast = init poped


