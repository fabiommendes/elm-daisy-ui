module Daisy.Accordion exposing
    ( State, Config
    , view, init, config
    )

{-| A simple accordion element


## Example

    -- TODO: example




## Types

@docs State, Config


## Functions

@docs view, init, config

-}

import Daisy.Elements as Ui
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Util exposing (iff)


{-| The accordion state
-}
type alias State =
    { selected : Int }


{-| Configure how the accordion should be rendered
-}
type alias Config data msg =
    { msg : State -> msg
    , title : data -> String
    , render : data -> Html msg
    , selectedClass : String
    , notSelectedClass : String
    }


{-| Renders accordion
-}
view : Config data msg -> State -> List data -> Html msg
view cfg m data =
    let
        item i elem =
            let
                viewHandle h =
                    span [ class "align-right font-bold text-2xl" ] [ text (" " ++ h) ]

                handle =
                    viewHandle <| iff (i == m.selected) "-" "+"

                title =
                    span [ class <| "px-3 flex-1 text-lg font-bold" ] [ text (cfg.title elem) ]

                expand =
                    if i == m.selected then
                        div [ class "transition duration-200 ml-8" ] [ cfg.render elem ]

                    else
                        div [ class "transition duration-200 opacity-0 scale-y-0 -translate-y-1/2 linear transform-gpu" ] [ text "" ]

                ( msg, cls ) =
                    if i == m.selected then
                        ( cfg.msg { selected = -1 }, cfg.selectedClass )

                    else
                        ( cfg.msg { selected = i }, cfg.notSelectedClass )
            in
            div
                [ class "px-4 py-2 border-t first:border-t-0"
                , class "text-left text-sm"
                , class "focus:bg-slate-100 hover:outline-none hover:ring hover:ring primary-focus"
                , onClick msg
                ]
                [ div [ class "block flex items-center h-14" ] [ Ui.counter [ class cls ] (i + 1), title, handle ]
                , expand
                ]
    in
    div [ class "accordion rounded-md shadow-xl" ] (List.indexedMap item data)


{-| Initial state
-}
init : State
init =
    { selected = -1 }


{-| Simple config from msg, title and rendering function
-}
config : (State -> msg) -> (data -> String) -> (data -> Html msg) -> Config data msg
config msg title render =
    { msg = msg
    , title = title
    , render = render
    , selectedClass = "accordion-item selected"
    , notSelectedClass = "accordion-item not-selected"
    }
