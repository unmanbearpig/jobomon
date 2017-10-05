module Routing exposing (..)

import Navigation exposing (Location)
import Models exposing (Route(..))
import UrlParser exposing (Parser(..), oneOf, map, s, top)

signUpPath : String
signUpPath = "sign_up"

matchers : Parser (Route -> a) a
matchers = oneOf
           [ map SignUpRoute (s signUpPath)
           , map JobsRoute (s "jobs")
           , map LoginRoute top
           ]

parseLocation : Location -> Route
parseLocation location =
    Maybe.withDefault NotFoundRoute (UrlParser.parsePath matchers location)
