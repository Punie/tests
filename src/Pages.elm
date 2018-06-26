module Pages exposing (..)

import Html exposing (Html)
import Browser
import Pages.Index
import Pages.About
import Pages.Post
import Pages.Posts
import Pages.NotFound
import Url
import Util exposing (mapDocument, wrap)


type Route
    = NotFound
    | Index
    | About
    | Posts
    | Post String


type Model
    = IndexModel Pages.Index.Model
    | AboutModel Pages.About.Model
    | PostModel Pages.Post.Model
    | PostsModel Pages.Posts.Model
    | NotFoundModel Pages.NotFound.Model


type Msg
    = IndexMessage Pages.Index.Msg
    | AboutMessage Pages.About.Msg
    | PostMessage Pages.Post.Msg
    | PostsMessage Pages.Posts.Msg
    | NotFoundMessage Pages.NotFound.Msg


init : Route -> ( Model, Cmd Msg )
init r =
    case r of
        Index ->
            Pages.Index.init {}
                |> wrap IndexModel IndexMessage

        About ->
            Pages.About.init {}
                |> wrap AboutModel AboutMessage

        NotFound ->
            Pages.NotFound.init {}
                |> wrap NotFoundModel NotFoundMessage

        Post id ->
            Pages.Post.init { id = id }
                |> wrap PostModel PostMessage

        Posts ->
            Pages.Posts.init {}
                |> wrap PostsModel PostsMessage


update : Msg -> Model -> ( Model, Cmd Msg )
update pageMessage pageModel =
    case ( pageMessage, pageModel ) of
        ( IndexMessage message, IndexModel model ) ->
            Pages.Index.update message model
                |> wrap IndexModel IndexMessage

        ( AboutMessage message, AboutModel model ) ->
            Pages.About.update message model
                |> wrap AboutModel AboutMessage

        ( PostMessage message, PostModel model ) ->
            Pages.Post.update message model
                |> wrap PostModel PostMessage

        ( PostsMessage message, PostsModel model ) ->
            Pages.Posts.update message model
                |> wrap PostsModel PostsMessage

        ( NotFoundMessage message, NotFoundModel model ) ->
            Pages.NotFound.update message model
                |> wrap NotFoundModel NotFoundMessage

        _ ->
            ( pageModel, Cmd.none )


subscriptions : Model -> Sub Msg
subscriptions model =
    case model of
        IndexModel pageModel ->
            Pages.Index.subscriptions pageModel
                |> Sub.map IndexMessage

        _ ->
            Sub.none


view : Model -> Browser.Document Msg
view model =
    case model of
        IndexModel pageModel ->
            pageModel
                |> Pages.Index.view
                |> mapDocument IndexMessage

        AboutModel pageModel ->
            pageModel
                |> Pages.About.view
                |> mapDocument AboutMessage

        PostModel pageModel ->
            pageModel
                |> Pages.Post.view
                |> mapDocument PostMessage

        NotFoundModel pageModel ->
            pageModel
                |> Pages.NotFound.view
                |> mapDocument NotFoundMessage

        PostsModel pageModel ->
            pageModel
                |> Pages.Posts.view
                |> mapDocument PostsMessage
