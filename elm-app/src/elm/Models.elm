module Models exposing (..)


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
