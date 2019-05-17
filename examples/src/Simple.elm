module Simple exposing (gridTemplateBig, viewNested)

import Areas exposing (cont, contLeft, contRight, foot, head, navi)
import Css as Css
import Css.Media as Media exposing (only, screen)
import CssGrid.Areas exposing (GridArea, gridAreaElement)
import CssGrid.Simple exposing (ResponsiveTemplate, SimpleTemplate, simpleContainer, simpleTemplate)
import CssGrid.Sizes exposing (fr, gapPx, px)
import Html.Styled exposing (Html, div, text)
import Html.Styled.Attributes exposing (css)



-- TODO define template with Int fractionals only ?


gridTemplateBig : SimpleTemplate
gridTemplateBig =
    simpleTemplate
        [ [ head, navi, navi ]
        , [ contLeft, cont, contRight ]
        , [ foot, foot, foot ]
        ]
        (gapPx 5)
        [ fr 1, fr 3, fr 1 ]



-- TODO 'grid-template-columns: 1fr' is implicit... use an empty list here


gridTemplateSmall : SimpleTemplate
gridTemplateSmall =
    simpleTemplate
        [ [ head ]
        , [ contLeft ]
        , [ cont ]
        , [ contRight ]
        , [ navi ]
        , [ foot ]
        ]
        (gapPx 5)
        []


bigScreenTemplate : ResponsiveTemplate
bigScreenTemplate =
    ( [ only screen [ Media.minWidth (Css.px 201) ] ], gridTemplateBig )


smallScreenTemplate : ResponsiveTemplate
smallScreenTemplate =
    ( [ only screen [ Media.maxWidth (Css.px 200) ] ], gridTemplateSmall )


viewNested : () -> Html.Styled.Html msg
viewNested _ =
    simpleContainer [ bigScreenTemplate, smallScreenTemplate ]
        []
        [ gridAreaElement head (panel "head")
        , gridAreaElement navi (panel "navi")
        , gridAreaElement contLeft (panel "LEFT")
        , gridAreaElement cont (panel "cont")
        , gridAreaElement contRight (panel "RIGHT")
        , gridAreaElement foot (panel "foot")
        ]


panel : String -> List (Html msg)
panel str =
    [ div [ css [ Css.border3 (Css.px 1) Css.solid (Css.rgb 20 20 20) ] ] [ text str ] ]
