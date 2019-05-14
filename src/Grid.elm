module Grid exposing (Area, GridContainer, GridElement, GridTemplate, container, gridArea, gridContainer, gridElement, template)

import Array2D exposing (Array2D)
import Css exposing (Style, property, px)
import Css.Media as Media exposing (MediaQuery, only, screen, withMedia)
import Html.Styled exposing (Attribute, Html, div)
import Html.Styled.Attributes exposing (css)
import Tagged exposing (Tagged(..))


type GridArea
    = GridArea


type alias Area =
    Tagged GridArea String


gridArea : String -> Area
gridArea name =
    Tagged name

-- TODO
type alias RowSize = String
-- TODO
type alias ColSize = String

type GridTemplate
    = GridTemplate (Array2D Area) (List RowSize) (List ColSize)


template : Array2D Area -> List RowSize -> List ColSize -> GridTemplate
template areaLists rowSizes colSizes =
    GridTemplate areaLists rowSizes colSizes


type GridContainer
    = GridContainer (List ( List MediaQuery, GridTemplate ))


container : List ( List MediaQuery, GridTemplate ) -> GridContainer
container mappings =
    -- TODO
    GridContainer []



-- TODO typed area names !
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


{-| Creates a grid-area element that gets its grid-position by the area's name
-}
gridElement : String -> List (Html msg) -> GridElement msg
gridElement area children =
    GridElement
        { area = area
        , children = children
        }
