module Grid exposing (GridArea, GridElement, GridTemplate, MediaQueryWithGridTemplate, container, gridArea, gridContainer, gridElement, template)

import Array exposing (Array)
import Array2D exposing (Array2D)
import Css exposing (Style, property, px)
import Css.Media as Media exposing (MediaQuery, only, screen, withMedia)
import Html.Styled exposing (Attribute, Html, div)
import Html.Styled.Attributes exposing (css)


type GridArea
    = GridArea String


gridArea : String -> GridArea
gridArea name =
    GridArea name



-- TODO


type alias RowSize =
    String



-- TODO


type alias ColSize =
    String


type GridTemplate
    = GridTemplate (Array2D GridArea) (List RowSize) (List ColSize)


template : Array2D GridArea -> List RowSize -> List ColSize -> GridTemplate
template areaLists rowSizes colSizes =
    GridTemplate areaLists rowSizes colSizes


type alias MediaQueryWithGridTemplate =
    ( List MediaQuery, GridTemplate )


{-| Opaque type representing a grid-area element
-}
type GridElement msg
    = GridElement
        { area : GridArea
        , children : List (Html msg)
        }


getGridAreaName : GridArea -> String
getGridAreaName (GridArea name) =
    name


renderGridElement : GridElement msg -> Html msg
renderGridElement gridElem =
    case gridElem of
        GridElement { area, children } ->
            let
                areaName =
                    getGridAreaName area
            in
            div
                [ css [ property "grid-area" areaName ] ]
                children


{-| Creates a grid-area element that gets its grid-position by the area's name
-}
gridElement : GridArea -> List (Html msg) -> GridElement msg
gridElement area children =
    GridElement
        { area = area
        , children = children
        }


container : List MediaQueryWithGridTemplate -> List (Attribute msg) -> List (GridElement msg) -> Html msg
container mappings attributes children =
    let
        styles =
            []
    in
    div ([ css styles ] ++ attributes)
        (List.map renderGridElement children)


getRow : Array2D.Array2D GridArea -> Int -> Array GridArea
getRow array2D row =
    let
        array =
            Array2D.getRow row array2D
    in
    case array of
        Just a ->
            a

        _ ->
            Array.empty


gridTemplateToStyle : GridTemplate -> Style
gridTemplateToStyle (GridTemplate areas rows cols) =
    let
        areaRows =
            List.map (getRow areas) (List.range 0 (Array2D.rows areas))
    in
    Css.batch
        [ property "display" "grid"
        , property "width" "100%"
        , property "grid-template-areas" <| String.join " " (List.map (\s -> "'" ++ s ++ "'") areaRows)
        , property "grid-template-rows" rows
        , property "grid-row-gap" "10px"
        , property "grid-template-columns" cols
        , property "grid-column-gap" "10px"
        ]



-- TODO remove / reuse names


{-| Creates a grid-container with grid-area-template(s)
-}
gridContainer : List (Attribute msg) -> List (GridElement msg) -> Html msg
gridContainer attributes children =
    div ([ css [ contentBig, contentSmall ] ] ++ attributes)
        (List.map renderGridElement children)


contentBig : Style
contentBig =
    withMedia [ only screen [ Media.minWidth (px 501) ] ]
        [ gridTemplate [ "button url url", "main main main" ] "1fr 5fr" "1fr 2fr 2fr" ]


contentSmall : Style
contentSmall =
    withMedia [ only screen [ Media.maxWidth (px 500) ] ]
        [ gridTemplate [ "button", "main", "url" ] "1fr 3fr 1fr" "1fr" ]


gridTemplate : List String -> String -> String -> Style
gridTemplate areas rows cols =
    Css.batch
        [ property "display" "grid"
        , property "width" "100%"
        , property "grid-template-areas" <| String.join " " (List.map (\s -> "'" ++ s ++ "'") areas)
        , property "grid-template-rows" rows
        , property "grid-row-gap" "10px"
        , property "grid-template-columns" cols
        , property "grid-column-gap" "10px"
        ]
