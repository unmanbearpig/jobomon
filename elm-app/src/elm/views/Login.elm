module Views.Login exposing (loginPage)

import Html exposing (..)
import Html.Attributes as Attr
import Html.Events exposing (onSubmit, onInput)
import Bootstrap.Button as Button
import Bootstrap.Form as Form
import Bootstrap.Form.Input as Input
import Routing exposing (signUpPath)
import Views.Layout exposing (layout)
import Msgs exposing (Msg(..))
import Models exposing (User, LoginStatus(..), LoginForm)


renderStatus : LoginStatus -> Html Msg
renderStatus status =
    let
        message =
            case status of
                LoginNotRequested ->
                    "Not logged in"

                LoginRequested form ->
                    "Logging in as " ++ form.email

                LoginFailed error ->
                    "Failed to log in: " ++ error

                LoggedIn user ->
                    "Logged in as " ++ user.email
    in
        div [] [ text message ]


renderLoginForm : LoginForm -> Html Msg
renderLoginForm loginForm =
    Form.form [ onSubmit (RequestLogin loginForm) ]
        [ Form.group []
            [ Form.label [ Attr.for "email" ] [ text "Email" ]
            , Input.email [ Input.id "email", Input.attrs [ onInput ModifyLoginFormEmail ] ]
            ]
        , Form.group []
            [ Form.label [ Attr.for "password" ] [ text "Password" ]
            , Input.password [ Input.id "password", Input.attrs [ onInput ModifyLoginFormPassword ] ]
            ]
        , Button.button [ Button.primary ] [ text "Log in" ]
        ]


loginPage : LoginForm -> LoginStatus -> Html Msg
loginPage loginForm status =
    layout
        [ h1 [ Attr.class "page-header" ] [ text "Log in" ]
        , a [ Attr.href signUpPath ] [ text "Sign up" ]
        , div [] [ renderStatus status ]
        , renderLoginForm loginForm
        ]
