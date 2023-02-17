module Daisy.Role exposing
    ( Role(..)
    , class, name, withRole
    )

{-| Type safe semantic roles

Some Daisy elements accept those roles to change appearance.

@docs Role


## Utilities

@docs class, name, withRole

-}

import Html
import Html.Attributes


{-| Represent a presentation style based on intent
-}
type Role
    = Primary
    | Secondary
    | Accent
    | Neutral
    | Info
    | Success
    | Warning
    | Error


{-| Convert role to string
-}
name : Role -> String
name role =
    case role of
        Primary ->
            "primary"

        Secondary ->
            "secondary"

        Accent ->
            "accent"

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


{-| Create a role class from prefix
-}
class : String -> Role -> Html.Attribute msg
class prefix role =
    Html.Attributes.class (prefix ++ "-" ++ name role)


{-| Create a role class from prefix
-}
withRole : String -> Role -> Html.Attribute msg
withRole prefix role =
    case role of
        Neutral ->
            Html.Attributes.class prefix

        _ ->
            Html.Attributes.class (prefix ++ " " ++ prefix ++ "-" ++ name role)
