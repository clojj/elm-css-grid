module CssGrid exposing (GridArea, GridElement, GridTemplate, MediaQueryWithGridTemplate, gridArea, gridContainer, gridElement, gridTemplate)

import Css exposing (Style, property)
import Css.Media exposing (MediaQuery, withMedia)
import Html.Styled exposing (Attribute, Html, div)
import Html.Styled.Attributes exposing (css)


{-| Represents an CSS Grid area, identified by a name of type `String`
-}
type GridArea
    = GridArea String


{-| Constructs a `GridArea` from a name of type `String`.
The name must be unique for the entire view.

    gridArea "header" == GridArea "header"
-}
gridArea : String -> GridArea
gridArea name =
    GridArea name


type alias RowSize =
    String


type alias ColSize =
    String


type alias Areas =
    List (List GridArea)


type GridTemplate
    = GridTemplate Areas (List RowSize) (List ColSize)


gridTemplate : Areas -> List RowSize -> List ColSize -> GridTemplate
gridTemplate areas rowSizes colSizes =
    GridTemplate areas rowSizes colSizes


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


toMediaStyle : List MediaQuery -> Style -> Style
toMediaStyle mediaQuery style =
    withMedia mediaQuery [ style ]


gridContainer : List MediaQueryWithGridTemplate -> List (Attribute msg) -> List (GridElement msg) -> Html msg
gridContainer mappings attributes children =
    let
        styles =
            List.map (\( mediaQuery, gridTemlate ) -> toMediaStyle mediaQuery (gridTemplateToStyle gridTemlate)) mappings
    in
    div ([ css styles ] ++ attributes)
        (List.map renderGridElement children)


gridTemplateToStyle : GridTemplate -> Style
gridTemplateToStyle (GridTemplate areas rows cols) =
    let
        areaRows =
            List.map (\gridAreas -> String.join " " (List.map getGridAreaName gridAreas)) areas

        rowSizes =
            String.join " " rows

        colSizes =
            String.join " " cols
    in
    Css.batch
        [ property "display" "grid"
        , property "width" "100%"
        , property "grid-template-areas" <| String.join " " (List.map (\s -> "'" ++ s ++ "'") areaRows)
        , property "grid-template-rows" rowSizes
        , property "grid-row-gap" "10px"
        , property "grid-template-columns" colSizes
        , property "grid-column-gap" "10px"
        ]
