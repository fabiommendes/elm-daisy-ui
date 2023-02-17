module Daisy.Warn exposing
    ( Warn(..)
    , class, name, icon
    )

{-| Type safe semantic warnings

Some Daisy elements accept those warnings to change appearance.

@docs Warn


## Utilities

@docs class, name, icon

-}

import Html
import Html.Attributes
import Material.Icons as I
import Material.Icons.Types exposing (Coloring)
import Svg exposing (Svg)


{-| Represent a kind of warning intent.

Usually it is used for presentation purposes.

-}
type Warn
    = Neutral
    | Info
    | Success
    | Warning
    | Error


{-| Convert warning to string
-}
name : Warn -> String
name warn =
    case warn of
        Neutral ->
            "neutral"

        Info ->
            "info"

        Success ->
            "success"

        Warning ->
            "warning"

        Error ->
            "error"


{-| Create a warn class from prefix
-}
class : String -> Warn -> Html.Attribute msg
class prefix warn =
    Html.Attributes.class (prefix ++ "-" ++ name warn)


{-| Create a warn icon
-}
icon : Warn -> Int -> Coloring -> Svg msg
icon warn =
    case warn of
        Neutral ->
            I.report

        Info ->
            I.info

        Success ->
            I.check_circle

        Warning ->
            I.warning

        Error ->
            I.error
