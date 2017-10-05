module Msgs exposing (..)

import Http
import Models exposing (JobOffer)
import Navigation

type Msg
    = NoOp
    | UrlChange Navigation.Location
    | FetchJobOffers
    | ReceiveJobOffers (Result Http.Error (List JobOffer))
