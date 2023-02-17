module Daisy.Actions exposing
    ( btn
    , swap, swapActive, swapFlip, swapRotate
    , modal, openModal, closeModal
    , alignTo, dropdown, dropdownButton, dropdownCard, dropdownData, dropdownMenu
    , Dropdown(..)
    )

{-| Components in the DaisyUI Actions section


## Button

See also: <https://daisyui.com/components/button/>

@docs btn


## Swap

See also: <https://daisyui.com/components/swap/>

@docs swap, swapActive, swapFlip, swapRotate


## Modal

See also: <https://daisyui.com/components/modal/#>

@docs modal, openModal, closeModal


## Dropdown

See also: <https://daisyui.com/components/dropdown/#>

@docs Dropdown, alignTo, dropdown, dropdownButton, dropdownCard, dropdownData, dropdownMenu

-}

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Types exposing (Element)


{-| Enumerate the drowpdown aligments
-}
type Dropdown
    = End
    | Top
    | Bottom
    | Left
    | Right
    | Hover
    | Open


{-| A simple button
-}
btn : List (Attribute msg) -> List (Html msg) -> Html msg
btn attrs body =
    button (class "btn" :: attrs) body


{-| Swap allows you to toggle the visibility of two elements.
-}
swap : (Bool -> msg) -> List (Attribute msg) -> Html msg -> Html msg -> Html msg
swap msg attrs on off =
    label (class "swap" :: attrs)
        [ input [ type_ "checkbox", onCheck msg ] []
        , div [ class "swap-on" ] [ on ]
        , div [ class "swap-off" ] [ off ]
        ]


{-| Attribute to turn the swap on by default
-}
swapActive : Attribute msg
swapActive =
    class "swap-active"


{-| Adds rotate effect to swap
-}
swapRotate : Attribute msg
swapRotate =
    class "swap-rotate"


{-| Adds flip effect to swap
-}
swapFlip : Attribute msg
swapFlip =
    class "swap-flip"


{-| Content of your modal dialog. It should be placed at the end of the HTML document
-}
modal : String -> List (Attribute msg) -> List (Html msg) -> Html msg
modal id attrs body =
    div []
        [ input [ type_ "checkbox", Html.Attributes.id id, class "modal-toggle" ] []
        , div [ class "modal" ] [ div (class "modal-box" :: attrs) body ]
        ]


{-| A button that lives in your main document used to open the modal
-}
openModal : String -> List (Attribute msg) -> List (Html msg) -> Html msg
openModal id attrs body =
    label (attribute "for" id :: attrs) body


{-| A button that lives in the modal used to close it.
-}
closeModal : String -> List (Attribute msg) -> List (Html msg) -> Html msg
closeModal id attrs body =
    div [ class "modal-action" ]
        [ label (attribute "for" id :: attrs) body
        ]


{-| The outer layer of a dropdown. It defines the label used to toggle it.

Content can be created by the auxiliary functions dropdownMenu, dropdownCard, dropdownData

    dropdown [ alignTo End ]
        [ dropdownButton [ color primary ] [ text "open" ]
        , dropdownMenu [] [ text "Item 1", text "Item 2" ]
        ]

-}
dropdown : List (Attribute msg) -> List (Html msg) -> Html msg
dropdown attrs body =
    div (class "dropdown" :: attrs) body


{-| Button that triggers the dropdown
-}
dropdownButton : List (Attribute msg) -> List (Html msg) -> Html msg
dropdownButton attrs body =
    label (tabindex 0 :: attrs) body


{-| Contents for a dropdown menu
-}
dropdownMenu : List (Attribute msg) -> List (Html msg) -> Html msg
dropdownMenu attrs body =
    dropdownData ul (class "menu" :: attrs) (List.map (li [] << List.singleton) body)


{-| Contents for a dropdown card
-}
dropdownCard : List (Attribute msg) -> List (Html msg) -> Html msg
dropdownCard attrs body =
    dropdownData div (class "card" :: attrs) body


{-| Contents for arbitrary dropdown content
-}
dropdownData : Element msg -> List (Attribute msg) -> List (Html msg) -> Html msg
dropdownData tag attrs body =
    tag (tabindex 0 :: class "dropdown-content" :: attrs) body


{-| Attribute that defines the aligment of dropdown
-}
alignTo : Dropdown -> Attribute msg
alignTo a =
    case a of
        End ->
            class "dropdown-end"

        Top ->
            class "dropdown-top"

        Bottom ->
            class "dropdown-bottom"

        Left ->
            class "dropdown-left"

        Right ->
            class "dropdown-right"

        Hover ->
            class "dropdown-hover"

        Open ->
            class "dropdown-open"
