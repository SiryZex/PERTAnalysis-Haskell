module Process
( calculateValues
, calculateSlack
, toXML
) where

import DataStructure
import Data.List

dependsOn :: Task -> Task -> Bool
dependsOn EmptyTask _ = False
dependsOn _ EmptyTask = False
dependsOn t1 t2 = t2 `elem` predecessors t1

immediatePreds :: Task -> [Task] -> [Task]
immediatePreds EmptyTask _ = []
immediatePreds _ [] = []
immediatePreds t ts = preds
        where candPred = [(dependsOn t c, c) | c <- ts]
              preds = map snd $ filter fst candPred

calculateES :: Project Task -> Task -> Double
calculateES EmptyProject _ = 0
calculateES _ EmptyTask = 0
calculateES p t = maximum $ map earlyFinish $ immediatePreds t (task p)

calculateEF :: Task -> Double
calculateEF  EmptyTask = 0
calculateEF t = earlyStart t + duration t

xmlTask :: Task -> String
xmlTask EmptyTask = ""
xmlTask t = "taskName='" ++ tn ++ "'>" ++ contents ++ "</task>"
        where es = "<es>" ++ show (earlyStart t) ++ "</es>"
              d = "<duration>" ++ show (duration t) ++ "</duration>"
              ef = "<ef>" ++ show (earlyFinish t) ++ "</ef>"
              ls = "<ls>" ++ show (lateStart t) ++ "</ls>"
              s = "<slack>" ++ show (slack t) ++ "</slack>"
              lf = "<lf>" ++ show (lateFinish t) ++ "</lf>"
              tn = taskName t
              contents = concat [es, d, ef, ls, s, lf]

xmlTaskList :: [Task] -> String
xmlTaskList = foldr ((++) . xmlTask) ""

toXML :: Project Task -> String
toXML EmptyProject = ""
toXML p =
    let
        pn = projectName p
        ts = xmlTaskList $ tasks p
    in "project name='" ++ pn ++ "'><tasks>" ++ ts ++ "</tasks></project>"

instance Functor Project where
    fmap f EmptyProject = EmptyProject
    fmap f p = Project {projectName = projectName p, tasks = map f $ tasks p}