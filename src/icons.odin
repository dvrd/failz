package failz

import "libs:ansi"

INFO := ansi.bold(ansi.colorize("  ", {80, 150, 225}))
ERROR := ansi.colorize("  ", {220, 20, 60})
WARNING := ansi.colorize("  ", {255, 210, 0})
MESSAGE := ansi.colorize("  ", {0, 144, 255})
DEBUG := ansi.colorize("  ", {204, 146, 255})
PROMPT := ansi.colorize(" 󰠗 ", {0, 144, 255})
