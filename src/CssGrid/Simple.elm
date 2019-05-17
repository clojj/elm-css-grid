module CssGrid.Simple exposing (ResponsiveTemplate, SimpleTemplate, simpleContainer, simpleTemplate)

import Css exposing (Style, property)
import Css.Media exposing (MediaQuery, withMedia)
import CssGrid.Areas as Areas exposing (Areas, GridAreaElement, gridAreaElementArea, gridAreaElementChildren)
import CssGrid.Sizes as Sizes exposing (Fraction, Gap, gapToString)
import Html.Styled exposing (Attribute, Html, div)
import Html.Styled.Attributes exposing (css)



-- TODO common template: https://developer.mozilla.org/en-US/docs/Web/CSS/CSS_Grid_Layout/Realizing_common_layouts_using_CSS_Grid_Layout
-- TODO define template with Int fractionals only ?


{-| Represents a minimal fraction-based layout with area names and a grid-gap.
For example:

        display: grid;
        grid-gap: 20px;
        grid-template-columns: 1fr 3fr;
        grid-template-areas:
          "header  header"
          "nav     nav"
          "sidebar content"
          "ad      footer";

Implicitly, grid-template-rows are defined as needed by the area definition.
See also this [common layout](https://developer.mozilla.org/en-US/docs/Web/CSS/CSS_Grid_Layout/Realizing_common_layouts_using_CSS_Grid_Layout).

-}
type SimpleTemplate
    = SimpleTemplate Areas Gap (List Fraction)


simpleTemplate : Areas -> Gap -> List Fraction -> SimpleTemplate
simpleTemplate areas gap columnFractions =
    SimpleTemplate areas gap columnFractions


type alias ResponsiveTemplate =
    ( List MediaQuery, SimpleTemplate )


simpleContainer : List ResponsiveTemplate -> List (Attribute msg) -> List (GridAreaElement msg) -> Html msg
simpleContainer mappings attributes children =
    let
        styles =
            List.map (\( mediaQuery, gridTemlate ) -> toMediaStyle mediaQuery (simpleTemplateToStyle gridTemlate)) mappings
    in
    div ([ css styles ] ++ attributes)
        (List.map renderGridAreaElement children)


toMediaStyle : List MediaQuery -> Style -> Style
toMediaStyle mediaQuery style =
    withMedia mediaQuery [ style ]


simpleTemplateToStyle : SimpleTemplate -> Style
simpleTemplateToStyle (SimpleTemplate areas gap cols) =
    let
        areaRows =
            List.map (\gridAreas -> String.join " " (List.map Areas.toString gridAreas)) areas

        colSizes =
            String.join " " (List.map Sizes.fractionToString cols)

        templateCols =
            case cols of
                [] ->
                    []

                _ ->
                    [ property "grid-template-columns" colSizes ]
    in
    Css.batch <|
        [ property "display" "grid"
        , property "width" "100%"
        , property "grid-template-areas" <| String.join " " (List.map (\s -> "'" ++ s ++ "'") areaRows)
        , property "grid-gap" (gapToString gap)
        ]
            ++ templateCols


renderGridAreaElement : GridAreaElement msg -> Html msg
renderGridAreaElement gridElem =
    div
        [ css [ property "grid-area" (Areas.toString (gridAreaElementArea gridElem)) ] ]
        (gridAreaElementChildren gridElem)
