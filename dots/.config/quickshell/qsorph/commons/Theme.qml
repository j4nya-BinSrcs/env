pragma Singleton

import Quickshell
import QtQuick

// Central design tokens. Nothing in the shell should hardcode colors,
// fonts, radii or dimensions; always reference these so the whole UI
// can be re-themed from a single source of truth.

Singleton {
    id: root

// ---- Palettes -----------------------------------------------------------
    readonly property color bg: "#17171a"
    readonly property color surface: "#1e1e22"
    readonly property color fg: "#e6e6e9"
    readonly property color fgMuted: "#9a9aa3"
    readonly property color fgFaint: "#6a6a73"
    readonly property color accent: "#7aa2f7"
    readonly property color accentHover: "#8db1fb"
    readonly property color border: Qt.rgba(1, 1, 1, 0.08)
    readonly property color bgHover: "#202024"

// ---- Shape -----------------------------------------------------------
    readonly property int radius: 22
    readonly property int pillRadius: 22
    readonly property int pillPaddingY: 8
    readonly property int radiusInner: 12

// ---- Spacing scale -----------------------------------------------------
    readonly property int gapXs: 4
    readonly property int gapSm: 8
    readonly property int gapMd: 12
    readonly property int gapLg: 16
    readonly property int gapXl: 24

// ---- Pill / window -----------------------------------------------------
    readonly property int pillHeight: 52
    readonly property int pillPaddingX: 20
    readonly property int pillTop: 12

// ---- Typography --------------------------------------------------------
    readonly property string fontFamily: "JetBrains Mono"
    readonly property int fontSizeLg: 20
    readonly property int fontSizeMd: 16
    readonly property int fontSizeSm: 13
    readonly property int fontSizeXs: 11

// ---- Motion ------------------------------------------------------------
    readonly property int animFast: 120
    readonly property int animMed: 200
    readonly property int animSlow: 300
    // Slow, subtle glide for the pill expanding/shrinking on hover. Longer than
    // the others so the morph reads as a calm drift rather than a snap.
    readonly property int animGlide: 420
    // Easing used by animations. Stored as a string enum name: Quickshell
    readonly property string easing: "OutCubic"

// ---- Elevation ---------------------------------------------------------
    readonly property int pillBorder: 1
    readonly property real opacityInactive: 0.96
}
