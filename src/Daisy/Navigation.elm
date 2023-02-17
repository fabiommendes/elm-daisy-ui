module Daisy.Navigation exposing
    ( link, linkHover
    , steps
    , pagination
    )

{-| Simple navegational elements.

`Tab` and `Breadcrumb` live on their separated modules.


## Styling links

See also: <https://daisyui.com/components/link/>

@docs link, linkHover


## Steps

See also: <https://daisyui.com/components/steps/>

@docs steps


## Pagination

See also: <https://daisyui.com/components/pagination/>

@docs pagination


## To-do

Button navigation: <https://daisyui.com/components/bottom-navigation/>
Menu: <https://daisyui.com/components/menu/>
Navbar: <https://daisyui.com/components/navbar/>

-}

import Daisy.Role as Role exposing (Role)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Util exposing (iff)


{-| Style an element as a link

    a [ href "/", link Primary ] [ text "Home" ]

-}
link : Role -> Attribute msg
link =
    Role.name >> (++) "link link-" >> class


{-| Show link style only on hover

    a [ href "/", linkHover ] [ text "Home" ]

-}
linkHover : Attribute msg
linkHover =
    class "link link-hover"


{-| Show an horizontal list of steps

    -- a step function specialized in rendering strings
    stepTexts = steps text Primary

    stepTexts []
        [ "completed 1", "completed  2" ]
        [ "missing 1", "missing 2" ]

-}
steps : (a -> Html msg) -> Role -> List (Attribute msg) -> List a -> List a -> Html msg
steps render role attrs completed missing =
    ul (class "steps" :: attrs) <|
        List.concat
            [ List.map (render >> List.singleton >> li [ class "step", Role.class "step" role ]) completed
            , List.map (render >> List.singleton >> li [ class "step" ]) missing
            ]


{-| A simple numeric pagination from a triplet with of (min, selected, maximum) integers
and a function that computes an action from the numeric value associated with the button.

    pagination ( 1, 3, 5 ) action

will display the list of numbers `[1, 2, *3*, 4, 5]`

Action is a function that takes the display number and computes an attribute, usually it
will be something like

    action i =
        onClick (OnPaginateTo (i - 1))

-}
pagination : ( Int, Int, Int ) -> (Int -> Attribute msg) -> Html msg
pagination ( a, selected, b ) action =
    let
        do acc i =
            if i < a then
                acc

            else
                do (button [ class (iff (i == selected) "btn btn-active" "btn"), action i ] [ text (String.fromInt (i + 1)) ] :: acc) (i - 1)
    in
    div [ class "pagination btn-group" ] (do [] b |> List.reverse)
