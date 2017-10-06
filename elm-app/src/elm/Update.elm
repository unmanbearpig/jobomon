module Update exposing (update, getJobOffers)

import Http
import Json.Decode as Decode
import Msgs exposing (..)
import Models exposing (..)
import ApiRoutes
import Routing exposing (parseLocation)


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


requestLogin : LoginForm -> Cmd Msg
requestLogin loginForm =
    let
        url =
            ApiRoutes.login

        body =
            encodeLogin loginForm
    in
        Http.send ReceiveAuthToken (Http.post url body decodeAuthToken)


decodeAuthToken : Decode.Decoder AuthToken
decodeAuthToken =
    Decode.field "jwt" Decode.string


encodeLogin : LoginForm -> Http.Body
encodeLogin form =
    Http.multipartBody
        [ Http.stringPart "auth[email]" form.email
        , Http.stringPart "auth[password]" form.password
        ]


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

        UrlChange location ->
            ( { model | route = parseLocation location }, Cmd.none )

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

        RequestLogin loginForm ->
            ( { model | loginStatus = LoginRequested loginForm }, (requestLogin loginForm) )

        ReceiveAuthToken loginResponse ->
            case loginResponse of
                Ok authToken ->
                    let
                        user =
                            { email = model.loginForm.email, authToken = authToken }
                    in
                        ( { model | loginStatus = LoggedIn user }, Cmd.none )
                Err error ->
                    ( { model | loginStatus = LoginFailed (toString error) }, Cmd.none )

        ModifyLoginFormEmail email ->
            let
                oldForm =
                    model.loginForm

                newForm =
                    { oldForm | email = email }
            in
                ( { model | loginForm = newForm }, Cmd.none )

        ModifyLoginFormPassword password ->
            let
                oldForm =
                    model.loginForm

                newForm =
                    { oldForm | password = password }
            in
                ( { model | loginForm = newForm }, Cmd.none )
