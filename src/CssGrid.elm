module CssGrid exposing (GridAreasTemplate, MediaQueryWithGridAreasTemplate, gridAreasContainer, gridAreasTemplate)

import Css exposing (Style, property)
import Css.Media exposing (MediaQuery, withMedia)
import CssGrid.Areas as Areas exposing (Areas, GridArea, GridAreaElement, gridAreaElementArea, gridAreaElementChildren)
import CssGrid.Sizes as Sizes exposing (Fraction)
import Html.Styled exposing (Attribute, Html, div)
import Html.Styled.Attributes exposing (css)


{-| Represents the [grid-template-areas](https://developer.mozilla.org/en-US/docs/Web/CSS/grid-template-areas) definition, including the [grid-template-rows](https://developer.mozilla.org/en-US/docs/Web/CSS/grid-template-rows) and [grid-template-columns](https://developer.mozilla.org/en-US/docs/Web/CSS/grid-template-columns) definitions.
-}
type GridAreasTemplate
    = GridTemplate Areas (List Fraction) (List Fraction)


gridAreasTemplate : Areas -> List Fraction -> List Fraction -> GridAreasTemplate
gridAreasTemplate areas rowSizes colSizes =
    GridTemplate areas rowSizes colSizes


type alias MediaQueryWithGridAreasTemplate =
    ( List MediaQuery, GridAreasTemplate )


gridAreasContainer : List MediaQueryWithGridAreasTemplate -> List (Attribute msg) -> List (GridAreaElement msg) -> Html msg
gridAreasContainer mappings attributes children =
    let
        styles =
            List.map (\( mediaQuery, gridTemlate ) -> toMediaStyle mediaQuery (gridAreasTemplateToStyle gridTemlate)) mappings
    in
    div ([ css styles ] ++ attributes)
        (List.map renderGridAreaElement children)


toMediaStyle : List MediaQuery -> Style -> Style
toMediaStyle mediaQuery style =
    withMedia mediaQuery [ style ]


gridAreasTemplateToStyle : GridAreasTemplate -> Style
gridAreasTemplateToStyle (GridTemplate areas rows cols) =
    let
        areaRows =
            List.map (\gridAreas -> String.join " " (List.map Areas.toString gridAreas)) areas

        rowSizes =
            String.join " " (List.map Sizes.fractionToString rows)

        colSizes =
            String.join " " (List.map Sizes.fractionToString cols)
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


renderGridAreaElement : GridAreaElement msg -> Html msg
renderGridAreaElement gridElem =
    div
        [ css [ property "grid-area" (Areas.toString (gridAreaElementArea gridElem)) ] ]
        (gridAreaElementChildren gridElem)
