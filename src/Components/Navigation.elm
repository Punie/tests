module Components.Navigation exposing (..)

import Html exposing (Html, text, a)
import Html.Attributes exposing (href, style)


links : List (Html a)
links =
    let
        margin =
            style "margin" "0 1.0rem 1.0rem 0"
    in
        [ a [ margin, href "/" ] [ text "Home" ]
        , a [ margin, href "/about" ] [ text "About" ]
        , a [ margin, href "/posts" ] [ text "Posts" ]
        , Html.hr [] []
        ]
