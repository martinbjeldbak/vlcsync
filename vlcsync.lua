function descriptor()
  return {
    title = "VLC Sync",
    version = "0.0.1",
    author = "Martin Bjeldbak Madsen",
    url = "http://martinbmadsen.dk",
    shortdesc = "VLCSync",
    description = "Sync VLC playback with your friends!",
    capabilities = {"menu", "input-listener"}
  }
end

function activate()
  vlc.msg.dbg("[VLCsync] Welcome")
end

function deactivate()
  vlc.msg.dbg("[VLCsync] Shutting down!")
end
