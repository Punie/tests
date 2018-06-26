module Main exposing (main)

import Browser
import Browser.Navigation exposing (pushUrl)
import Html exposing (Html, text)
import Html.Events exposing (onClick)
import Url
import Routes
import Util exposing (mapDocument)
import Pages


type alias Flags =
    {}


type alias Model =
    { page : Pages.Model
    , url : Url.Url
    , key : Browser.Navigation.Key
    }


type Msg
    = NoOp
    | SetUrl Url.Url
    | LoadPage Url.Url
    | PageMsg Pages.Msg
    | Do (Cmd Msg)


main =
    { init = init
    , view = view
    , update = update
    , onUrlRequest = onUrlRequest
    , onUrlChange = onUrlChange
    , subscriptions = subscriptions
    }
        |> Browser.application


init : Flags -> Url.Url -> Browser.Navigation.Key -> ( Model, Cmd Msg )
init flags url key =
    let
        route =
            Routes.fromUrl url

        ( startModel, startMessage ) =
            Pages.init route

        model =
            { page = startModel
            , url = url
            , key = key
            }
    in
        ( model, Cmd.map PageMsg startMessage )


onUrlRequest : Browser.UrlRequest -> Msg
onUrlRequest urlRequest =
    case urlRequest of
        Browser.Internal url ->
            SetUrl url

        Browser.External urlString ->
            Do <| Browser.Navigation.load urlString


onUrlChange : Url.Url -> Msg
onUrlChange =
    LoadPage


update : Msg -> Model -> ( Model, Cmd Msg )
update message model =
    case message of
        NoOp ->
            ( model, Cmd.none )

        LoadPage url ->
            let
                ( page, pageCmd ) =
                    Pages.init <| Routes.fromUrl url
            in
                ( { model | url = url, page = page }
                , Cmd.map PageMsg pageCmd
                )

        Do cmd ->
            ( model, cmd )

        SetUrl url ->
            ( { model | url = url }
            , Url.toString url
                |> Browser.Navigation.pushUrl model.key
            )

        PageMsg pageMessage ->
            updatePage pageMessage model


updatePage : Pages.Msg -> Model -> ( Model, Cmd Msg )
updatePage pageMessage model =
    let
        ( page, cmd ) =
            Pages.update pageMessage model.page
    in
        ( { model | page = page }
        , Cmd.map PageMsg cmd
        )


subscriptions : Model -> Sub Msg
subscriptions model =
    Pages.subscriptions model.page
        |> Sub.map PageMsg


view : Model -> Browser.Document Msg
view model =
    Pages.view model.page
        |> mapDocument PageMsg
