
import Data.List (insertBy, sortBy)
import Data.Ord (comparing)

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



-- prime related
fib = 0 : 1 : zipWith (+) fib (tail fib)

seive :: [Int] -> [Int]
seive [] = []
seive (x:xs) = x : seive [xx | xx <- xs, xx `mod` x /= 0]

isPrime :: Integer -> Bool
isPrime x = if length [xs | xs <- [2..x], x `mod` xs == 0, xs * xs <= x] == 0 then True else False

bigPrime :: Integer -> Integer
bigPrime x | x `mod` 2 == 0 = bigPrime (x+1)
           | otherwise      = if isPrime x then x else bigPrime (x+2)


main = print $ bigPrime 123204



--tree generation
data Tree = Leaf | Node Tree Tree deriving Show

trees :: Int -> [Tree]
trees 0 = [Leaf]
trees n = [Node lr ll | l <- [0..n-1], lr <- trees l, ll <- trees (n-1-l)]


--catalan number
treesLength :: Int -> Int
treesLength = length . trees


-- tree array
treegroup n = map treesLength [0..n-1] 

-- brace tree
brace :: Tree -> String
brace Leaf = ""
brace (Node l r) = '(' : brace l ++ ")" ++ brace r


--bottle

bottle :: Int -> Int -> Int
bottle x y | resX >= 1 = resX + bottle (x - resX ) (y + resX)
         | resY >= 1 = resY + bottle (x + resY ) (y - resY * 3)
         | otherwise = 0
           where  resX = x `div` 2
                  resY = y `div` 4

bottleSolve :: Int -> Int                   
bottleSolve n = nx + bottle nx ny 
           where nx = n `div` 2
                 ny = n `div` 2   

bottleList :: Int -> [Int]
bottleList n = map bottleSolve [0,2..n]                        

-- huffTree

data Htree a = Leaf1 a | Branch (Htree a) (Htree a) deriving Show

a = [(0.4,'a'),(0.1,'b'),(0.2,'c'),(0.3,'d')]

htree [(_,t)] = t
htree ((w1,t1):(w2,t2):ws) = htree $ insertBy (comparing fst) (w1+w2, Branch t1 t2) ws

serize (Leaf1 a) = [(a, "")]
serize (Branch l r) =  [(char, '1' : code ) | (char, code) <- serize r  ] ++
                    [(char, '0' : code ) | (char, code) <- serize l  ]

huffman ws = sortBy (comparing $ length . snd) $ 
             serize $ htree $ map (\(x1,y1) -> (x1, Leaf1 y1)) $
             sortBy (comparing fst) ws

















