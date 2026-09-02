import Quickshell
import Quickshell.Services.Mpris
import QtQuick
import QtQml.Models

// Tracks the currently active MPRIS player and its album art.
Item {
  id: root
  visible: false

  property var player: null
  readonly property string artUrl: player?.trackArtUrl ?? ""

  function pick() {
    root.player = null
    const players = Mpris.players.values
    for (let i = 0; i < players.length; ++i) {
      if (players[i].playbackState === MprisPlaybackState.Playing) {
        root.player = players[i]
        return
      }
    }
    if (players.length > 0)
      root.player = players[0]
  }

  Instantiator {
    model: Mpris.players
    Connections {
      required property var modelData
      target: modelData
      Component.onCompleted: root.pick()
      Component.onDestruction: root.pick()
      function onPlaybackStateChanged() { root.pick() }
    }
  }
}