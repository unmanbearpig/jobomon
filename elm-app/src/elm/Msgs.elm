module Msgs exposing (..)

import Http
import Models exposing (JobOffer)


type Msg
    = NoOp
    | FetchJobOffers
    | ReceiveJobOffers (Result Http.Error (List JobOffer))
