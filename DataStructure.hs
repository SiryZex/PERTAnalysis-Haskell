module DataStructure
( Task(..)
, Project(..)
) where

data Task = Task { earlyStart :: Double
                 , duration :: Double
                 , earlyFinish :: Double
                 , taskName :: String
                 , lateStart :: Double
                 , slack :: Double
                 , lateFinish :: Double
                 , predecessors :: [Task]
                } | EmptyTask deriving (Eq, Show, Read)

data Project a = Project { projectName :: String
                         , tasks :: [a]
                         } | EmptyProject deriving (Eq, Show, Read)