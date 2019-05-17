module Simple exposing (gridTemplateBig, viewNested)

import Areas exposing (cont, foot, head, navi)
import Css exposing (border3, px, rgb, solid)
import Css.Media as Media exposing (only, screen)
import CssGrid.Areas exposing (GridArea, gridArea, gridAreaElement)
import CssGrid.Simple exposing (ResponsiveTemplate, SimpleTemplate, simpleContainer, simpleTemplate)
import CssGrid.Sizes exposing (fr, gapPx)
import Html.Styled exposing (Html, div, text)
import Html.Styled.Attributes exposing (css)



-- TODO define template with Int fractionals only ?


gridTemplateBig : SimpleTemplate
gridTemplateBig =
    simpleTemplate
        [ [ head, navi, navi ]
        , [ cont, cont, cont ]
        , [ foot, foot, foot ]
        ]
        (gapPx 5)
        [ fr 1, fr 1, fr 1 ]



-- TODO 'grid-template-columns: 1fr' is implicit... use an empty list here


gridTemplateSmall : SimpleTemplate
gridTemplateSmall =
    simpleTemplate
        [ [ head ]
        , [ cont ]
        , [ navi ]
        , [ foot ]
        ]
        (gapPx 5)
        []


bigScreenTemplate : ResponsiveTemplate
bigScreenTemplate =
    ( [ only screen [ Media.minWidth (px 201) ] ], gridTemplateBig )


smallScreenTemplate : ResponsiveTemplate
smallScreenTemplate =
    ( [ only screen [ Media.maxWidth (px 200) ] ], gridTemplateSmall )


viewNested : () -> Html.Styled.Html msg
viewNested _ =
    simpleContainer [ bigScreenTemplate, smallScreenTemplate ]
        []
        [ gridAreaElement head (panel "head")
        , gridAreaElement navi (panel "navi")
        , gridAreaElement cont (panel "cont")
        , gridAreaElement foot (panel "foot")
        ]


panel : String -> List (Html msg)
panel str =
    [ div [ css [ border3 (px 1) solid (rgb 20 20 20) ] ] [ text str ] ]
