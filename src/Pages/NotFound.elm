module Pages.NotFound exposing (..)

import Html exposing (Html, text)
import Html.Events exposing (onClick)
import Browser
import Browser.Navigation exposing (pushUrl)
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
        Navigate cmd ->
            ( model, cmd )

        NoOp ->
            ( model, Cmd.none )


view : Model -> Browser.Document Msg
view model =
    { title = "Not Found"
    , body =
        [ Html.div [] links
        , text "Sorry we couldn't find that page!"
        ]
    }
