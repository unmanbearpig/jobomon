module View exposing (view)

import Html exposing (..)
import Msgs exposing (..)
import Models exposing (..)
import Html.Events exposing (onClick)


renderJobOffer : JobOffer -> Html Msg
renderJobOffer offer =
    li [] [ text offer.title ]


jobOffersView : List JobOffer -> Html Msg
jobOffersView offers =
    ul [] (List.map renderJobOffer offers)


renderLogMessage : String -> Html Msg
renderLogMessage str =
    li [] [ text str ]


logView : List String -> Html Msg
logView logMessages =
    div []
        [ h1 [] [ text "Log" ]
        , ul [] (List.map renderLogMessage logMessages)
        ]


fetchJobOffersButton : Html Msg
fetchJobOffersButton =
    button [ onClick FetchJobOffers ] [ text "Refresh" ]


view : Model -> Html Msg
view model =
    div []
        [ h1 [] [ text ("Job offers") ]
        , fetchJobOffersButton
        , jobOffersView model.jobOffers
        , logView model.log
        ]
