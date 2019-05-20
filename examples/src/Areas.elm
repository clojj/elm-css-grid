module Areas exposing (cont, cont1, contLeft, contLeft1, contRight, contRight1, foot, foot1, head, head1, navi, navi1, headFix, contFix, footFix)

import CssGrid.Areas exposing (GridArea, gridArea)



{- Some globally unique area names -}


headFix : GridArea
headFix =
    gridArea "headFix"


contFix : GridArea
contFix =
    gridArea "contentFix"


footFix : GridArea
footFix =
    gridArea "footFix"


head1 : GridArea
head1 =
    gridArea "HEADER"


navi1 : GridArea
navi1 =
    gridArea "NAV"


cont1 : GridArea
cont1 =
    gridArea "CONTENT"


contLeft1 : GridArea
contLeft1 =
    gridArea "CONTENTLEFT"


contRight1 : GridArea
contRight1 =
    gridArea "CONTENTRIGHT"


foot1 : GridArea
foot1 =
    gridArea "FOOTER"


head : GridArea
head =
    gridArea "header"


navi : GridArea
navi =
    gridArea "nav"


cont : GridArea
cont =
    gridArea "content"


contLeft : GridArea
contLeft =
    gridArea "contentLeft"


contRight : GridArea
contRight =
    gridArea "contentRight"


foot : GridArea
foot =
    gridArea "footer"
