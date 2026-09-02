import QtQuick
import QtQuick.Layouts

import qs.ui.base

// The full control center shown when the island is expanded into panel mode:
// quick toggles, volume/brightness sliders and recent notifications.
Item {
  id: root

  property var theme: null
  property var wifi: null
  property var bluetooth: null
  property var sound: null
  property var backlight: null
  property var nightlight: null
  property var battery: null
  property var caffeine: null
  property var notifications: null

  signal closed()

  Column {
    anchors.fill: parent
    anchors.margins: 12
    spacing: 8

    // ----------------------------------------------------------------- header
    RowLayout {
      width: parent.width
      spacing: 8

      Text {
        text: "⚙ Control Center"
        color: root.theme.textColor
        font { family: root.theme.fontFamily; pixelSize: 12; weight: Font.DemiBold }
      }
      Item { Layout.fillWidth: true }
      Rectangle {
        width: 24
        height: 24
        radius: 7
        color: Qt.rgba(1, 1, 1, 0.1)

        Text {
          anchors.centerIn: parent
          text: "✕"
          color: root.theme.textColor
          font { family: root.theme.fontFamily; pixelSize: 10 }
        }
        MouseArea {
          anchors.fill: parent
          onClicked: root.closed()
        }
      }
    }

    // ---------------------------------------------------- quick-toggle tiles
    RowLayout {
      width: parent.width
      spacing: 8

      PanelTile {
        Layout.fillWidth: true
        theme: root.theme
        icon: "📶"
        label: "Wi-Fi"
        subtext: root.wifi.enabled ? (root.wifi.ssid || "On") : "Off"
        checked: root.wifi.enabled
        onToggled: root.wifi.toggle()
      }
      PanelTile {
        Layout.fillWidth: true
        theme: root.theme
        icon: "🧿"
        label: "Bluetooth"
        subtext: root.bluetooth.enabled ? root.bluetooth.connectedCount + " connected" : "Off"
        checked: root.bluetooth.enabled
        onToggled: root.bluetooth.toggle()
      }
      PanelTile {
        Layout.fillWidth: true
        theme: root.theme
        icon: "🌙"
        label: "Nightlight"
        subtext: root.nightlight.on ? "On" : "Off"
        checked: root.nightlight.on
        onToggled: root.nightlight.toggle()
      }
      PanelTile {
        Layout.fillWidth: true
        theme: root.theme
        icon: "🔕"
        label: "DND"
        subtext: root.notifications.dnd ? "On" : "Off"
        checked: root.notifications.dnd
        onToggled: root.notifications.toggleDnd()
      }
    }

    RowLayout {
      width: parent.width
      spacing: 8

      PanelTile {
        Layout.fillWidth: true
        theme: root.theme
        icon: "☕"
        label: "Caffeine"
        subtext: root.caffeine.on ? "Awake" : "Sleep"
        checked: root.caffeine.on
        onToggled: root.caffeine.toggle()
      }
      PanelTile {
        Layout.fillWidth: true
        theme: root.theme
        toggleable: false
        icon: root.battery.charging ? "🔌" : "🔋"
        label: "Battery"
        subtext: root.battery.percent + "%"
      }
      PanelTile {
        Layout.fillWidth: true
        theme: root.theme
        toggleable: false
        icon: root.sound.muted ? "🔇" : "🔊"
        label: "Sound"
        subtext: root.sound.muted ? "Muted" : Math.round(root.sound.volume * 100) + "%"
      }
      PanelTile {
        Layout.fillWidth: true
        theme: root.theme
        toggleable: false
        icon: "☀️"
        label: "Display"
        subtext: Math.round(root.backlight.level * 100) + "%"
      }
    }

    // ---------------------------------------------------------------- sliders
    Column {
      width: parent.width
      spacing: 6

      RowLayout {
        width: parent.width
        spacing: 8

        Text {
          text: root.sound.muted ? "🔇" : "🔊"
          color: root.theme.textColor
          font { pixelSize: 11 }
        }
        CustomSlider {
          Layout.fillWidth: true
          value: root.sound.volume
          accent: root.theme.accentColor
          textColor: root.theme.textColor
          onCommitted: root.sound.setVolume(v)
        }
        Rectangle {
          width: 54
          height: 20
          radius: 10
          color: root.sound.muted
            ? Qt.rgba(root.theme.accentColor.r, root.theme.accentColor.g, root.theme.accentColor.b, 0.35)
            : Qt.rgba(1, 1, 1, 0.1)

          Text {
            anchors.centerIn: parent
            text: root.sound.muted ? "Unmute" : "Mute"
            color: root.theme.textColor
            font { family: root.theme.fontFamily; pixelSize: 8 }
          }
          MouseArea {
            anchors.fill: parent
            onClicked: root.sound.toggleMute()
          }
        }
      }

      RowLayout {
        width: parent.width
        spacing: 8

        Text {
          text: "☀️"
          color: root.theme.textColor
          font { pixelSize: 11 }
        }
        CustomSlider {
          Layout.fillWidth: true
          value: root.backlight.level
          accent: root.theme.accentColor
          textColor: root.theme.textColor
          onCommitted: root.backlight.applyLevel(v)
        }
      }
    }

    // ----------------------------------------------------------- notifications
    Column {
      width: parent.width
      spacing: 4

      Text {
        text: "Notifications"
        color: root.theme.textColor
        font { family: root.theme.fontFamily; pixelSize: 10; weight: Font.DemiBold }
      }

      Rectangle {
        width: parent.width
        height: 44
        radius: 10
        color: Qt.rgba(1, 1, 1, 0.05)
        visible: root.notifications.recent.length === 0

        Text {
          anchors.centerIn: parent
          text: root.notifications.dnd ? "Do not disturb — notifications hidden" : "No notifications"
          color: root.theme.mutedColor
          font { family: root.theme.fontFamily; pixelSize: 9 }
        }
      }

      ListView {
        width: parent.width
        height: 84
        clip: true
        spacing: 4
        visible: root.notifications.recent.length > 0
        model: root.notifications.recent

        delegate: Rectangle {
          required property var modelData
          readonly property var n: modelData

          width: ListView.view.width
          height: 40
          radius: 9
          color: Qt.rgba(1, 1, 1, 0.05)

          RowLayout {
            anchors.fill: parent
            anchors.margins: 8
            spacing: 8

            Column {
              Layout.fillWidth: true
              spacing: 1

              Text {
                text: n.appName || "Notification"
                width: parent.width
                elide: Text.ElideRight
                color: root.theme.textColor
                font { family: root.theme.fontFamily; pixelSize: 8; weight: Font.DemiBold }
              }
              Text {
                text: n.summary + (n.body ? " — " + n.body : "")
                width: parent.width
                elide: Text.ElideRight
                color: root.theme.mutedColor
                font { family: root.theme.fontFamily; pixelSize: 8 }
              }
            }
            Rectangle {
              width: 16
              height: 16
              radius: 8
              color: Qt.rgba(1, 1, 1, 0.1)

              Text {
                anchors.centerIn: parent
                text: "✕"
                color: root.theme.mutedColor
                font { family: root.theme.fontFamily; pixelSize: 7 }
              }
              MouseArea {
                anchors.fill: parent
                onClicked: root.notifications.dismiss(n)
              }
            }
          }
        }
      }
    }
  }
}