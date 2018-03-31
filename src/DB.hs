{-# LANGUAGE OverloadedStrings #-} -- Needed for Char -> Query

module DB ( writeValToDB ) where

import Database.SQLite.Simple (close, execute, execute_, open)
import Data.Time (formatTime, defaultTimeLocale, getZonedTime)

timeStamp :: IO String
timeStamp = formatTime defaultTimeLocale "%F %H:%M" <$> getZonedTime

-- drop newline from the end of the line
dbFile :: String -> IO String
dbFile = (filter (/= '\n') <$>) . readFile

-- add timestamp to a value
addTS :: a -> IO (String, a)
addTS = (<$> timeStamp) . flip (,)

writeRowToDB :: (String, Int) -> IO ()
writeRowToDB val = do
  conn <- dbFile "db_dir.txt" >>= open
  execute_ conn "CREATE TABLE IF NOT EXISTS baana(date TEXT, value INT)"
  execute conn "INSERT INTO baana (date, value) VALUES (?,?)" val
  close conn

writeValToDB :: Int -> IO ()
writeValToDB = (>>= writeRowToDB) . addTS
