module Routing exposing (..)

import Navigation exposing (Location)
import Models exposing (Route(..))
import UrlParser exposing (Parser(..), oneOf, map, s, top)

signUpPath : String
signUpPath = "sign_up"

jobsPath : String
jobsPath = "jobs"

matchers : Parser (Route -> a) a
matchers = oneOf
           [ map SignUpRoute (s signUpPath)
           , map JobsRoute (s jobsPath)
           , map LoginRoute top
           ]

parseLocation : Location -> Route
parseLocation location =
    Maybe.withDefault NotFoundRoute (UrlParser.parsePath matchers location)
