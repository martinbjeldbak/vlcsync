-- VLC callbacks

function descriptor()
  return {
    title = "VLC Sync",
    version = "0.0.1",
    author = "Martin Bjeldbak Madsen",
    url = "http://martinbmadsen.dk",
    shortdesc = "VLCSync",
    description = "Sync VLC playback with your friends!",
    -- capabilities = {"menu", "input-listener", "playing-listener"}
    capabilities = {"input-listener", "meta-listener", "playing-listener"}
  }
end

function activate()
  -- extension starts
  dbg("Welcome")

  if vlc.input.is_playing() then
    dbg("Content playing")
    item = vlc.input.item()
    -- tprint(vlc.input.item().metas(item))
    input = vlc.object.input()
    jump_to(1800)
  else
    dbg("Content NOT playing")
  end
end


function deactivate()
  -- extension stops
  dbg("Shutting down!")
end

function close()
   -- function triggered on dialog box close event
   -- for example to deactivate extension on dialog box close:
   vlc.deactivate()
end

function meta_changed()
  dbg("testing")
end

function input_changed()
  -- triggered by Start/Stop media input event
  return false
end

function playing_changed()
  dbg("playing changed")
  vlc.osd.message("Status:" .. tostring(stat))
end

function meta_changed()
   -- related to capabilities={"meta-listener"} in descriptor()
   -- triggered by available media input meta data?
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

function jump_to_sec(num_sec)
  vlc.var.set(vlc.object.input(), "time", num_sec)
end

function pause()
  vlc.playlist.pause()
end
