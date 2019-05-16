module Main exposing (Model, bigScreenTemplate, bootstrapPanel, gridTemplateBig, gridTemplateSmall, initialModel, main, smallScreenTemplate, testPanel, update, view)

import Areas exposing (contArea, footArea, headArea, naviArea)
import Bootstrap.CDN as CDN
import Bootstrap.Card as Card
import Bootstrap.ListGroup as ListGroup
import Browser
import Css exposing (border3, px, rgb, solid)
import Css.Media as Media exposing (MediaQuery, only, screen)
import CssGrid exposing (..)
import CssGrid.Areas exposing (gridAreaElement)
import CssGrid.Sizes exposing (..)
import Html
import Html.Styled exposing (Attribute, Html, div, fromUnstyled, text, toUnstyled)
import Html.Styled.Attributes exposing (css)
import Simple exposing (viewNested)


type alias Model =
    ()


gridTemplateBig : GridAreasTemplate
gridTemplateBig =
    gridAreasTemplate
        [ [ headArea, naviArea, naviArea ]
        , [ contArea, contArea, contArea ]
        , [ footArea, footArea, footArea ]
        ]
        [ fr 1, fr 4, fr 1 ]
        [ fr 1, fr 1, fr 1 ]


gridTemplateSmall : GridAreasTemplate
gridTemplateSmall =
    gridAreasTemplate
        [ [ headArea ]
        , [ contArea ]
        , [ naviArea ]
        , [ footArea ]
        ]
        [ fr 1, fr 4, fr 1, fr 1 ]
        [ fr 1 ]


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
view model =
    gridAreasContainer [ bigScreenTemplate, smallScreenTemplate ]
        []
        [ gridAreaElement headArea (testPanel "header ")
        , gridAreaElement naviArea (testPanel "nav ")
        , gridAreaElement contArea [ fromUnstyled CDN.stylesheet, bootstrapPanel, viewNested model ]
        , gridAreaElement footArea (testPanel "footer ")
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
    [ div [ css [ border3 (px 3) solid (rgb 50 50 50) ] ] (List.repeat 2 (text name)) ]


main : Program () Model msg
main =
    Browser.sandbox
        { view = view >> toUnstyled
        , update = update
        , init = initialModel
        }
