module Input
  ( loadFromTextFile,
  )
where

import DataStructure
import System.IO

loadFromTextFile :: (Read a) => String -> IO a
loadFromTextFile strFilename = do
  hndFile <- openFile strFilename ReadMode
  strEntity <- hGetContents hndFile
  let recLib = read strEntity
  putStrLn $ "Loaded: " ++ strEntity
  hClose hndFile
  return recLib