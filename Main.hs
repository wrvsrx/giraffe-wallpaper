{-# LANGUAGE OverloadedStrings #-}

import System.Environment (getArgs)
import System.Process (callProcess)

main :: IO ()
main = do
  args <- getArgs
  let
    black = "black.png"
    squarePng = "giraffe.png"
    outputPng = "output.png"
    svg = head args
    width = read (args !! 1) :: Integer
    height = read (args !! 2) :: Integer
    scale x = x * 2 `div` 3
  callProcess "convert" ["-size", show width <> "x" <> show height, "xc:black", black]
  callProcess "inkscape" (["--export-type", "png", "--export-filename", squarePng] <> (if width > height then ["-h", show (scale height)] else ["-w", show (scale width)]) <> [svg])
  callProcess "convert" [black, squarePng, "-gravity", "Center", "-composite", outputPng]
