# color.coffee, jjdl_android/src/ui/

# main color
_MC_GREEN = 'hsl(120, 100%, 30%)'  # logo bg color
_MC_BLACK = 'hsl(0, 0%, 0%)'
_MC_WHITE = 'hsl(0, 0%, 100%)'


# BG color
BG = _MC_BLACK

BG_SEC = 'hsl(120, 100%, 5%)'  # second BG
BG_TOP = 'hsl(120, 100%, 20%)'
BG_LEFT = 'hsl(120, 100%, 90%)'

# button
BG_BTN = 'hsl(120, 100%, 10%)'  # primary button
BG_BTN_DANGER = 'hsl(120, 50%, 8%)'  # danger button

BG_TOUCH = 'hsl(120, 100%, 40%)'  # button touch background
BG_CHECK = 'hsl(120, 100%, 30%)'

# text
TEXT_TITLE = _MC_WHITE

TEXT = 'hsl(0, 0%, 80%)'
TEXT_SEC = 'hsl(0, 0%, 64%)'

module.exports = {
  BG
  BG_SEC
  BG_LEFT
  BG_TOP

  BG_BTN
  BG_BTN_DANGER
  BG_TOUCH
  BG_CHECK

  TEXT
  TEXT_SEC
  TEXT_TITLE
}
