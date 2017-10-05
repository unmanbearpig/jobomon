module Main exposing (..)

-- import Html exposing (program)

import Models exposing (Model, model)
import Msgs exposing (Msg(..))
import Update exposing (update, getJobOffers)
import View exposing (view)
import Navigation
import Routing


-- APP


main =
    Navigation.program UrlChange
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }


init : Navigation.Location -> ( Model, Cmd Msg )
init location =
    ( (model (Routing.parseLocation location)), getJobOffers )



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none
