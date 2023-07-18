module Main 
(
  main
) where

import DataStructure
import System.IO
import Process
import Input
import Output
import Graphics.Rendering.OpenGL (project)

main :: IO ()
main = do
    project <- loadFromTextFile "Project.txt"
    let p2 = fmap (\n -> Task { taskName = taskName n
                              , earlyStart = earlyStart n
                              , duration = duration n
                              , earlyFinish = earlyFinish n
                              , lateStart = lateStart n
                              , slack = calculateSlack n
                              , lateFinish = lateFinish n
                              , predecessors = predecessors n
                              }) project

    let xml = toXML project
    saveTextFile "project.xml" xml