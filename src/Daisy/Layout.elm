module Daisy.Layout exposing (divider, dividerVertical)

{-| Simple layout components


## Divider

See also: <https://daisyui.com/components/divider/>

@docs divider, dividerVertical


## To-do

Artboard
Button group
Drawer
Footer
Hero
Indicator
Input group
Mask
Stack
Toast

-}

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)


{-| Simple horizontal divider

    divider [] [ text "or " ]

-}
divider : List (Attribute msg) -> List (Html msg) -> Html msg
divider attrs body =
    div (class "divider" :: attrs) body


{-| Simple vertical divider

    divider [] [ text "or " ]

-}
dividerVertical : List (Attribute msg) -> List (Html msg) -> Html msg
dividerVertical attrs body =
    div (class "divider divider-vertical" :: attrs) body
