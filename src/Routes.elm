module Routes exposing (..)

import Url
import Url.Parser exposing (Parser, parse, string, map, oneOf, s, top, (</>))
import Pages exposing (Route(..))


fromUrl : Url.Url -> Route
fromUrl url =
    parse routes url
        |> Maybe.withDefault NotFound


routes : Parser (Route -> a) a
routes =
    [ map Index top
    , posts
    , post
    , about
    ]
        |> oneOf


about =
    s "about" </> (map About top)


posts =
    s "posts" </> map Posts top


post =
    map Post (s "post" </> string)
