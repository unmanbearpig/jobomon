module Config exposing (apiPath)


apiRoot : String
apiRoot =
    "/api/"


apiPath : String -> String
apiPath path =
    apiRoot ++ path ++ ".json"
