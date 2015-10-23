module Main where

import Data.Proxy
import TypeFun.Data.List

-- | This function has wider constraint __Int is inside l__
elemConstr :: (Elem Int l) => proxy l -> Int
elemConstr p = 1

-- | This function has narrower constraint than 'elemConstr'
-- __Int and Bool are contained in l__
sublistConstr :: (SubList '[Int, Bool] l) => proxy l -> Int
sublistConstr p = elemConstr p + 1

-- | This function has narrower constraint than 'sublistConstr' (Order
-- of elements matters)
prefixConstr :: (IsPrefixOf '[Int, Bool] l) => proxy l -> Int
prefixConstr p = sublistConstr p + 1

-- | This function has narrower constraint __Int is inside of l and it
-- is a first argument__ and uses inside more wide function
indexConstr :: (('Just 0) ~ (IndexOf Int l)) => proxy l -> Int
indexConstr p = elemConstr p + 1

main :: IO ()
main = do
  let
    p2 = Proxy :: Proxy '[Int, Bool]
    p3 = Proxy :: Proxy '[Int, Bool, String]
  print $ indexConstr p2
  print $ sublistConstr p2
  print $ prefixConstr p2
  print $ prefixConstr p3