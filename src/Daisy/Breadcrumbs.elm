module Daisy.Breadcrumbs exposing
    ( view, unlinkLast
    , Config, config, configCustom, empty, home, icon, link, noHome
    )

{-| Navegation elements


## Breadcrumbs

@docs view, unlinkLast


## Config

@docs Config, config, configCustom, empty, home, icon, link, noHome

-}

import Daisy.Elements as Ui
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Material.Icons as I
import Material.Icons.Round as IR
import Material.Icons.Types as I
import Svg exposing (Svg)
import Types exposing (..)
import Util exposing (runConfig)


{-| Store information on how to render a breadcrumb
-}
type alias Config url msg =
    { home : Maybe url
    , icon : Svg msg
    , element : Element msg
    , link : url -> List (Attribute msg)
    , empty : url -> Bool
    }


{-| Configuration options
-}
type alias ConfigOption url msg =
    Config url msg -> Config url msg


{-| Render breadcrubms
-}
view : Config url msg -> List (Attribute msg) -> List ( url, Name ) -> Html msg
view cfg attrs links =
    let
        item url data =
            if cfg.empty url then
                li [] [ data ]

            else
                li [] [ cfg.element (cfg.link url) [ data ] ]

        elements =
            List.map (\( url, name ) -> item url (text name)) links
    in
    div (class "breadcrumbs" :: attrs)
        [ ul [] <|
            case cfg.home of
                Just url ->
                    item url cfg.icon :: elements

                _ ->
                    elements
        ]


{-| Transform the last pair (url, name) to ("", name), disabling its
hyperlink.
-}
unlinkLast : List ( Url, Name ) -> List ( Url, Name )
unlinkLast lst =
    case lst of
        [] ->
            []

        [ ( _, name ) ] ->
            [ ( "", name ) ]

        p :: ps ->
            p :: unlinkLast ps


{-| Custom config for breadcrumbs view
-}
configCustom : List (Config url msg -> Config url msg) -> Config url msg
configCustom =
    runConfig
        { home = Nothing
        , icon = IR.home 16 I.Inherit
        , element = a
        , link = \_ -> [ class "text-primary font-bold" ]
        , empty = \_ -> False
        }


{-| Simple config for breadcrumb view

    config [ home "/home/", icon I.folder ]

-}
config : List (Config Url msg -> Config Url msg) -> Config Url msg
config =
    runConfig
        { home = Just "/"
        , icon = IR.home 16 I.Inherit
        , element = a
        , link = \url -> class "text-primary font-bold" :: Ui.link url
        , empty = \url -> url == ""
        }


{-| Define the home URL
-}
home : url -> ConfigOption url msg
home new cfg =
    { cfg | home = Just new }


{-| Disable the home url
-}
noHome : ConfigOption url msg
noHome cfg =
    { cfg | home = Nothing }


{-| Control which attributes are added to valid links
-}
link : (url -> List (Attribute msg)) -> ConfigOption url msg
link func cfg =
    { cfg | link = func }


{-| Function that determines if links are valid or not
-}
empty : (url -> Bool) -> ConfigOption url msg
empty func cfg =
    { cfg | empty = func }


{-| Set the home icon
-}
icon : (Int -> I.Coloring -> Svg msg) -> ConfigOption url msg
icon i cfg =
    { cfg | icon = i 16 I.Inherit }
