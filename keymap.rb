kbd = Keyboard.new

kbd.init_pins(
  [ 9, 10, 11, 12, 14 ],  # row0, row1,... respectively
  [ 5, 4, 2, 3 ]          # col0, col1,... respectively
)

kbd.add_layer :default, %i[
  KC_BSPACE KC_SPACE  KC_KP_SLASH KC_KP_ASTERISK
  KC_KP_7   KC_KP_8   KC_KP_9     KC_KP_MINUS
  KC_KP_4   KC_KP_5   KC_KP_6     KC_KP_PLUS
  KC_KP_1   KC_KP_2   KC_KP_3     RAISE_ENTER
  KC_KP_DOT KC_KP_0
]

kbd.add_layer :raise, %i[
  KC_BSPACE   KC_NUMLOCK  KC_KP_SLASH RGB_TOGGLE
  KC_KP_7     KC_UP       KC_KP_9     KC_VOLDOWN
  KC_LEFT     KC_KP_5     KC_RIGHT    KC_VOLUP
  KC_KP_1     KC_DOWN     KC_KP_3     RAISE_ENTER
  KC_KP_EQUAL KC_MUTE
]

#                   Your custom     Keycode or             Keycode (only modifiers)      Release time      Re-push time
#                   key name        Array of Keycode       or Layer Symbol to be held    threshold(ms)     threshold(ms)
#                                   or Proc                or Proc which will run        to consider as    to consider as
#                                   when you click         while you keep press          `click the key`   `hold the key`
kbd.define_mode_key :RAISE_ENTER, [ :KC_KP_ENTER,          :raise,                       200,              150 ]

rgb = RGB.new(
  0,    # pin number
  28,   # size of underglow pixel
  0,    # size of backlight pixel
  false # 32bit data will be sent to a pixel if true while 24bit if false
)

rgb.effect     = :swirl
rgb.speed      = 20   # 1-31  / default: 22
# rgb.hue        = 30 # 0-100 / default: 0
# rgb.saturation = 50 # 0-100 / default: 100
rgb.max_value  = 5    # 1-31  / default: 13

kbd.append rgb

kbd.define_mode_key :RGB_TOGGLE,  [ Proc.new { rgb.toggle }, :KC_NO,                     300,              nil ]

kbd.start!
