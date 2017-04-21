module Main where

printArgs :: IO ()
printArgs =


main :: IO ()
main = do
    (command:args) <- getArgs
    putStrLn ("Command: " ++ command)
    putStrLn ("Args: " ++ args)
