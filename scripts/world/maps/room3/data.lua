return {
  version = "1.9",
  luaversion = "5.1",
  tiledversion = "1.9.0",
  class = "",
  orientation = "orthogonal",
  renderorder = "right-down",
  width = 33,
  height = 12,
  tilewidth = 40,
  tileheight = 40,
  nextlayerid = 7,
  nextobjectid = 65,
  properties = {
    ["border"] = "castle",
    ["music"] = "deltarune/castletown_empty",
    ["name"] = "Test Map - Room 3"
  },
  tilesets = {
    {
      name = "castle",
      firstgid = 1,
      filename = "../../tilesets/castle.tsx",
      exportfilename = "../../tilesets/castle.lua"
    },
    {
      name = "devroom-objects",
      firstgid = 61,
      filename = "../../tilesets/devroom-objects.tsx",
      exportfilename = "../../tilesets/devroom-objects.lua"
    }
  },
  layers = {
    {
      type = "tilelayer",
      x = 0,
      y = 0,
      width = 33,
      height = 12,
      id = 1,
      name = "Tile Layer 1",
      class = "",
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      parallaxx = 1,
      parallaxy = 1,
      properties = {},
      encoding = "lua",
      data = {
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 10, 12, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 10, 12, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 18, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 20, 10, 12, 18, 19, 19, 19, 19, 19, 19, 19, 20,
        18, 19, 19, 20, 22, 23, 23, 23, 23, 23, 23, 23, 23, 23, 23, 23, 23, 23, 23, 23, 23, 24, 10, 12, 22, 23, 23, 23, 23, 23, 23, 23, 24,
        23, 23, 23, 24, 22, 23, 23, 23, 23, 23, 23, 23, 23, 23, 23, 23, 23, 23, 23, 23, 23, 24, 10, 12, 22, 23, 23, 23, 23, 23, 23, 23, 24,
        23, 23, 23, 24, 26, 27, 27, 27, 27, 27, 27, 27, 27, 27, 27, 27, 27, 27, 27, 27, 27, 28, 10, 12, 26, 27, 27, 27, 27, 27, 27, 27, 27,
        27, 27, 27, 28, 6, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 11, 11, 7, 7, 7, 7, 7, 7, 7, 7, 7,
        7, 7, 7, 7, 0, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11,
        0, 0, 0, 0, 0, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11,
        15, 15, 15, 15, 0, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11,
        0, 0, 0, 0, 14, 15, 15, 15, 15, 11, 11, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 10, 12, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
      }
    },
    {
      type = "objectgroup",
      draworder = "topdown",
      id = 2,
      name = "collision",
      class = "",
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      parallaxx = 1,
      parallaxy = 1,
      properties = {},
      objects = {
        {
          id = 1,
          name = "",
          class = "",
          shape = "rectangle",
          x = 160,
          y = 200,
          width = 720,
          height = 40,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 2,
          name = "",
          class = "",
          shape = "rectangle",
          x = 0,
          y = 240,
          width = 160,
          height = 40,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 3,
          name = "",
          class = "",
          shape = "rectangle",
          x = 440,
          y = 440,
          width = 880,
          height = 40,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 11,
          name = "",
          class = "",
          shape = "rectangle",
          x = 960,
          y = 200,
          width = 360,
          height = 40,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 20,
          name = "",
          class = "",
          shape = "rectangle",
          x = 840,
          y = 0,
          width = 40,
          height = 200,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 21,
          name = "",
          class = "",
          shape = "rectangle",
          x = 960,
          y = 0,
          width = 40,
          height = 200,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 63,
          name = "",
          class = "",
          shape = "rectangle",
          x = 160,
          y = 440,
          width = 200,
          height = 40,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 64,
          name = "",
          class = "",
          shape = "rectangle",
          x = 0,
          y = 400,
          width = 160,
          height = 40,
          rotation = 0,
          visible = true,
          properties = {}
        }
      }
    },
    {
      type = "objectgroup",
      draworder = "topdown",
      id = 3,
      name = "objects",
      class = "",
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      parallaxx = 1,
      parallaxy = 1,
      properties = {},
      objects = {
        {
          id = 4,
          name = "script",
          class = "",
          shape = "rectangle",
          x = 1320,
          y = 240,
          width = 40,
          height = 200,
          rotation = 0,
          visible = true,
          properties = {
            ["cutscene"] = "room3.transition",
            ["once"] = false
          }
        },
        {
          id = 8,
          name = "transition",
          class = "",
          shape = "rectangle",
          x = 880,
          y = 40,
          width = 80,
          height = 40,
          rotation = 0,
          visible = true,
          properties = {
            ["map"] = "spamroom",
            ["marker"] = "entry"
          }
        },
        {
          id = 13,
          name = "whitedoor",
          class = "",
          shape = "point",
          x = 1160,
          y = 244,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {
            ["cond"] = "Game:getFlag(\"fun\", 0) >= 5 or Game:getFlag(\"fun\", 0) == 2"
          }
        },
        {
          id = 18,
          name = "npc",
          class = "",
          shape = "point",
          x = 620,
          y = 262,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {
            ["actor"] = "morshu",
            ["cutscene"] = "room3.morshu"
          }
        },
        {
          id = 19,
          name = "interactable",
          class = "",
          shape = "rectangle",
          x = 1000,
          y = 120,
          width = 80,
          height = 120,
          rotation = 0,
          visible = true,
          properties = {
            ["cutscene"] = "room3.spam_graffiti"
          }
        },
        {
          id = 22,
          name = "npc",
          class = "",
          shape = "point",
          x = 340,
          y = 420,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {
            ["actor"] = "doobie",
            ["cutscene"] = "room3.doobie"
          }
        },
        {
          id = 23,
          name = "setflag",
          class = "",
          shape = "rectangle",
          x = 720,
          y = 240,
          width = 40,
          height = 200,
          rotation = 0,
          visible = true,
          properties = {
            ["flag"] = "room3_doobie",
            ["once"] = true
          }
        },
        {
          id = 28,
          name = "npc",
          class = "",
          shape = "point",
          x = 840,
          y = 260,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {
            ["actor"] = "diamond_trash",
            ["cutscene"] = "room3.garbage"
          }
        },
        {
          id = 29,
          name = "npc",
          class = "",
          shape = "point",
          x = 440,
          y = 262,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {
            ["actor"] = "magolor",
            ["cutscene"] = "room3.magshop"
          }
        },
        {
          id = 43,
          name = "blackdoor",
          class = "",
          shape = "point",
          x = 1160,
          y = 244,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {
            ["cond"] = "Game:getFlag(\"fun\", 0) <= 4 and Game:getFlag(\"fun\", 0) ~= 2"
          }
        },
        {
          id = 48,
          name = "",
          class = "",
          shape = "rectangle",
          x = 970,
          y = 180,
          width = 132,
          height = 80,
          rotation = 0,
          gid = 71,
          visible = true,
          properties = {}
        },
        {
          id = 51,
          name = "npc",
          class = "",
          shape = "point",
          x = 262.236,
          y = 262,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {
            ["actor"] = "addisonshop",
            ["cutscene"] = "room3.addisonshop"
          }
        },
        {
          id = 53,
          name = "beanspot",
          class = "",
          shape = "point",
          x = 560,
          y = 400,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {
            ["inc_flag"] = "darkess_beans",
            ["name"] = "Darkess Bean"
          }
        },
        {
          id = 55,
          name = "beanspot",
          class = "",
          shape = "point",
          x = 960,
          y = 360,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {
            ["inc_flag"] = "darkess_beans",
            ["name"] = "Darkess Bean"
          }
        },
        {
          id = 56,
          name = "beanspot",
          class = "",
          shape = "point",
          x = 1200,
          y = 320,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {
            ["inc_flag"] = "darkess_beans",
            ["name"] = "Darkess Bean"
          }
        },
        {
          id = 57,
          name = "beanspot",
          class = "",
          shape = "point",
          x = 800,
          y = 400,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {
            ["inc_flag"] = "darkess_beans",
            ["name"] = "Darkess Bean"
          }
        },
        {
          id = 58,
          name = "beanspot",
          class = "",
          shape = "point",
          x = 680,
          y = 320,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {
            ["inc_flag"] = "darkess_beans",
            ["name"] = "Darkess Bean"
          }
        },
        {
          id = 59,
          name = "transition",
          class = "",
          shape = "rectangle",
          x = -20,
          y = 280,
          width = 40,
          height = 120,
          rotation = 0,
          visible = true,
          properties = {
            ["marker"] = "exit_shop",
            ["shop"] = "mousehole"
          }
        },
        {
          id = 61,
          name = "dogconegroup",
          class = "",
          shape = "rectangle",
          x = 360,
          y = 440,
          width = 40,
          height = 40,
          rotation = 0,
          visible = true,
          properties = {
            ["default_state"] = true
          }
        },
        {
          id = 62,
          name = "dogconegroup",
          class = "",
          shape = "rectangle",
          x = 400,
          y = 440,
          width = 40,
          height = 40,
          rotation = 0,
          visible = true,
          properties = {
            ["default_state"] = true
          }
        }
      }
    },
    {
      type = "objectgroup",
      draworder = "topdown",
      id = 4,
      name = "markers",
      class = "",
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      parallaxx = 1,
      parallaxy = 1,
      properties = {},
      objects = {
        {
          id = 6,
          name = "entry",
          class = "",
          shape = "point",
          x = 1280,
          y = 350,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 7,
          name = "exit_spamroom",
          class = "",
          shape = "point",
          x = 920,
          y = 120,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 12,
          name = "spawn",
          class = "",
          shape = "rectangle",
          x = 1280,
          y = 350,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 14,
          name = "exit_whitespace",
          class = "",
          shape = "point",
          x = 1160,
          y = 280,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 60,
          name = "exit_shop",
          class = "",
          shape = "point",
          x = 60,
          y = 360,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {}
        }
      }
    },
    {
      type = "objectgroup",
      draworder = "topdown",
      id = 5,
      name = "controllers",
      class = "",
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      parallaxx = 1,
      parallaxy = 1,
      properties = {},
      objects = {
        {
          id = 24,
          name = "toggle",
          class = "",
          shape = "point",
          x = 400,
          y = 360,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {
            ["flag"] = "room3_doobie",
            ["target"] = { id = 22 }
          }
        }
      }
    }
  }
}
