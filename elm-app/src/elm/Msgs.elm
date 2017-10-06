module Msgs exposing (..)

import Http
import Models exposing (JobOffer, LoginForm, LoginStatus, AuthToken)
import Navigation


type Msg
    = NoOp
    | UrlChange Navigation.Location
    | FetchJobOffers
    | ReceiveJobOffers (Result Http.Error (List JobOffer))
    | RequestLogin (LoginForm)
    | ReceiveAuthToken (Result Http.Error AuthToken)
    | ModifyLoginFormEmail String
    | ModifyLoginFormPassword String
