import qualified Data.List as List
import qualified Data.Set as Set

data Expr = App Expr Expr | Lam Int Expr | Var Int deriving (Show, Eq)

-- Exercise 1
-- Seems to work well.

freeVariables :: Expr -> [Int]
freeVariables (Lam x e1) = freeVariables e1 List.\\ [x]
freeVariables (Var x) = [x]
freeVariables (App e1 e2) = (freeVariables e1) ++ (freeVariables e2)

-- Exercise 2
-- not fully functional - needs work. 

rename :: Expr -> Int -> Int -> Expr
rename (Lam x e1) v1 v2 | x == v1 && (elem x (freeVariables e1)) = Lam (v2) (rename e1 v1 v2) | otherwise = Lam (x) (rename e1 v1 v2)
rename (Var x) v1 v2 | x == v1 = Var v2 | otherwise = Var x
rename (App e1 e2) v1 v2 = App (rename e1 v1 v2) (rename e2 v1 v2)


-- Exercise 3

--alphaEquivalent :: Expr -> Expr -> Bool
--alphaEquivalent e1 e2 = all (\x -> x elem (alphaEquivalent' e1 -1)) (alphaEquivalent' e2 -1)
--alphaEquivalent e1 e2 =  (alphaEquivalent' e1 10) Set.isSubsetOf (alphaEquivalent' e2 -10)



-- Exercise 4

hasRedex :: Expr -> Bool
hasRedex (Lam x e1) = hasRedex' e1
hasRedex (Var x) = False
hasRedex (App e1 e2) = hasRedex' (App e1 e2)

hasRedex' :: Expr -> Bool
hasRedex' (Lam x e1) = True
hasRedex' (App e1 e2) | (hasRedex' e1 == False && hasRedex' e2 == False) = False | otherwise = True
hasRedex' (Var x) = False