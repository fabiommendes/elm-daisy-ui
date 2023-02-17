module Daisy.Color exposing
    ( Color(..), name
    , bg, color, inverted, text
    , focused
    )

{-| A type-safe interpetation of DaisyUI colors (<https://daisyui.com/docs/colors/>)

@docs Color, name


## Classes

@docs bg, color, inverted, text


## Transforming colors

@docs focused

-}

import Daisy.Role as Role exposing (Role)
import Html exposing (Attribute)
import Html.Attributes exposing (class)


{-| Represent colors in the DaisyUI color theme
-}
type Color
    = Role Role
    | Base
    | Base200
    | Base300
    | Focus Color
    | Content Color


{-| Set background color
-}
bg : Color -> Attribute msg
bg =
    name >> (++) "bg-" >> class


{-| Set text color
-}
text : Color -> Attribute msg
text =
    name >> (++) "text-" >> class


{-| Set text and background color
-}
color : Color -> Attribute msg
color c =
    class <|
        case c of
            Base ->
                "bg-base-100 text-base-content"

            _ ->
                let
                    colorString =
                        name c
                in
                "bg-" ++ colorString ++ " text-" ++ colorString ++ "-content"


{-| Set text and background, inverting roles
-}
inverted : Color -> Attribute msg
inverted c =
    class <|
        case c of
            Base ->
                "bg-base-content text-base-100"

            _ ->
                let
                    colorString =
                        name c
                in
                "bg-" ++ colorString ++ "-content text-" ++ colorString


{-| Convert color to string
-}
name : Color -> String
name c =
    case c of
        Role role ->
            Role.name role

        Base ->
            "base-100"

        Base200 ->
            "base-200"

        Base300 ->
            "base-300"

        Focus cc ->
            case focused (leaf cc) of
                Focus ccc ->
                    name ccc ++ "-focus"

                ccc ->
                    name ccc

        Content cc ->
            name (leaf cc) ++ "-content"


leaf : Color -> Color
leaf c =
    case c of
        Focus cc ->
            leaf cc

        Content cc ->
            leaf cc

        _ ->
            c


{-| Make a focused color from primary, secondary, Accent or Neutral roles
-}
focused : Color -> Color
focused c =
    case c of
        Role Role.Primary ->
            Focus c

        Role Role.Secondary ->
            Focus c

        Role Role.Accent ->
            Focus c

        Role Role.Neutral ->
            Focus c

        _ ->
            c
