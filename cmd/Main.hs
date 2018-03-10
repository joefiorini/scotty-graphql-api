{-# LANGUAGE OverloadedStrings #-}
-- | Launch haskell-graphql-api-test server.
module Main
  ( main
  ) where

import Protolude hiding (decodeUtf8)
import Web.Scotty

-- import Options.Applicative
--        (ParserInfo, execParser, fullDesc, header, helper, info, progDesc)

import Data.Aeson (encode)
import Data.Text.Lazy (toStrict)
import Data.Text.Lazy.Encoding (decodeUtf8)
-- import GraphQL
import GraphQL.Value.ToValue (ToValue(..))
import GrapqlAPITest (-- Config(..),
                      app)

-- -- | Parse the configuration from the command line.
-- options :: ParserInfo Config
-- options = info (helper <*> parser) description
--   where
--     parser = pure Config
--     description =
--       fold
--         [ fullDesc
--         , progDesc "Testing out how easy it is to build a graphql api with haskell graphql-api library"
--         , header "haskell-graphql-api-test - TODO fill this in"
--         ]

main :: IO ()
main = scotty 3000 $ do
  -- response <- app
  -- putStrLn $ encode $ toValue response
  post "/graphql" $ do
    b <- body
    response <- liftAndCatchIO $ app $ toStrict $ decodeUtf8 b
    raw $ encode $ toValue response

  
