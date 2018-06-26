module Pages.Post exposing (..)

import Html exposing (Html, text)
import Browser
import Components.Navigation exposing (links)


type alias Flags =
    { id : String }


type alias Model =
    { id : String }


type Msg
    = NoOp
    | Navigate (Cmd Msg)


init : Flags -> ( Model, Cmd Msg )
init flags =
    ( { id = flags.id }, Cmd.none )


update : Msg -> Model -> ( Model, Cmd Msg )
update message model =
    case message of
        NoOp ->
            ( model, Cmd.none )

        Navigate cmd ->
            ( model, cmd )


view : Model -> Browser.Document Msg
view model =
    { title = model.id
    , body =
        [ Html.div [] links
        , text model.id
        ]
    }
