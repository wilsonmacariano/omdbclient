{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE DeriveGeneric #-}

module OmdbApi where

import Network.Wreq
import Control.Lens ( (^?) )
import Data.Aeson ( Value
                  , ToJSON
                  , FromJSON
                  , toEncoding
                  , parseJSON
                  , genericToEncoding
                  , defaultOptions
                  , encode
                  , decode
                  , (.:)
                  , (.=) )
import Data.Monoid ( (<>) )
import Data.Aeson.Types
import Data.Aeson.Lens ( key )
import Data.ByteString.Lazy.Internal as BS
import Data.Text ( Text , pack )

data Movie = Movie { imdbID :: Text
                   , title :: Text
                   , year :: Int
                   , mediaType :: Text
                   , poster :: Text }
             deriving (Show)

instance ToJSON Movie where
  toJSON (Movie imdbID title year mediaType poster) =
    object [ "imdbId" .= imdbID
           , "Title" .= title
           , "Year" .= year
           , "Type" .= mediaType
           , "Poster" .= poster ]
  toEncoding (Movie imdbID title year mediaType poster) =
    pairs ("id" .= imdbID
           <> "title" .= title
           <> "year" .= year
           <> "type" .= mediaType
           <> "poster" .= poster)

instance FromJSON Movie where
  parseJSON (Object v) = Movie <$>
                         v .: "imdbID" <*>
                         v .: "Title" <*>
                         v .: "Year" <*>
                         v .: "Type" <*>
                         v .: "Poster"
  parseJSON _ = fail "fucking failed"

byteStringToMovie :: ByteString -> [Movie]
byteStringToMovie = undefined

byTitle' :: String -> IO (Response ByteString)
byTitle' = get . (++) "http://www.omdbapi.com/?s="

