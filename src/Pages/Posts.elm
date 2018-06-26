module Pages.Posts exposing (..)

import Html exposing (Html, text, ul, li, a)
import Html.Attributes exposing (href)
import Html.Events exposing (onClick)
import Browser
import Components.Navigation exposing (links)
import Browser.Navigation exposing (pushUrl)


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
    { title = "Posts"
    , body =
        [ Html.div [] links
        , text "Posts"
        , viewPosts model
        ]
    }


viewPosts : Model -> Html Msg
viewPosts model =
    ul []
        [ li [] [ a [ href "/post/post-1" ] [ text "Post 1" ] ]
        , li [] [ a [ href "/post/post-2" ] [ text "Post 2" ] ]
        , li [] [ a [ href "/post/post-3" ] [ text "Post 3" ] ]
        ]
