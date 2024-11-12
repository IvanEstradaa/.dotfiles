import fs from "fs";
import { KarabinerRules } from "./types";
import { createHyperSubLayers, app, open, rectangle, shell } from "./utils";

const rules: KarabinerRules[] = [
  // Define the Hyper key itself
  {
    description: "Hyper Key (⌃⌥⇧⌘)",
    manipulators: [
      {
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
            key_code: "escape",
          },
        ],
        type: "basic",
      },
      //      {
      //        type: "basic",
      //        description: "Disable CMD + Tab to force Hyper Key usage",
      //        from: {
      //          key_code: "tab",
      //          modifiers: {
      //            mandatory: ["left_command"],
      //          },
      //        },
      //        to: [
      //          {
      //            key_code: "tab",
      //          },
      //        ],
      //      },
    ],
  },
  /*
  {
    description: "Home Row Mods A",
    manipulators: [
      {
        description: "A -> ⌃",
        from: {
          key_code: "a",
          modifiers: {
            optional: ["any"],
          },
        },
        to: [
          {
            key_code: "left_control",
            "lazy": true,
          },
        ],
        to_if_alone: [
          {
            key_code: "a",
          },
        ],
        type: "basic",
      },
    ],
  },
  {
    description: "Home Row Mods S",
    manipulators: [
      {
        description: "S -> ⌥",
        from: {
          key_code: "s",
          modifiers: {
            optional: ["any"],
          },
        },
        to: [
          {
            key_code: "left_option",
            "lazy": true,
          },
        ],
        to_if_alone: [
          {
            key_code: "s",
          },
        ],
        type: "basic",
      },
    ],
  },
  {
    description: "Home Row Mods D",
    manipulators: [
      {
        description: "D -> ⌘",
        from: {
          key_code: "d",
          modifiers: {
            optional: ["any"],
          },
        },
        to: [
          {
            key_code: "left_command",
            "lazy": true,
          },
        ],
        to_if_alone: [
          {
            key_code: "d",
          },
        ],
        type: "basic",
      },
    ],
  },
  {
    description: "Home Row Mods F",
    manipulators: [
      {
        description: "F -> ⇧",
        from: {
          key_code: "f",
          modifiers: {
            optional: ["any"],
          },
        },
        to: [
          {
            key_code: "left_shift",
            "lazy": true,
          },
        ],
        to_if_alone: [
          {
            key_code: "f",
          },
        ],
        type: "basic",
      },
    ],
  },
  {
    description: "Home Row Mods enie",
    manipulators: [
      {
        description: "enie -> ⌃",
        from: {
          key_code: "semicolon",
          modifiers: {
            optional: ["any"],
          },
        },
        to: [
          {
            key_code: "right_control",
            "lazy": true,
          },
        ],
        to_if_alone: [
          {
            key_code: "semicolon",
          },
        ],
        type: "basic",
      },
    ],
  },
  {
    description: "Home Row Mods L",
    manipulators: [
      {
        description: "L -> ⌥",
        from: {
          key_code: "l",
          modifiers: {
            optional: ["any"],
          },
        },
        to: [
          {
            key_code: "right_option",
            "lazy": true,
          },
        ],
        to_if_alone: [
          {
            key_code: "l",
          },
        ],
        type: "basic",
      },
    ],
  },
  {
    description: "Home Row Mods K",
    manipulators: [
      {
        description: "K -> ⌘",
        from: {
          key_code: "k",
          modifiers: {
            optional: ["any"],
          },
        },
        to: [
          {
            key_code: "right_command",
            "lazy": true,
          },
        ],
        to_if_alone: [
          {
            key_code: "k",
          },
        ],
        type: "basic",
      },
    ],
  },
  {
    description: "Home Row Mods J",
    manipulators: [
      {
        description: "J -> ⇧",
        from: {
          key_code: "j",
          modifiers: {
            optional: ["any"],
          },
        },
        to: [
          {
            key_code: "right_shift",
            "lazy": true,
          },
        ],
        to_if_alone: [
          {
            key_code: "j",
          },
        ],
        type: "basic",
      },
    ],
  },
  */

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
      t: app("Warp"),
      b: app("Arc"),
      c: app("Visual Studio Code"),
      e: app("FindMy"),
    },
    // a = "A"erospace
    a: {
      h: shell`osascript -e 'tell application "Terminal" to do script "aerospace join-with left && aerospace layout v_accordion && exit"'`,
      t: shell`osascript -e 'tell application "Terminal" to do script "aerospace resize width 415 && exit"'`,
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
      /*
      l: {
        to: [
          {
            key_code: "q",
            modifiers: ["right_control", "right_command"],
          },
        ],
      },
      p: {
        to: [
          {
            key_code: "play_or_pause",
          },
        ],
      },
      semicolon: {
        to: [
          {
            key_code: "fastforward",
          },
        ],
      },
      e: open(
        `raycast://extensions/thomas/elgato-key-light/toggle?launchType=background`
      ),
      // "D"o not disturb toggle
      d: open(
        `raycast://extensions/yakitrak/do-not-disturb/toggle?launchType=background`
      ),
      // "T"heme
      t: open(`raycast://extensions/raycast/system/toggle-system-appearance`),
      c: open("raycast://extensions/raycast/system/open-camera"),
      // 'v'oice
      v: {
        to: [
          {
            key_code: "spacebar",
            modifiers: ["left_option"],
          },
        ],
      },
      */
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
      /*
      n: open("raycast://script-commands/dismiss-notifications"),
      l: open(
        "raycast://extensions/stellate/mxstbr-commands/create-mxs-is-shortlink"
      ),
      p: open("raycast://extensions/raycast/raycast/confetti"),
      a: open("raycast://extensions/raycast/raycast-ai/ai-chat"),
      s: open("raycast://extensions/peduarte/silent-mention/index"),
      h: open(
        "raycast://extensions/raycast/clipboard-history/clipboard-history"
      ),
      1: open(
        "raycast://extensions/VladCuciureanu/toothpick/connect-favorite-device-1"
      ),
      2: open(
        "raycast://extensions/VladCuciureanu/toothpick/connect-favorite-device-2"
      ),
      */
    },
    /*
    // v = "moVe" which isn't "m" because we want it to be on the left hand
    // so that hjkl work like they do in vim
    v: {
      h: {
        to: [{ key_code: "left_arrow" }],
      },
      j: {
        to: [{ key_code: "down_arrow" }],
      },
      k: {
        to: [{ key_code: "up_arrow" }],
      },
      l: {
        to: [{ key_code: "right_arrow" }],
      },
      // Magicmove via homerow.app
      m: {
        to: [{ key_code: "f", modifiers: ["right_control"] }],
        // TODO: Trigger Vim Easymotion when VSCode is focused
      },
      // Scroll mode via homerow.app
      s: {
        to: [{ key_code: "j", modifiers: ["right_control"] }],
      },
      d: {
        to: [{ key_code: "d", modifiers: ["right_shift", "right_command"] }],
      },
      u: {
        to: [{ key_code: "page_down" }],
      },
      i: {
        to: [{ key_code: "page_up" }],
      },
    },
    */
    
    /*
    spacebar: open(
      "raycast://extensions/stellate/mxstbr-commands/create-notion-todo"
    ),
    */

    // TODO: This doesn't quite work yet.
    // l = "Layouts" via Raycast's custom window management
    // l: {
    //   // Coding layout
    //   c: shell`
    //     open -a "Visual Studio Code.app"
    //     sleep 0.2
    //     open -g "raycast://customWindowManagementCommand?position=topLeft&relativeWidth=0.5"

    //     open -a "Terminal.app"
    //     sleep 0.2
    //     open -g "raycast://customWindowManagementCommand?position=topRight&relativeWidth=0.5"
    //   `,
    // },

    /*
    // w = "Window" via rectangle.app
    w: {
      semicolon: {
        description: "Window: Hide",
        to: [
          {
            key_code: "h",
            modifiers: ["right_command"],
          },
        ],
      },
      y: rectangle("previous-display"),
      o: rectangle("next-display"),
      k: rectangle("top-half"),
      j: rectangle("bottom-half"),
      h: rectangle("left-half"),
      l: rectangle("right-half"),
      f: rectangle("maximize"),
      u: {
        description: "Window: Previous Tab",
        to: [
          {
            key_code: "tab",
            modifiers: ["right_control", "right_shift"],
          },
        ],
      },
      i: {
        description: "Window: Next Tab",
        to: [
          {
            key_code: "tab",
            modifiers: ["right_control"],
          },
        ],
      },
      n: {
        description: "Window: Next Window",
        to: [
          {
            key_code: "grave_accent_and_tilde",
            modifiers: ["right_command"],
          },
        ],
      },
      b: {
        description: "Window: Back",
        to: [
          {
            key_code: "open_bracket",
            modifiers: ["right_command"],
          },
        ],
      },
      // Note: No literal connection. Both f and n are already taken.
      m: {
        description: "Window: Forward",
        to: [
          {
            key_code: "close_bracket",
            modifiers: ["right_command"],
          },
        ],
      },
    },
    */

    // c = Musi*c* which isn't "m" because we want it to be on the left hand
    /*
    s: {
      p: {
        to: [{ key_code: "play_or_pause" }],
      },
      n: {
        to: [{ key_code: "fastforward" }],
      },
      b: {
        to: [{ key_code: "rewind" }],
      },
    },
    */
  }),

  {
    description: "Vim movement H",
    manipulators: [
      {
        conditions: [
          {
            name: "hyper",
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
    ],
  },
  {
    description: "Vim movement J",
    manipulators: [
      {
        conditions: [
          {
            name: "hyper",
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
    ],
  },
  {
    description: "Vim movement K",
    manipulators: [
      {
        conditions: [
          {
            name: "hyper",
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
    ],
  },
  {
    description: "Vim movement L",
    manipulators: [
      {
        conditions: [
          {
            name: "hyper",
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
          complex_modifications: {
            rules,
          },
        },
        {
          name: "Default",
        }
      ],
    },
    null,
    2
  )
);
