" adds support for cleverref package (`\cref` and `\Cref`)
syn region texRefZone		matchgroup=texStatement start="\\\(c\|C\)ref{"		end="}\|%stopzone\>"	contains=@texRefGroup
syn region texComment           start="\\begin{comment}"        end="\\end{comment}"
