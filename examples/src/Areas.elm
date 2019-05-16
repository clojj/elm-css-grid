module Areas exposing (contArea, footArea, headArea, naviArea)

import CssGrid.Areas exposing (GridArea, gridArea)


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
