{-# LANGUAGE OverloadedStrings #-}
module OmdbApi where

import Network.Wreq
import Control.Lens
import Data.Map as Map
import Data.Aeson (Value)
import Data.Aeson.Lens (key)



