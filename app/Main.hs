module Main where

import Lib

urlBikes :: String
urlBikes = "http://www1.infracontrol.com/cykla/barometer/barometer_fi.asp?system=helsinki&mode=year"

main :: IO ()
main = do
  res <- extractCount urlBikes
  putStrLn res
