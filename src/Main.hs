module Main where

import Control.Concurrent
import System.Environment
import System.IO
import Network.Socket


replyFn :: Handle -> IO ()
replyFn hdl = do
	inpStr <- hGetLine hdl
	hPutStr hdl ("HTTP/1.1 200 OK\r\n\r\n")
	hPutStr hdl ("Testing")


-- socket to listen on a port
openSocket :: PortNumber -> IO Socket
openSocket port = do
	sock <- socket AF_INET Stream 0
	setSocketOption sock ReuseAddr 1
	bind sock (SockAddrInet port iNADDR_ANY)
	listen sock 5
	return sock


respond :: (Handle -> IO ()) -> (Socket, SockAddr) -> IO ()
respond handler (sock, _) = do
	hdl <- socketToHandle sock ReadWriteMode
	hSetBuffering hdl NoBuffering
	handler hdl
	hClose hdl


mainLoop :: (Handle -> IO ()) -> Socket -> IO ()
mainLoop handler sock = do
	putStrLn "Wait for connection..."
	connection <- accept sock
	forkIO (respond handler connection)
	mainLoop handler sock   


-- opens port 8080 and applies handler to recieved connections
acceptLoop :: (Handle -> IO ()) -> IO ()
acceptLoop handler = do
	sock <- openSocket 8080
	mainLoop handler sock


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
	acceptLoop replyFn
