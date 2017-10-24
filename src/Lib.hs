module Lib
    ( extractCount
    ) where

import Network.HTTP
import Text.HTML.TagSoup

getPage :: String -> IO String
getPage url = simpleHTTP (getRequest url) >>= getResponseBody

getParsedPage :: String -> IO [Tag String]
getParsedPage url = fmap parseTags (getPage url)

extractCount :: String -> IO (String)
extractCount url =
  fmap
-- !! 1 because the count is the first element after dropWhile
    (fromTagText . (\x -> x !! 1) . (dropWhile (~/= "<font color")))
    (getParsedPage url)

