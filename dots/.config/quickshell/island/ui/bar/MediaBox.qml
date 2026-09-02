import QtQuick
import QtQuick.Layouts

// Left section: now-playing artwork, title and artist.
RowLayout {
  id: root

  property var media: null
  property var theme: null
  property bool extended: true

  spacing: 14
  opacity: root.extended ? 1 : 0
  Behavior on opacity {
    NumberAnimation { duration: 200; easing.type: Easing.OutCubic }
  }

  Rectangle {
    implicitWidth: 56
    implicitHeight: 56
    radius: 10
    color: "#1a1a20"

    Image {
      anchors.fill: parent
      source: root.media.artUrl
      fillMode: Image.PreserveAspectCrop
      antialiasing: true
      smooth: true
      clip: true
      visible: root.media.artUrl !== ""
    }
    Text {
      anchors.centerIn: parent
      text: "♫"
      color: root.theme.mutedColor
      font { family: root.theme.fontFamily; pixelSize: 22 }
      visible: root.media.artUrl === ""
    }
  }

  Column {
    Layout.alignment: Qt.AlignVCenter
    spacing: 3
    Text {
      text: root.media.player?.trackTitle ?? "Nothing playing"
      color: root.theme.textColor
      font { family: root.theme.fontFamily; pixelSize: 13; weight: Font.DemiBold }
      elide: Text.ElideRight
      width: 100
    }
    Text {
      text: root.media.player?.trackArtist ?? "No media"
      color: root.theme.mutedColor
      font { family: root.theme.fontFamily; pixelSize: 11 }
      elide: Text.ElideRight
      width: 100
    }
  }
}