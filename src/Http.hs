module Http where

-- parse http request
httpHandler :: Handle -> IO ()
httpHandler hdl = do
	inpStr <- hGetLine hdl
	hPutStrLn hdl ("Test\n\n")
