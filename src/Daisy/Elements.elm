module Daisy.Elements exposing
    ( counter, link, tags, title
    , container, list, urlList, sections
    , longPlaceholderText, shortPlaceholderText, loremText
    )

{-| Generic Elements


## Basic elements

@docs counter, link, tags, title


## Layout

@docs container, list, urlList, sections


## Missing content

@docs longPlaceholderText, shortPlaceholderText, loremText

-}

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Types exposing (..)


{-| Render a list of a's as an <ul> element.

It uses the first argument to convert a's to Html's.

    list text [] [ "foo", "bar", "baz" ]

-}
list : (a -> Html msg) -> List (Attribute msg) -> List a -> Html msg
list render attrs items =
    ul (class "list-disc pl-4" :: attrs)
        (List.map
            (render >> List.singleton >> li [])
            items
        )


{-| A simple rounded counter

    counter [ class "foo" ] 10

It displays the number n within a circle

-}
counter : List (Attribute msg) -> Int -> Html msg
counter attrs n =
    span
        (class "h-5 w-5 font-bold text-sm text-center rounded-full shadow-sm " :: attrs)
        [ text (String.fromInt n) ]


{-| Renders a list of strings as tags
-}
tags : List String -> Html msg
tags xs =
    div [ class "space-x-1" ] (List.map tag xs)


tag : String -> Html msg
tag txt =
    span [ class "badge badge-outline badge-primary" ] [ text txt ]


{-| Main container element for page content.
-}
container : List (Html msg) -> Html msg
container content =
    div [ class "mx-auto px-4 my-2 max-w-lg" ] content


{-| Main title of page
-}
title : String -> Html msg
title txt =
    h1 [ class "font-bold text-xl mb-2" ] [ text txt ]


{-| Safely creates a link

External urls append a `target:blank_` that forces the navigator to open then
in a different tab.

-}
link : Url -> List (Attribute msg)
link url =
    if String.startsWith "/" url then
        [ class "link", href url ]

    else
        [ class "link", href url, target "blank_" ]


{-| Create a description list from a list of titles and their corresponding Html content.
-}
sections : List (Attribute msg) -> List ( String, List (Html msg) ) -> Html msg
sections attrs data =
    let
        item ( st, children ) =
            [ dt [ class "text-lg font-bold my-2" ] [ text st ]
            , dd [ class "mb-4" ] children
            ]
    in
    dl (class "sections" :: attrs)
        (data
            |> List.filter (\( s, h ) -> s /= "" && h /= [])
            |> List.concatMap item
        )


{-| Render a list of (url, name) pairs as an <ul> element.

If the list is empty, it produces a `div [] [ text fallback ]`

-}
urlList : List (Attribute msg) -> ( String, List ( Url, String ) ) -> Html msg
urlList attrs ( fallback, items ) =
    case items of
        [] ->
            div [ class "url-list empty" ] [ text fallback ]

        _ ->
            ul (class "url-list" :: attrs) (List.map (\( url, txt ) -> li [] [ a (link url) [ text txt ] ]) items)


{-| A string that can be used as a placeholder for unloaded data
-}
shortPlaceholderText : String
shortPlaceholderText =
    "░░░░░ ░ ░░░░"


{-| A string that can be used as a placeholder for unloaded data
-}
longPlaceholderText : String
longPlaceholderText =
    "░░░░░ ░ ░░░░ ░░░░ ░░░ ░░ ░░░░░ ░ ░░░░ ░ ░░░░ ░░░ ░░░ ░░░░ ░░░ ░░ ░░░░░ ░ ░░░░ ░ ░░░░"


{-| A string that can be used as a placeholder for unloaded data
-}
loremText : String
loremText =
    "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat."
