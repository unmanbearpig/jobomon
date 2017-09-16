module View exposing (view)

import Html exposing (..)
import Msgs exposing (..)
import Models exposing (..)
import Html.Events exposing (onClick)
import Bootstrap.CDN as CDN
import Bootstrap.Grid as Grid
import Bootstrap.Grid.Col as Col
import Bootstrap.Grid.Row as Row
import Bootstrap.Button as Button
import Html.Attributes as Attr

renderJobOffer : JobOffer -> Html Msg
renderJobOffer offer =
    li [] [ text offer.title ]


jobOffersView : List JobOffer -> Html Msg
jobOffersView offers =
    ul [ Attr.class "mt-4" ] (List.map renderJobOffer offers)


renderLogMessage : String -> Html Msg
renderLogMessage str =
    li [] [ text str ]


logView : List String -> Html Msg
logView logMessages =
    div []
        [ h1 [] [ text "Log" ]
        , ul [ Attr.class "mt-4" ] (List.map renderLogMessage logMessages)
        ]


fetchJobOffersButton : Html Msg
fetchJobOffersButton =
    Button.button
        [ Button.outlinePrimary
        , Button.attrs
            [ onClick FetchJobOffers
            , Attr.class "mt-2"
            ] ]
        [ text "Refresh" ]


mainContent : Model -> List (Html Msg)
mainContent model =
    [ h1 [] [ text ("Job offers") ]
    , fetchJobOffersButton
    , jobOffersView model.jobOffers
    ]


view : Model -> Html Msg
view model =
    Grid.container []
        [ Grid.row [ Row.attrs [ Attr.class "mt-4" ] ]
            [ Grid.col [ Col.sm8 ] (CDN.stylesheet :: (mainContent model))
            , Grid.col [ Col.sm4 ] [ logView model.log ]
            ]
        ]
