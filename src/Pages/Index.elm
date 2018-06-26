module Pages.Index exposing (..)

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
    { title = "Home"
    , body =
        [ -- , Html.button [ onClick <| Navigate <| pushUrl "/about" ] [ text "About" ]
          Html.div [] links
        , text "Home"
        ]
    }


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none
