module Lib
    ( openUrl
    ) where

import Network.HTTP
import Text.HTML.TagSoup
openUrl :: String -> IO String
openUrl url = simpleHTTP (getRequest url) >>= getResponseBody

{-
tk = openUrl "http://www1.infracontrol.com/cykla/barometer/barometer_fi.asp?system=helsinki&mode=year"

k = fmap parseTags tk
k2 = fmap fst k

j :: IO ()
j = do
  src <- tk
  dropWhile (~/= "<font color=") $ parseTags src
  putStr src
-}
