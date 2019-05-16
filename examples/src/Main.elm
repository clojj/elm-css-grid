module Main exposing (Model, bigScreenTemplate, contentGridArea, footerGridArea, gridTemplateBig, gridTemplateSmall, headerGridArea, initialModel, main, navGridArea, smallScreenTemplate, testPanel, update, view)

import Bootstrap.CDN as CDN
import Bootstrap.Card as Card
import Bootstrap.ListGroup as ListGroup
import Browser
import Css exposing (border3, px, rgb, solid)
import Css.Media as Media exposing (MediaQuery, only, screen)
import CssGrid exposing (..)
import Html
import Html.Styled exposing (Attribute, Html, div, fromUnstyled, text, toUnstyled)
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


gridTemplateBig : GridAreasTemplate
gridTemplateBig =
    gridAreasTemplate
        [ [ headerGridArea, navGridArea, navGridArea ]
        , [ contentGridArea, contentGridArea, contentGridArea ]
        , [ footerGridArea, footerGridArea, footerGridArea ]
        ]
        [ "1fr", "4fr", "1fr" ]
        [ "1fr", "1fr", "1fr" ]


gridTemplateSmall : GridAreasTemplate
gridTemplateSmall =
    gridAreasTemplate
        [ [ headerGridArea ]
        , [ contentGridArea ]
        , [ navGridArea ]
        , [ footerGridArea ]
        ]
        [ "1fr", "4fr", "1fr", "1fr" ]
        [ "1fr" ]


bigScreenTemplate : MediaQueryWithGridAreasTemplate
bigScreenTemplate =
    ( [ only screen [ Media.minWidth (px 501) ] ], gridTemplateBig )


smallScreenTemplate : MediaQueryWithGridAreasTemplate
smallScreenTemplate =
    ( [ only screen [ Media.maxWidth (px 500) ] ], gridTemplateSmall )


initialModel : Model
initialModel =
    ()


update : msg -> Model -> Model
update _ model =
    model


view : Model -> Html.Styled.Html msg
view _ =
    gridAreasContainer [ bigScreenTemplate, smallScreenTemplate ]
        []
        [ gridAreaElement headerGridArea (testPanel "header ")
        , gridAreaElement navGridArea (testPanel "nav ")
        , gridAreaElement contentGridArea [ fromUnstyled CDN.stylesheet, bootstrapPanel ]
        , gridAreaElement footerGridArea (testPanel "footer ")
        ]


bootstrapPanel =
    Card.config []
        |> Card.listGroup
            [ ListGroup.li [ ListGroup.success ] [ Html.text "Cras justo odio" ]
            , ListGroup.li [ ListGroup.info ] [ Html.text "Dapibus ac facilisis in" ]
            , ListGroup.li [ ListGroup.warning ] [ Html.text "Vestibulum at eros" ]
            ]
        |> Card.view
        |> fromUnstyled


testPanel : String -> List (Html msg)
testPanel name =
    [ div [ css [ border3 (px 3) solid (rgb 50 50 50) ] ] (List.repeat 15 (text name)) ]


main : Program () Model msg
main =
    Browser.sandbox
        { view = view >> toUnstyled
        , update = update
        , init = initialModel
        }
