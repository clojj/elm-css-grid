module CssGrid exposing (GridArea, GridAreaElement, GridAreasTemplate, MediaQueryWithGridAreasTemplate, gridArea, gridAreasContainer, gridAreaElement, gridAreasTemplate, fr, Fractions)

import Css exposing (Style, property)
import Css.Media exposing (MediaQuery, withMedia)
import Html.Styled exposing (Attribute, Html, div)
import Html.Styled.Attributes exposing (css)


{-| Represents a [grid-area](https://developer.mozilla.org/en-US/docs/Web/CSS/grid-area), uniquely identified by a name.
-}
type GridArea
    = GridArea String


{-| Constructs a `GridArea` which is uniquely identified by name.
The name of the grid-area must be unique for the entire view.

    gridArea "header"

The resulting GridArea will be appear in the resulting CSS in two places:
1. As a substring in the list-of-strings-value of the `grid-template-areas` property (aka CSS Grid container definition)
2. As the value of a `grid-area` property
-}
gridArea : String -> GridArea
gridArea name =
    GridArea name

fr : Int -> Fractions
fr value =
    Fractions <| (String.fromInt value) ++ "fr"


-- TODO types: "42px" "8ch" "auto", etc.
-- see https://developer.mozilla.org/en-US/docs/Web/CSS/grid-template-rows
-- see https://developer.mozilla.org/en-US/docs/Web/CSS/grid-template-columns
type Fractions = Fractions String


type alias Areas =
    List (List GridArea)

-- TODO alternate definition with typed row-/column-sizes
{-| Represents the [grid-template-areas](https://developer.mozilla.org/en-US/docs/Web/CSS/grid-template-areas) definition, including the [grid-template-rows](https://developer.mozilla.org/en-US/docs/Web/CSS/grid-template-rows) and [grid-template-columns](https://developer.mozilla.org/en-US/docs/Web/CSS/grid-template-columns) definitions.
-}
type GridAreasTemplate
    = GridTemplate Areas (List Fractions) (List Fractions)


gridAreasTemplate : Areas -> List Fractions -> List Fractions -> GridAreasTemplate
gridAreasTemplate areas rowSizes colSizes =
    GridTemplate areas rowSizes colSizes


type alias MediaQueryWithGridAreasTemplate =
    ( List MediaQuery, GridAreasTemplate )


{-| Opaque type representing a grid-area element
-}
type GridAreaElement msg
    = GridElement
        { area : GridArea
        , children : List (Html msg)
        }


renderGridAreaElement : GridAreaElement msg -> Html msg
renderGridAreaElement gridElem =
    case gridElem of
        GridElement { area, children } ->
            let
                (GridArea name) = area
            in
            div
                [ css [ property "grid-area" name ] ]
                children


{-| Creates a grid-area element that gets its grid-position by the area's name
-}
gridAreaElement : GridArea -> List (Html msg) -> GridAreaElement msg
gridAreaElement area children =
    GridElement
        { area = area
        , children = children
        }


toMediaStyle : List MediaQuery -> Style -> Style
toMediaStyle mediaQuery style =
    withMedia mediaQuery [ style ]


gridAreasContainer : List MediaQueryWithGridAreasTemplate -> List (Attribute msg) -> List (GridAreaElement msg) -> Html msg
gridAreasContainer mappings attributes children =
    let
        styles =
            List.map (\( mediaQuery, gridTemlate ) -> toMediaStyle mediaQuery (gridAreasTemplateToStyle gridTemlate)) mappings
    in
    div ([ css styles ] ++ attributes)
        (List.map renderGridAreaElement children)


gridAreasTemplateToStyle : GridAreasTemplate -> Style
gridAreasTemplateToStyle (GridTemplate areas rows cols) =
    let
        areaRows =
            List.map (\gridAreas -> String.join " " (List.map (\(GridArea n) -> n) gridAreas)) areas

        rowSizes =
            String.join " " (List.map (\(Fractions s) -> s) rows)

        colSizes =
            String.join " " (List.map (\(Fractions s) -> s) cols)
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
