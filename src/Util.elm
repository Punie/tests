module Util exposing (mapDocument, wrap)

import Html
import Browser


mapDocument : (a -> b) -> Browser.Document a -> Browser.Document b
mapDocument mapMessage page =
    { body =
        page.body
            |> List.map (Html.map mapMessage)
    , title = page.title
    }


wrap : (a -> b) -> (c -> d) -> ( a, Cmd c ) -> ( b, Cmd d )
wrap model message ( pageModel, pageMessage ) =
    ( model pageModel, Cmd.map message pageMessage )
