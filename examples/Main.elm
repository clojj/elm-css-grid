module Main exposing (Model, contentGridArea, footerGridArea, gridTemplateBad, gridTemplateBad_, gridTemplateBig, gridTemplateSmall, headerGridArea, initialModel, main, navGridArea, update, view)

import Browser
import Css exposing (border3, px, rgb, solid)
import Css.Media as Media exposing (MediaQuery, only, screen)
import Grid exposing (..)
import Html.Styled exposing (Attribute, Html, div, text, toUnstyled)
import Html.Styled.Attributes exposing (css)


type alias Model =
    ()


headerGridArea : GridArea
headerGridArea =
    gridArea "header"


navGridArea : GridArea
navGridArea =
    gridArea "nav"


contentGridArea : GridArea
contentGridArea =
    gridArea "content"


footerGridArea : GridArea
footerGridArea =
    gridArea "footer"


gridTemplateBad : GridTemplate -- TODO test
gridTemplateBad =
    template
        [ [ headerGridArea ], [], [ navGridArea ], [ footerGridArea ] ]
        []
        []


gridTemplateBad_ : GridTemplate -- TODO test
gridTemplateBad_ =
    template
        [ [ headerGridArea ]
        , [ contentGridArea, contentGridArea ]
        , [ navGridArea ]
        , [ footerGridArea ]
        ]
        []
        []


gridTemplateBig : GridTemplate
gridTemplateBig =
    template
        [ [ headerGridArea, navGridArea, navGridArea ]
        , [ contentGridArea, contentGridArea, contentGridArea ]
        , [ footerGridArea, footerGridArea, footerGridArea ]
        ]
        [ "1fr", "4fr", "1fr" ]
        [ "1fr", "1fr", "1fr" ]


gridTemplateSmall : GridTemplate
gridTemplateSmall =
    template
        [ [ headerGridArea ]
        , [ contentGridArea ]
        , [ navGridArea ]
        , [ footerGridArea ]
        ]
        [ "1fr", "4fr", "1fr", "1fr" ]
        [ "1fr" ]


big : MediaQueryWithGridTemplate
big =
    ( [ only screen [ Media.minWidth (px 501) ] ], gridTemplateBig )


small : MediaQueryWithGridTemplate
small =
    ( [ only screen [ Media.maxWidth (px 500) ] ], gridTemplateBig )



-- TODO construct grid-container for example view


initialModel : Model
initialModel =
    ()


update : msg -> Model -> Model
update msg model =
    model


view : Model -> Html.Styled.Html msg
view model =
    container [ big, small ]
        []
        [ gridElement headerGridArea (panel "header ")
        , gridElement navGridArea (panel "nav ")
        , gridElement contentGridArea (panel "content ")
        , gridElement footerGridArea (panel "footer ")
        ]


panel : String -> List (Html msg)
panel name =
    [ div [ css [ border3 (px 3) solid (rgb 50 50 50) ] ] (List.repeat 15 (text name)) ]


main : Program () Model msg
main =
    Browser.sandbox
        { view = view >> toUnstyled
        , update = update
        , init = initialModel
        }
