module Update exposing (update, getJobOffers)

import Http
import Json.Decode as Decode
import Msgs exposing (..)
import Models exposing (..)
import ApiRoutes


log : Model -> String -> Model
log model textMsg =
    { model | log = model.log ++ [ textMsg ] }


getJobOffers : Cmd Msg
getJobOffers =
    let
        url =
            ApiRoutes.jobOffers
    in
        Http.send ReceiveJobOffers (Http.get url decodeJobOffers)


decodeJobOffers : Decode.Decoder (List JobOffer)
decodeJobOffers =
    Decode.at [ "job_offers" ] (Decode.list decodeJobOffer)


decodeJobOffer : Decode.Decoder JobOffer
decodeJobOffer =
    Decode.map4 JobOffer
        (Decode.field "title" Decode.string)
        (Decode.field "url" Decode.string)
        (Decode.field "id" Decode.int)
        (Decode.field "content" Decode.string)


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NoOp ->
            ( model, Cmd.none )

        FetchJobOffers ->
            ( (log model "Fetching job offers..."), getJobOffers )

        ReceiveJobOffers resultJobOffers ->
            let
                newModel =
                    case resultJobOffers of
                        Ok jobOffers ->
                            log { model | jobOffers = jobOffers } "Fetched job offers."

                        Err error ->
                            log model (toString error)
            in
                ( newModel, Cmd.none )
