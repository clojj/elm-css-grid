- complete https://developer.mozilla.org/en-US/docs/Web/CSS/CSS_Grid_Layout/Realizing_common_layouts_using_CSS_Grid_Layout

    see https://codepen.io/clojj/pen/pmwWvL?&editable=true

- using `units (fr 1)` instead of just `fr 1` is a bit unfortunate, but it enforces CSS Grid validity

- validate templates ? `Result Error err Ok template` as type ?

- 'bad' templates can be defined, if the areas column- or row-length differs from any grid-template-rows/columns 

- 'bad' templates can be defined, if the areas are do not shape a rectangle

- implement spec for sizes

    `Each parameter can be a <length>, a <percentage>, a <flex> value, or one of the keyword values max-content, min-content, or auto.`

    `Some properties allow negative <length>s, while others do not.`

- parameterize by fixed responsive 'profile' ("best-practices" media-queries) ?

