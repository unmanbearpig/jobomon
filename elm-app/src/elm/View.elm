module View exposing (view)

import Html exposing (..)
import Html.Attributes as Attr
import Msgs exposing (..)
import Models exposing (..)
import Html.Events exposing (onClick)
import Bootstrap.CDN as CDN
import Bootstrap.Grid as Grid
import Bootstrap.Grid.Col as Col
import Bootstrap.Grid.Row as Row
import Bootstrap.Button as Button
import Html.Attributes as Attr
import Bootstrap.Form as Form
import Bootstrap.Form.Input as Input
import Routing exposing (signUpPath)

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
            ]
        ]
        [ text "Refresh" ]


mainContent : Model -> List (Html Msg)
mainContent model =
    [ h1 [] [ text ("Job offers") ]
    , fetchJobOffersButton
    , jobOffersView model.jobOffers
    ]


layout : List (Html Msg) -> Html Msg
layout content =
    Grid.container [] (CDN.stylesheet :: content)


jobsPage : Model -> Html Msg
jobsPage model =
    Grid.container []
        [ Grid.row [ Row.attrs [ Attr.class "mt-4" ] ]
            [ Grid.col [ Col.sm8 ] (CDN.stylesheet :: (mainContent model))
            , Grid.col [ Col.sm4 ] [ logView model.log ]
            ]
        ]


notImplemented : Html Msg
notImplemented =
    div [] [ text "not implemented yet" ]


pageNotFound : Route -> Html Msg
pageNotFound route =
    div [] [ text "page not found" ]


renderUser : Maybe User -> Html Msg
renderUser maybeUser =
    let
        userHtml =
            case maybeUser of
                Just user ->
                    div [] [ text ("Logged in as " ++ user.email) ]

                Nothing ->
                    div [] [ text "Not logged in" ]
    in
        div [] [ userHtml ]


loginPage : Maybe User -> Html Msg
loginPage maybeUser =
    layout
        [ h1 [ Attr.class "page-header" ] [ text "Log in" ]
        , a [ Attr.href signUpPath ] [ text "Sign up" ]
        , div [] [ renderUser maybeUser ]
        , Form.form [] [ Form.group []
                             [ Form.label [ Attr.for "email" ] [ text "Email" ]
                             , Input.email [ Input.id "email" ]
                             ]
                       ]
        ]


view : Model -> Html Msg
view model =
    case model.route of
        LoginRoute ->
            loginPage model.user

        SignUpRoute ->
            notImplemented

        JobsRoute ->
            jobsPage model

        NotFoundRoute ->
            pageNotFound model.route
