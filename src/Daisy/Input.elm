module Daisy.Input exposing (checkbox)

{-| Input elements


## Checkbox

See also: <https://daisyui.com/components/checkbox/>

@docs checkbox


## To-do

File input
Radio
Range
Rating
Select
Text input
TextArea
Toggle

-}

import Daisy.Role exposing (Role, withRole)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)


{-| A daisy-ui styled checkbox
-}
checkbox : Role -> List (Attribute msg) -> Html msg
checkbox role attrs =
    input (withRole "checkbox" role :: attrs) []
