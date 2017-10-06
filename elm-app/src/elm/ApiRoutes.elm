module ApiRoutes exposing (jobOffers, login)


apiRoot : String
apiRoot =
    "/api/"


apiPath : String -> String
apiPath path =
    apiRoot ++ path ++ ".json"


jobOffers : String
jobOffers =
    apiPath "job_offers"

login : String
login =
    apiPath "user_token"
