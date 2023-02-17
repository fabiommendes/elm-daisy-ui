module Daisy.Mockup exposing
    ( code, codeCustom
    , phone
    , window
    )

{-| Simple mockups


## Code

See also: <https://daisyui.com/components/mockup-code/>

@docs code, codeCustom


## Phone

See also: <https://daisyui.com/components/mockup-phone/>

@docs phone


## Window

See also: <https://daisyui.com/components/mockup-window/>

@docs window

-}

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)


{-| Create a simple code mockup from a string of text
-}
code : String -> Html msg
code =
    String.lines >> List.indexedMap (\i ln -> ( "", String.fromInt (i + 1), ln )) >> codeCustom


{-| Customize the code mockup display.

It receive a list of (line class, line number or prefix, line content) and render the code mockup.

-}
codeCustom : List ( String, String, String ) -> Html msg
codeCustom lines =
    div [ class "mockup-code" ] (List.map (\( x, y, z ) -> codeLine x y z) lines)


codeLine : String -> String -> String -> Html msg
codeLine cls prefix line =
    let
        attr fn st =
            if st == "" then
                []

            else
                [ fn st ]

        attrs =
            List.concat [ attr (attribute "data-prefix") prefix, attr class cls ]
    in
    pre [] [ Html.code attrs [ text line ] ]


{-| Render children contained inside a phone mockup
-}
phone : List (Attribute msg) -> List (Html msg) -> Html msg
phone attrs children =
    div (class "mockup-phone" :: attrs)
        [ div [ class "camera" ] []
        , div [ class "display" ] children
        ]


{-| Render children contained inside a window mockup
-}
window : List (Attribute msg) -> List (Html msg) -> Html msg
window attrs children =
    div (class "mockup-window" :: attrs) children
