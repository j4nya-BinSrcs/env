import Quickshell
import Quickshell.Hyprland
import QtQuick

// Provides the list, spacing and sizing of Hyprland workspace pills, including
// the position of the traveling active indicator.
QtObject {
  id: root

  readonly property var focused: Hyprland.focusedWorkspace

  readonly property var ids: (function() {
    const list = Hyprland.workspaces.values
      .map(w => w.id)
      .filter(id => id > 0)
      .sort((a, b) => a - b)
    return list
  })()

  readonly property int activeIdx: {
    const id = root.focused ? root.focused.id : -1
    return root.ids.indexOf(id)
  }

  property int slotH: 7
  property real spacing: 5
  property real baseSlotW: 26
  property real minSlotW: 3
  property real hPad: 10

  readonly property int count: root.ids.length

  // Pills keep a comfortable width for the first 4 workspaces, then shrink by
  // 0.75x for each additional workspace so the row never overflows the island.
  readonly property real slotW: root.count <= 4
    ? root.baseSlotW
    : Math.max(root.minSlotW, root.baseSlotW * Math.pow(0.75, root.count - 4))

  readonly property real rowW: root.count * root.slotW + (root.count - 1) * root.spacing

  readonly property real travelX: root.activeIdx >= 0
    ? root.activeIdx * (root.slotW + root.spacing) + root.slotW / 2 - root.rowW / 2
    : root.slotW / 2 - root.rowW / 2

  function switchTo(id) {
    // Newer hyprctl interprets `dispatch` as a Lua expression, so use the
    // dispatcher form instead of the legacy "workspace <id>" syntax.
    Quickshell.execDetached(["hyprctl", "dispatch", "hl.dsp.focus({ workspace = " + id + " })"])
  }
}