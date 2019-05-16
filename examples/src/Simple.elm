module Simple exposing (gridTemplateBig, viewNested)

import Areas exposing (cont, foot, head, navi)
import Css exposing (px)
import Css.Media as Media exposing (only, screen)
import CssGrid.Areas exposing (GridArea, gridArea, gridAreaElement)
import CssGrid.Simple exposing (ResponsiveTemplate, SimpleTemplate, simpleContainer, simpleTemplate)
import CssGrid.Sizes exposing (fr, gapPx)
import Html.Styled exposing (text)


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
        [ fr 1 ]


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
        [ gridAreaElement head [ text "head " ]
        , gridAreaElement navi [ text "navi" ]
        , gridAreaElement cont [ text "cont" ]
        , gridAreaElement foot [ text "foot" ]
        ]
