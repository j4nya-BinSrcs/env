import Quickshell
import QtQuick
import QtQuick.Layouts

import Quickshell.Services.Mpris

PanelWindow {
    id: bar

    anchors {top: true; right: true; left: true}
    margins {top: 10; left: 20; right: 20}

    implicitHeight: 32
    color: "transparent"

    Poller {
        id: clock
        command: "date +%H:%M"
        interval: 60000
    }

    Poller {
        id: volume
        command: "wpctl get-volume @DEFAULT_AUDIO_SINK | awk '{printf\"%d\", $2*100}'"
        interval: 1000
    }

    Poller {
        id: bat
        command: "cat /sys/class/power_supply/BAT0/capacity"
        interval: 30000
    }

    Poller {
        id: ba
        command: "bluetoothctl show | grep -g 'Powered: yes' && echo on || echo off"
        interval: 5000
    }

    Poller {
        id: net
        command: "nmcli -t -f NAME connection show --active | head -n1"
        interval: 5000
    }


    readonly property var player: Mpris.players.value.find(p => p.isPlaying) ?? Mpris.players.value[0] ?? null

    RowLayout {
        anchors.left: parent.left
        anchors.verticalCenter: parent.verticalCenter
        anchors.leftMargin: 14
        spacing: 8

        Pill {
            icon: "music_note"
            maxLabelWidth: 200
            label: bar.player ? `${bar.player.trackArtist || "Unknown"} - ${bar.player.trackTitle || ""}` : "Nothing Playing"
        }
    }

    RowLayout {
        id: centerGroup

        anchors.centerIn: parent
        spacing: 8

        Pill {icon: "nest_clock_farsight_analog"; label: clock.value}
        Workspaces{}
    }

    RowLayout {
        anchors.right: parent.right
        anchors.verticalCenter: parent.verticalCenter
        anchors.rightMargin: 14
        spacing: 8

        Pill { icon: "volume_up"; label: vol.value + "%"; iconColor: "#ffffff"}
        Pill { icon: "battery_android_full"; label: bat.value + "%"; iconColor: "#ffffff"}
        Pill { icon: "bluetooth"; label: bt.value; iconColor: "#ffffff"}
        Pill { icon: "android_wifi_3_bar"; label: net.value; iconColor: "#ffffff"}

    }
}
