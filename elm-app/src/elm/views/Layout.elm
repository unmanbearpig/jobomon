module Views.Layout exposing (layout)

import Html exposing (..)
import Html.Attributes as Attr
import Bootstrap.Grid as Grid
import Bootstrap.CDN as CDN
import Msgs exposing (Msg(..))

layout : List (Html Msg) -> Html Msg
layout content =
    Grid.container [] (CDN.stylesheet :: content)
