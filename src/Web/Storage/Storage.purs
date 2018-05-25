module Web.Storage.Storage
  ( Storage
  , length
  , key
  , getItem
  , setItem
  , removeItem
  , clear
  ) where

import Prelude

import Data.Maybe (Maybe)
import Data.Nullable (Nullable, toMaybe)
import Effect (Effect)

foreign import data Storage :: Type

foreign import length :: Storage -> Effect Int

foreign import _key :: Int -> Storage -> Effect (Nullable String)

key :: Int -> Storage -> Effect (Maybe String)
key i = map toMaybe <<< _key i

foreign import _getItem :: String -> Storage -> Effect (Nullable String)

getItem :: String -> Storage -> Effect (Maybe String)
getItem s = map toMaybe <<< _getItem s

foreign import setItem :: String -> String -> Storage -> Effect Unit

foreign import removeItem :: String -> Storage -> Effect Unit

foreign import clear :: Storage -> Effect Unit
