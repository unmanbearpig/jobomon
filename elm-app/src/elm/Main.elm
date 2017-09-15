module Main exposing (..)

import Html exposing (program)
import Models exposing (Model, model)
import Msgs exposing (Msg)
import Update exposing (update, getJobOffers)
import View exposing (view)


-- APP


main =
    Html.program
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }


init : ( Model, Cmd Msg )
init =
    ( model, getJobOffers )



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none
