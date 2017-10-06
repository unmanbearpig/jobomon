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
    { email : String
    , authToken : AuthToken
    }

type alias AuthToken =
    String


type alias Model =
    { jobOffers : List JobOffer
    , log : List String
    , route : Route
    , loginStatus : LoginStatus
    , loginForm : LoginForm
    }


type alias LoginForm =
    { email : String
    , password : String
    }


type LoginStatus
    = LoginNotRequested
    | LoginRequested LoginForm
    | LoginFailed String
    | LoggedIn User


loginForm : LoginForm
loginForm =
    { email = "", password = "" }


model : Route -> Model
model route =
    { jobOffers = []
    , log = []
    , route = route
    , loginStatus = LoginNotRequested
    , loginForm = loginForm
    }
