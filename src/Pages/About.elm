module Pages.About exposing (..)

import Html exposing (Html, text, a)
import Html.Attributes exposing (href)
import Browser
import Components.Navigation exposing (links)


type alias Flags =
    {}


type alias Model =
    {}


type Msg
    = NoOp
    | Navigate (Cmd Msg)


init : Flags -> ( Model, Cmd Msg )
init flags =
    ( {}, Cmd.none )


update : Msg -> Model -> ( Model, Cmd Msg )
update message model =
    case message of
        NoOp ->
            ( model, Cmd.none )

        Navigate cmd ->
            ( model, cmd )


view : Model -> Browser.Document Msg
view model =
    { title = "About"
    , body =
        [ Html.div [] links
        , text "About"
        , Html.br [] []
        , a [ href "https://www.google.com.au" ] [ text "External link to Google" ]
        ]
    }
