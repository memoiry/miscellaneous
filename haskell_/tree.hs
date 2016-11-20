

import Data.List (insertBy, sortBy)
import Data.Ord (comparing)


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













 