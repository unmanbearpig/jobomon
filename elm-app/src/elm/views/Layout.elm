module Views.Layout exposing (bsLayout, layout)

import Html exposing (..)
import Html.Attributes as Attr
import Bootstrap.Grid as Grid
import Bootstrap.Grid.Row as Row
import Bootstrap.Grid.Col as Col
import Bootstrap.CDN as CDN
import Msgs exposing (Msg(..))


bsLayout : List (Html Msg) -> Html Msg
bsLayout content =
    Grid.container []
        [ CDN.stylesheet
        , Grid.row [ Row.attrs [ Attr.class "mt-4" ] ]
            [ Grid.col [ Col.sm8 ] (content) ]
        ]


layout : List (Html Msg) -> Html Msg
layout content =
    Grid.container [] (CDN.stylesheet :: content)
