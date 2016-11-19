
-- sublime build test 
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