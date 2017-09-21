-- Copyright 2016 Ian D. Bollinger
--
-- Licensed under the MIT license <LICENSE or
-- http://opensource.org/licenses/MIT>. This file may not be copied, modified,
-- or distributed except according to those terms.

-- | Provides bindings for the
-- | [web storage API](https://html.spec.whatwg.org/multipage/webstorage.html).
module Web.Storage
  ( STORAGE
  , Storage
  , local
  , session
  , length
  , key
  , getItem
  , setItem
  , removeItem
  , clear
  ) where

import Prelude
import Control.Monad.Eff (Eff, kind Effect)
import Control.Monad.Eff.Exception (EXCEPTION)
import Data.Nullable as Nullable
import Data.Nullable (Nullable)
import Data.Maybe (Maybe)

-- | The web storage effect.
foreign import data STORAGE :: Effect

-- | Provides access to a list of key/value pairs.
foreign import data Storage :: Type

-- | Storage that persists between browsing sessions.
foreign import local :: forall eff. Eff (storage :: STORAGE | eff) Storage

-- | Like `local` storage, but is cleared when the browser is closed.
foreign import session :: forall eff. Eff (storage :: STORAGE | eff) Storage

-- | The number of key/value pairs currently in storage.
foreign import length
  :: forall eff
   . Storage
  -> Eff (storage :: STORAGE | eff) Int

-- | `key n` is the name of the *n*th key in storage.
-- |
-- | The order of keys is user-agent defined, but is consistent so long as the
-- | number of keys doesn't change. If *n* is negative or greater than or equal
-- | to the number of key/value pairs in storage, this function returns
-- | `Nothing`.
key
  :: forall eff
   . Int
  -> Storage
  -> Eff (storage :: STORAGE | eff) (Maybe String)
key index storage = Nullable.toMaybe <$> keyForeign index storage

foreign import keyForeign
  :: forall eff
   . Int
  -> Storage
  -> Eff (storage :: STORAGE | eff) (Nullable String)

-- | The value associated with the given key in storage.
-- |
-- | If the given key does not exist in storage, this function returns
-- | `Nothing`.
getItem 
  :: forall eff
   . String
  -> Storage
  -> Eff (storage :: STORAGE | eff) (Maybe String)
getItem key' storage = Nullable.toMaybe <$> getItemForeign key' storage

foreign import getItemForeign
  :: forall eff
   . String
  -> Storage
  -> Eff (storage :: STORAGE | eff) (Nullable String)

-- | Add a new key/value pair to storage if a pair with the given key doesn't
-- | yet exist; otherwise, replace the existing pair.
-- |
-- | If a previous value is equal to the new value, this function does nothing.
-- | If this function can't set a new value, it throws an exception. This can
-- | occur if the user has disabled web storage, or if the storage quota has
-- | been exceeded, for example.
foreign import setItem
  :: forall eff
   . String
  -> String
  -> Storage
  -> Eff (storage :: STORAGE, err :: EXCEPTION | eff) Unit

-- | Remove the key/value pair with the given key from storage.
-- |
-- | If no pair with that key exists, this function does nothing.
foreign import removeItem
  :: forall eff
   . String
  -> Storage
  -> Eff (storage :: STORAGE | eff) Unit

-- | Atomically empty storage of all key/value pairs.
-- |
-- | If there are no key/value pairs, this function does nothing.
foreign import clear
  :: forall eff
   . Storage
  -> Eff (storage :: STORAGE | eff) Unit
