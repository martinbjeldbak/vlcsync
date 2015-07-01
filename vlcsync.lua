-- vlcsync.lua -- VLC extension to sync playback between friends --
--[[
INSTALLATION:
Put the file in the VLC subdir /lua/extensions, by default:
* Windows (all users): %ProgramFiles%\VideoLAN\VLC\lua\extensions\
* Windows (current user): %APPDATA%\VLC\lua\extensions\
* Linux (all users): /usr/share/vlc/lua/extensions/
* Linux (current user): ~/.local/share/vlc/lua/extensions/
* Mac OS X (all users): /Applications/VLC.app/Contents/MacOS/share/lua/extensions/
(create directories if they don't exist)
Restart the VLC.
Then you simply use the extension by going to the "View" menu and selecting it.
--]]

-- VLC callbacks
function descriptor()
  return {
    title = "VLC Sync",
    version = "0.0.1",
    author = "Martin Bjeldbak Madsen",
    url = "https://github.com/martinbjeldbak/vlcsync",
    shortdesc = "VLCSync",
    description = "Sync VLC playback with your friends!",
    capabilities = {"menu", "input-listener", "playing-listener"}
  }
end

-- Called when extension is activated
function activate()
  dbg("Starting")

  if vlc.input.is_playing() then
    dbg("Content playing")
  else
    dbg("Content NOT playing")
  end
end

-- Called when extension is deactivated (i.e. done executing)
function deactivate()
  dbg("Shutting down!")
end

-- called when user clicks "x" at top right
function close()
   vlc.deactivate()
end

function input_changed()
  -- triggered by Start/Stop media input event
  dbg("Input changed")
  return false
end

function playing_changed()
  -- should fire on play/pause but doesn't (at least on OS X 2.2.1
end

-- UTILITY FUNCTIONS

function dbg(msg)
  vlc.msg.warn("[VLCSync] " .. msg)
end

-- Print a table to VLC debug
function tprint(tbl, indent)
  if not indent then indent = 0 end
  for k, v in pairs(tbl) do
    formatting = string.rep("  ", indent) .. k .. ": "
    if type(v) == "table" then
      dbg(formatting)
      tprint(v, indent+1)
    elseif type(v) == 'boolean' then
      dbg(formatting .. tostring(v))
    else
      dbg(formatting .. v)
    end
  end
end

function elasped_time()
  vcl.var.get(vlc.object.input(), "time")
end

function jump_to_min(min)
  jump_to_sec(min * 60)
end

function jump_to_min_sec(min, sec)
  jump_to_sec(min * 60 + sec)
end

function jump_to_sec(num_sec)
  vlc.var.set(vlc.object.input(), "time", num_sec)
end

function pause()
  dbg("Shutting down")
  vlc.playlist.pause()
end
