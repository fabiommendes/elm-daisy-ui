module Daisy.Tab exposing
    ( Model, Msg
    , init, view, update
    , index, setIndex, title
    , Config, config
    )

{-|

@docs Model, Msg


## Elm archtechture

@docs init, view, update


## Changing and inspecting state

@docs index, setIndex, title


## Config

@docs Config, config

-}

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events as Ev
import List.Extra


{-| Declare how tabs are rendered and integrated to the rest of the application
-}
type alias Config a msg =
    { msg : Msg -> msg
    , tabs : List ( String, a -> Html msg )
    }


{-| The tab state
-}
type alias Model =
    { index : Int, size : Int }


{-| Opaque messages
-}
type Msg
    = OnSelect Int
    | OnLeft
    | OnRight


{-| Update function
-}
update : Msg -> Model -> Model
update msg m =
    case msg of
        OnSelect i ->
            setIndex i m

        OnLeft ->
            { m | index = modBy m.size (m.index - 1) }

        OnRight ->
            { m | index = modBy m.size (m.index + 1) }


{-| Initial tab state.

Store this in your model.

-}
init : Config a msg -> Model
init cfg =
    { index = 0, size = List.length cfg.tabs }


{-| Render tabs from config and tab state
-}
view : Config a msg -> Model -> a -> Html msg
view cfg tab m =
    let
        ( tabNames, tabViews ) =
            List.unzip cfg.tabs

        viewFunction =
            List.drop tab.index tabViews
                |> List.head
                |> Maybe.withDefault (\_ -> div [] [])
    in
    div []
        [ div [ class "tabs my-4 w-full text-lg font-bold w-100 flex justify-center space-x-2" ] (List.indexedMap (viewTab cfg tab.index) tabNames)
        , viewFunction m
        ]


viewTab : Config a msg -> Int -> Int -> String -> Html msg
viewTab cfg select idx name =
    let
        tabClass =
            if select == idx then
                " tab flex-1 tab-bordered tab-active"

            else
                "tab flex-1 tab-bordered"
    in
    Html.map cfg.msg <|
        button
            [ class tabClass, Ev.onClick (OnSelect idx) ]
            [ text name ]


{-| Create a config object.

It is necessary to pass the message wrapper in your module and a list
of pairs with (title, render) with the name of the tab and the render
function for the corresponding tab.

-}
config : (Msg -> msg) -> List ( String, a -> Html msg ) -> Config a msg
config msg tabs =
    Config msg tabs


{-| Force selected tab to the given index
-}
setIndex : Int -> Model -> Model
setIndex i m =
    { m | index = Basics.max 0 (Basics.min (m.size - 1) i) }


{-| Return the index of the currently selected tab.
-}
index : Model -> Int
index m =
    m.index


{-| Return the tab title from the currently selected tab.
-}
title : Config a msg -> Model -> String
title cfg m =
    List.Extra.getAt m.index cfg.tabs
        |> Maybe.map Tuple.first
        |> Maybe.withDefault ""
