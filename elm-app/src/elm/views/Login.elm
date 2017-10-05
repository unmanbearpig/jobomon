module Views.Login exposing (loginPage)

import Html exposing (..)
import Html.Attributes as Attr
import Bootstrap.Form as Form
import Bootstrap.Form.Input as Input
import Routing exposing (signUpPath)
import Views.Layout exposing (layout)
import Msgs exposing (Msg(..))
import Models exposing (User)


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
        , Form.form []
            [ Form.group []
                [ Form.label [ Attr.for "email" ] [ text "Email" ]
                , Input.email [ Input.id "email" ]
                ]
            ]
        ]
