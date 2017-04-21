module Main where

import System.Environment
import System.IO


printArray :: [String] -> IO ()
printArray [] = do
    return ()
printArray (x:xs) = do
    putStrLn x
    printArray xs


printArgs :: IO ()
printArgs = do
    args <- getArgs
    printArray args


main :: IO ()
main = do
    printArgs
