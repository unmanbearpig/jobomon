module ApiRoutes exposing (jobOffers)


apiRoot : String
apiRoot =
    "/api/"


apiPath : String -> String
apiPath path =
    apiRoot ++ path ++ ".json"


jobOffers : String
jobOffers =
    apiPath "job_offers"
