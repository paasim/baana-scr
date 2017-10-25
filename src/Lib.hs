module Lib
    ( extractCount
    ) where

import Data.Char
import Network.HTTP
import Text.HTML.TagSoup

getPage :: String -> IO String
getPage url = simpleHTTP (getRequest url) >>= getResponseBody

getParsedPage :: String -> IO [Tag String]
getParsedPage url = fmap parseTags (getPage url)

-- !! 1 because the count is the first element after dropWhile
extractCount :: String -> IO (Int)
extractCount url = fmap (tagTextToInt . findElem) (getParsedPage url)
  where  tagTextToInt = read . filter isDigit . fromTagText
         findElem     = (!!1) . dropWhile (~/= "<font color")

