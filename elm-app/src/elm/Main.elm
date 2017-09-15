module Main exposing (..)

import Html exposing (..)
import Html.Events exposing (onClick)
import Http
import Json.Decode as Decode
import Result exposing (..)


-- APP


apiRoot : String
apiRoot =
    "/api/"


apiPath : String -> String
apiPath path =
    apiRoot ++ path ++ ".json"


main =
    Html.program
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }



-- MODEL


type alias JobOffer =
    { title : String
    , url : String
    , id : Int
    , content : String
    }


type alias Model =
    { jobOffers : List JobOffer
    , log : List String
    }


model : Model
model =
    { jobOffers = []
    , log = []
    }


init : ( Model, Cmd Msg )
init =
    ( model, getJobOffers )



-- UPDATE


type Msg
    = NoOp
    | FetchJobOffers
    | ReceiveJobOffers (Result Http.Error (List JobOffer))


log : Model -> String -> Model
log model textMsg =
    { model | log = model.log ++ [ textMsg ] }


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


getJobOffers : Cmd Msg
getJobOffers =
    let
        url =
            apiPath "job_offers"
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



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none



-- VIEW
-- Html is defined as: elem [ attribs ][ children ]
-- CSS can be applied via class names or inline style attrib


renderJobOffer : JobOffer -> Html Msg
renderJobOffer offer =
    li [] [ text offer.title ]


jobOffersView : List JobOffer -> Html Msg
jobOffersView offers =
    ul [] (List.map renderJobOffer offers)


renderLogMessage : String -> Html Msg
renderLogMessage str =
    li [] [ text str ]


logView : List String -> Html Msg
logView logMessages =
    div []
        [ h1 [] [ text "Log" ]
        , ul [] (List.map renderLogMessage logMessages)
        ]


fetchJobOffersButton : Html Msg
fetchJobOffersButton =
    button [ onClick FetchJobOffers ] [ text "Refresh" ]


view : Model -> Html Msg
view model =
    div []
        [ h1 [] [ text ("Job offers") ]
        , fetchJobOffersButton
        , jobOffersView model.jobOffers
        , logView model.log
        ]
