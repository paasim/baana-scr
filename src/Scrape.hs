module Scrape ( extractCount ) where

import Data.Char
import Network.HTTP
import Text.HTML.TagSoup

startsWithDigit :: String -> Bool
startsWithDigit (x:_) = isDigit x
startsWithDigit _ = False

readNums :: Read a => [String] -> [a]
readNums = fmap (read . filter isDigit) . filter startsWithDigit

textFromTags :: [Tag String] -> [String]
textFromTags = fmap fromTagText . filter isTagText

getPageNums :: String -> IO [Int]
getPageNums = (readNums . textFromTags . parseTags <$>) . (>>= getResponseBody) . simpleHTTP . getRequest

extractCount :: String -> IO Int
extractCount = fmap head . getPageNums
