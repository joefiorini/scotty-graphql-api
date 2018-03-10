{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TypeApplications #-}
{-# LANGUAGE TypeOperators #-}
{-# LANGUAGE DataKinds #-}

-- | Serve the API as an HTTP server.
module GrapqlAPITest
  ( Config(..)
  , app
  ) where

import Protolude hiding (Text)

import Data.Text (Text)

import GraphQL
import GraphQL.API
import GraphQL.Resolver (Handler)

-- | Configuration for the application.
data Config =
  Config
  deriving (Eq, Show)

hello :: Handler IO Hello
hello = pure greeting
  where
    greeting who = pure ("Hello " <> who <> "!")

type Hello = Object "Hello" '[]
  '[ Argument "who" Text :> Field "greeting" Text
   ]

run :: Text -> IO Response
run = interpretAnonymousQuery @Hello hello

-- | Where the application goes.
app :: Text -> IO Response
app query = run query
