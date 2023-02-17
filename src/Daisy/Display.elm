module Daisy.Display exposing
    ( alert
    , avatar
    )

{-| Data display elements. This module contains only the simple stateless elements.

Carosel is in its own module.


## Alert

See also: <https://daisyui.com/components/alert/>

@docs alert


## Avatar

See also: <https://daisyui.com/components/avatar/>

@docs avatar


## To-do

Badge
Card
Chat bubble
Collapse
Countdown
Kbd
Progress
Radial progress
Table
Tooltip

-}

import Daisy.Warn as Warn
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Material.Icons.Types as MI
import Types exposing (..)
import Util exposing (mcons)


{-| Warn the user with some alert message
-}
alert : Maybe Warn.Warn -> Element msg
alert warn attrs body =
    let
        icon =
            case warn of
                Just Warn.Neutral ->
                    Nothing

                Just warn_ ->
                    Just <| Warn.icon warn_ 25 MI.Inherit

                _ ->
                    Nothing

        cls =
            Maybe.map (Warn.class "alert") warn
    in
    div (class "alert" :: mcons cls attrs) (mcons icon body)


{-| Create an avatar from image or placeholder text, if image is absent.

The result data can be either `Ok url`, with the url pointing to the avatar image or
a `Err placeholder` with the placeholder text.

-}
avatar : List (Attribute msg) -> Result String String -> Html msg
avatar attrs data =
    case data of
        Ok url ->
            div [ class "avatar" ] [ div attrs [ img [ src url ] [] ] ]

        Err placeholder ->
            div [ class "avatar placeholder" ] [ div attrs [ span [] [ text placeholder ] ] ]
