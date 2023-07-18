module Output
( saveTextFile
, saveProject
) where

import System.IO
import DataStructure

saveTextFile :: String -> String -> IO ()
saveTextFile strFilename strContents = do
    hndFile <- openFile strFilename WriteMode
    hPutStr hndFile strContents
    hClose hndFile

saveProject :: String -> Project Task -> IO ()
saveProject strFilename lib = do
    let strProject = show lib
    saveTextFile strFilename strProject
