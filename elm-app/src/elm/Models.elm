module Models exposing (..)

type Route
    = LoginRoute
    | SignUpRoute
    | JobsRoute
    | NotFoundRoute

type alias JobOffer =
    { title : String
    , url : String
    , id : Int
    , content : String
    }

type alias User =
    { email : String }


type alias Model =
    { jobOffers : List JobOffer
    , log : List String
    , route : Route
    , user : Maybe User
    }


model : Route -> Model
model route =
    { jobOffers = []
    , log = []
    , route = route
    , user = Nothing
    }
