module Areas exposing (cont, contArea, foot, footArea, head, headArea, navi, naviArea)

import CssGrid.Areas exposing (GridArea, gridArea)



{- Some globally unique area names -}


headArea : GridArea
headArea =
    gridArea "header"


naviArea : GridArea
naviArea =
    gridArea "nav"


contArea : GridArea
contArea =
    gridArea "content"


footArea : GridArea
footArea =
    gridArea "footer"


head : GridArea
head =
    gridArea "header"


navi : GridArea
navi =
    gridArea "nav"


cont : GridArea
cont =
    gridArea "content"


foot : GridArea
foot =
    gridArea "footer"
