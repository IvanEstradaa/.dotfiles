import fs from "fs";
import { KarabinerRules } from "./types";
import { createHyperSubLayers, app, open, rectangle, shell } from "./utils";

const rules: KarabinerRules[] = [
  // Define the Hyper key itself
  {
    description: "Hyper Key (⌃⌥⇧⌘)",
    manipulators: [
      {
        conditions: [
          {
            name: "vim_mode",
            type: "variable_if",
            value: 0,
          },
        ],
        description: "Caps Lock -> Hyper Key",
        from: {
          key_code: "caps_lock",
          modifiers: {
            optional: ["any"],
          },
        },
        to: [
          {
            set_variable: {
              name: "hyper",
              value: 1,
            },
          },
        ],
        to_after_key_up: [
          {
            set_variable: {
              name: "hyper",
              value: 0,
            },
          },
        ],
        to_if_alone: [
          {
            set_variable: {
              name: "vim_mode",
              value: 1,
            },
          },
          {
            set_notification_message: {
                id: "vim_mode.notification_status",
                text: "Active"
            }
          },
        ],
        type: "basic",
      },
      {
        conditions: [
          {
            name: "vim_mode",
            type: "variable_if",
            value: 1,
          },
        ],
        description: "Caps Lock -> Hyper Key",
        from: {
          key_code: "caps_lock",
          modifiers: {
            optional: ["any"],
          },
        },
        to: [
          {
            set_variable: {
              name: "hyper",
              value: 1,
            },
          },
        ],
        to_after_key_up: [
          {
            set_variable: {
              name: "hyper",
              value: 0,
            },
          },
        ],
        to_if_alone: [
          {
            set_variable: {
              name: "vim_mode",
              value: 0,
            },
          },
          {
            set_notification_message: {
                id: "vim_mode.notification_status",
                text: ""
            }
          },
        ],
        type: "basic",
      },
    ],
  },

  ...createHyperSubLayers({
    // b = "B"rowse
    b: {
      h: open("https://brew.sh/"),
      t: open("https://experiencia21.tec.mx/"),
      d: open("https://doc.new/"),
      c: open("https://chatgpt.com/"),
      w: open("https://web.whatsapp.com/"),
    },
    // o = "Open" applications
    o: {
      b: app("Arc"),
      c: app("Messages"),
      e: app("FindMy"),
      k: app("Karabiner-Elements"),
      m: app("Maps"),
      t: app("Warp"),
    },
    // c = "C"onfiguracion
    c: {
      u: {
        to: [
          {
            key_code: "display_brightness_increment",
          },
        ],
      },
      j: {
        to: [
          {
            key_code: "display_brightness_decrement",
          },
        ],
      },
      i: {
        to: [
          {
            key_code: "volume_increment",
          },
        ],
      },
      k: {
        to: [
          {
            key_code: "volume_decrement",
          },
        ],
      },
      b: shell`open "x-apple.systempreferences:com.apple.preference.battery"`,
      l: shell`open "x-apple.systempreferences:com.apple.Lock-Screen-Settings.extension"`,
      a: shell`open "x-apple.systempreferences:com.apple.settings.Storage"`,
    },

    s:{
      h: open("raycast://extensions/mattisssa/spotify-player/previous"),
      j: open("raycast://extensions/mattisssa/spotify-player/volumeDown"),
      k: open("raycast://extensions/mattisssa/spotify-player/volumeUp"),
      l: open("raycast://extensions/mattisssa/spotify-player/next"),
      b: open("raycast://extensions/mattisssa/spotify-player/yourLibrary"),
      d: open("raycast://extensions/mattisssa/spotify-player/devices"),
      f: open("raycast://extensions/mattisssa/spotify-player/search"),
      a: open("raycast://extensions/mattisssa/spotify-player/toggleShuffle"),
      r: open("raycast://extensions/mattisssa/spotify-player/replay"),
      m: open("raycast://extensions/mattisssa/spotify-player/like"),
      q: open("raycast://extensions/mattisssa/spotify-player/queue"),
      p: open("raycast://extensions/mattisssa/spotify-player/togglePlayPause"),
      n: open("raycast://extensions/mattisssa/spotify-player/nowPlaying"),
    },
    
    // r = "Raycast"
    r: {
      c: open("raycast://extensions/thomas/color-picker/pick-color"),
      e: open("raycast://extensions/raycast/emoji-symbols/search-emoji-symbols"),
      h: open("raycast://extensions/ivanestradaa/mitec/horario"),
    },

    spacebar: {
      a: {
        to: [
          {
            key_code: "a",
            modifiers: ["left_shift", "left_control", "left_option", "left_command"],
          },
        ],
      },
      s: {
        to: [
          {
            key_code: "s",
            modifiers: ["left_shift", "left_control", "left_option", "left_command"],
          },
          {
            set_variable: {
              name: "vim_mode",
              value: 1,
            },
          },
          {
            set_notification_message: {
                id: "vim_mode.notification_status",
                text: "Active"
            }
          },
        ],
      },
      d: {
        to: [
          {
            key_code: "d",
            modifiers: ["left_shift", "left_control", "left_option", "left_command"],
          },
        ],
      },
    },

  }),

  {
    description: "Vim Movement (HJKL)",
    manipulators: [
      {
        conditions: [
          {
            name: "vim_mode",
            type: "variable_if",
            value: 1,
          },
        ],
        description: "H -> ←",
        from: {
          key_code: "h",
          modifiers: {
            optional: ["any"],
          },
        },
        to: [
          {
            key_code: "left_arrow",
          },
        ],
        type: "basic",
      },
      {
        conditions: [
          {
            name: "vim_mode",
            type: "variable_if",
            value: 1,
          },
        ],
        description: "J -> ↓",
        from: {
          key_code: "j",
          modifiers: {
            optional: ["any"],
          },
        },
        to: [
          {
            key_code: "down_arrow",
          },
        ],
        type: "basic",
      },
      {
        conditions: [
          {
            name: "vim_mode",
            type: "variable_if",
            value: 1,
          },
        ],
        description: "K -> ↑",
        from: {
          key_code: "k",
          modifiers: {
            optional: ["any"],
          },
        },
        to: [
          {
            key_code: "up_arrow",
          },
        ],
        type: "basic",
      },
      {
        conditions: [
          {
            name: "vim_mode",
            type: "variable_if",
            value: 1,
          },
        ],
        description: "L -> →",
        from: {
          key_code: "l",
          modifiers: {
            optional: ["any"],
          },
        },
        to: [
          {
            key_code: "right_arrow",
          },
        ],
        type: "basic",
      },
    ],
  },
  
];

fs.writeFileSync(
  "karabiner.json",
  JSON.stringify(
    {
      global: {
        show_in_menu_bar: false,
        show_profile_name_in_menu_bar: true,
      },
      profiles: [
        {
          name: "π",
          selected: true,
          virtual_hid_keyboard: { keyboard_type_v2: "ansi" },
          complex_modifications: {
            parameters: { "basic.to_if_held_down_threshold_milliseconds": 110 },
            rules,
          },
        },
        {
          name: "Default",
          virtual_hid_keyboard: { keyboard_type_v2: "ansi" },
        }
      ],
    },
    null,
    2
  )
);
