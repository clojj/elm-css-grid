module SimpleGrid exposing
    ( simpleTemplate
    , ResponsiveTemplate
    , simpleContainer
    , SimpleTemplate
    )

{-| This library provides types and functions for building views with CSS Grid layout.
It depends on the package `rtfeldman/elm-css` for constructing styled Html (Copyright (c) 2015, Richard Feldman).


# Common length values (currently a subset of the CSS Grid specification!)

@docs fr, px


# Length values for template definitions (currently a subset of the CSS Grid specification!)

@docs units, auto, minmax


# Defining a (CSS Grid) template and areas

@docs simpleTemplate, gridArea


# Binding templates to media-queries

@docs ResponsiveTemplate


# Definition of the CSS Grid container

@docs simpleContainer


# Definition of layouted Html, carrying a CSS attribute `grid-area`.

@docs gridAreaElement

-}

import Css exposing (Style, property)
import Css.Media exposing (MediaQuery, withMedia)
import CssGrid.Areas as Areas exposing (Areas, GridAreaElement, gridAreaElementArea, gridAreaElementChildren)
import CssGrid.Sizes exposing (Gap, Length, LengthTemplate, gapToString, lengthTemplateToString)
import Html.Styled exposing (Attribute, Html, div)
import Html.Styled.Attributes exposing (css)


type SimpleTemplate
    = SimpleTemplate Areas Gap (List LengthTemplate)


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
simpleTemplate : Areas -> Gap -> List LengthTemplate -> SimpleTemplate
simpleTemplate areas gap columnFractions =
    SimpleTemplate areas gap columnFractions


{-| A pair of values, defining the media-queries (first value) for the template (second value) to be active.
-}
type alias ResponsiveTemplate =
    ( List MediaQuery, SimpleTemplate )


{-| Constructs a `div` container which will layout child-elements with area-names according to the given template-definitions.
-}
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
            String.join " " (List.map lengthTemplateToString cols)

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
