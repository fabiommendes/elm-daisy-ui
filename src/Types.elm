module Types exposing (..)

import Html
import Material.Icons.Types as MT
import Svg exposing (Svg)


type alias Name =
    String


type alias Url =
    String


type alias Element msg =
    List (Html.Attribute msg) -> List (Html.Html msg) -> Html.Html msg


type alias Tag msg =
    List (Html.Html msg) -> Html.Html msg


type alias Icon msg =
    Int -> MT.Coloring -> Svg msg


type alias SizedIcon msg =
    Svg msg
