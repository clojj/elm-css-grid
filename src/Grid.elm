module Grid exposing (GridElement, gridContainer, gridElement)

import Css exposing (Style, property, px)
import Css.Media as Media exposing (only, screen, withMedia)
import Html.Styled exposing (Attribute, Html, div)
import Html.Styled.Attributes exposing (css)


{-| Opaque type representing a grid-area element
-}
type GridElement msg
    = GridElement
        { area : String
        , children : List (Html msg)
        }

renderGridElement : GridElement msg -> Html msg
renderGridElement gridElem =
    case gridElem of
        GridElement { area, children } ->
            div
                [ css [ property "grid-area" area ] ]
                children

-- TODO typed area names !
{-| Creates a grid-area element that gets its grid-position by the area's name
-}
gridElement : String -> List (Html msg) -> GridElement msg
gridElement area children =
    GridElement
        { area = area
        , children = children
        }

-- TODO media-query related grid-templates and values -> as configuration parameters !

{-| Creates a grid-container with grid-area-template(s)
-}
gridContainer : List (Attribute msg) -> List (GridElement msg) -> Html msg
gridContainer attributes children =
    div ([ css [ contentBig, contentSmall ] ] ++ attributes)
        (List.map renderGridElement children)


contentBig : Style
contentBig =
    withMedia [ only screen [ Media.minWidth (px 501) ] ]
        [ gridTemplate [ "button url", "main main" ] [ "1fr 5fr" ] [ "1fr 5fr" ] ]


contentSmall : Style
contentSmall =
    withMedia [ only screen [ Media.maxWidth (px 500) ] ]
        [ gridTemplate [ "button", "main", "url" ] [ "1fr 5fr 1fr" ] [ "1fr" ] ]


gridTemplate : List String -> List String -> List String -> Style
gridTemplate areas rows cols =
    Css.batch
        [ property "display" "grid"
        , property "width" "100%"
        , property "grid-template-areas" <| String.join " " (List.map (\s -> "'" ++ s ++ "'") areas)
        , property "grid-template-rows" <| String.join "" rows
        , property "grid-row-gap" "10px"
        , property "grid-template-columns" <| String.join "" cols
        , property "grid-column-gap" "10px"
        ]