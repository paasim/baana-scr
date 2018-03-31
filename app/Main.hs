module Main where

import Scrape
import DB

urlBikes :: String
urlBikes = "http://www1.infracontrol.com/cykla/barometer/barometer_fi.asp?system=helsinki&mode=year"

main :: IO ()
main = extractCount urlBikes >>= writeValToDB
