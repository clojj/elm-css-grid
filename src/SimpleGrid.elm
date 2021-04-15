module SimpleGrid exposing
    ( gridContainer, mediaGridContainer
    , gridElement
    , SimpleTemplate, simpleTemplate, GridArea, gridArea
    , ResponsiveTemplate
    , Length, fr, px
    , LengthTemplate, units, auto, minmax
    , gap
    )

{-| This library provides types and functions for building views with CSS Grid layout.
It depends on the package `rtfeldman/elm-css` for constructing styled Html.


# Definition of the CSS Grid container

@docs gridContainer, mediaGridContainer


# Definition of layouted Html, identified by a value of type `GridArea`

@docs gridElement


# Defining a (CSS Grid) template- and area-definitions

@docs SimpleTemplate, simpleTemplate, GridArea, gridArea


# Binding templates to media-queries

@docs ResponsiveTemplate


# Common length

@docs Length, fr, px


# Length for template definitions

@docs LengthTemplate, units, auto, minmax, gap

-}

import Css exposing (Style, property)
import Css.Media exposing (MediaQuery, withMedia)
import CssGrid.Areas as Areas
import CssGrid.Sizes as Sizes
import Html.Styled exposing (Attribute, Html, div)
import Html.Styled.Attributes exposing (css)


{-| Represents a [grid-area](https://developer.mozilla.org/en-US/docs/Web/CSS/grid-area), uniquely identified by a name.
The name of the grid-area must be unique for the entire view.

    gridArea "header"

The resulting GridArea will be appear in the resulting CSS in two places:

1.  As an element of the template-definition.
2.  As the value of the `grid-area` property in a Html element, which gets its layout from the template-definition.

-}
type alias GridArea =
    Areas.GridArea


{-| Constructs a GridArea
-}
gridArea : String -> GridArea
gridArea =
    Areas.gridArea


{-| Constructs a Html element with `grid-area`
-}
gridElement : GridArea -> List (Html msg) -> Areas.GridAreaElement msg
gridElement =
    Areas.gridAreaElement


{-| Length with explicit units.
-}
type alias Length =
    Sizes.Length


{-| A 'fractional' length
-}
fr : Float -> Length
fr =
    Sizes.fr


{-| A length in absolute pixels.
-}
px : Int -> Length
px =
    Sizes.px


{-| Length with explicit units plus template-specific length-values.
-}
type alias LengthTemplate =
    Sizes.LengthTemplate


{-| Constructs a length from a , which can be used in a template-definition (like `grid-template-columns`)
-}
units : Length -> LengthTemplate
units =
    Sizes.units


{-| The `auto` value from CSS Grid.
-}
auto : LengthTemplate
auto =
    Sizes.auto


{-| The `minmax` function from CSS Grid.
-}
minmax : Length -> Length -> LengthTemplate
minmax =
    Sizes.minmax


{-| The `gap` function from CSS Grid.
-}
gap : Length -> Sizes.Gap
gap =
    Sizes.gap


{-| Represents simple template for CSS Grid
-}
type SimpleTemplate
    = SimpleTemplate Areas.Areas Sizes.Gap (List Sizes.LengthTemplate)


{-| Constructor function. The resulting value represents a minimal layout definition with areas, grid-gap and grid-template-columns.
A value of this type, when used somewhere inside the `view` function, will produce CSS similar to this example:

        display: grid;
        grid-gap: 20px;
        grid-template-columns: 1fr 3fr;
        grid-template-areas:
          "header  header"
          "nav     nav"
          "sidebar content"
          "ad      footer";

Implicitly, grid-template-rows are defined as needed by the area definition.

See also [common layout](https://developer.mozilla.org/en-US/docs/Web/CSS/CSS_Grid_Layout/Realizing_common_layouts_using_CSS_Grid_Layout).

-}
simpleTemplate : Areas.Areas -> Sizes.Gap -> List Sizes.LengthTemplate -> SimpleTemplate
simpleTemplate areas gapSize columnFractions =
    SimpleTemplate areas gapSize columnFractions


{-| A pair of values, defining the media-queries (first value) for the template (second value) to be active.
-}
type alias ResponsiveTemplate =
    ( List MediaQuery, SimpleTemplate )


{-| Constructs a `div` container which will layout child-elements identified by areas defined in the template-definition(s).
Uses `ResponsiveTemplate` to provide a responsive layout for more than one media device.
-}
mediaGridContainer : List ResponsiveTemplate -> List (Attribute msg) -> List (Areas.GridAreaElement msg) -> Html msg
mediaGridContainer templateMappings attributes children =
    let
        styles =
            List.map (\( mediaQuery, gridTemlate ) -> toMediaStyle mediaQuery (simpleTemplateToStyle gridTemlate)) templateMappings
    in
    div ([ css styles ] ++ attributes)
        (List.map renderGridAreaElement children)


{-| Constructs a `div` container which will layout child-elements identified by areas defined in the template-definition(s).
Uses `SimpleTemplate` to provide one single layout.
-}
gridContainer : SimpleTemplate -> List (Attribute msg) -> List (Areas.GridAreaElement msg) -> Html msg
gridContainer template attributes children =
    let
        style =
            simpleTemplateToStyle template
    in
    div ([ css [ style ] ] ++ attributes)
        (List.map renderGridAreaElement children)


toMediaStyle : List MediaQuery -> Style -> Style
toMediaStyle mediaQuery style =
    withMedia mediaQuery [ style ]


simpleTemplateToStyle : SimpleTemplate -> Style
simpleTemplateToStyle (SimpleTemplate areas gapSize cols) =
    let
        areaRows =
            List.map (\gridAreas -> String.join " " (List.map Areas.toString gridAreas)) areas

        colSizes =
            String.join " " (List.map Sizes.lengthTemplateToString cols)

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
        , property "grid-gap" (Sizes.gapToString gapSize)
        ]
            ++ templateCols


renderGridAreaElement : Areas.GridAreaElement msg -> Html msg
renderGridAreaElement gridElem =
    div
        [ css [ property "grid-area" (Areas.toString (Areas.gridAreaElementArea gridElem)) ] ]
        (Areas.gridAreaElementChildren gridElem)
