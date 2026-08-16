<img align="left" alt="Project logo" src="data/icons/hicolor/scalable/apps/app.svg" />

# Muzika
Play your music elegantly.

Muzika is a light weight music player written in GTK4, focuses on large music collection.

## Features
- TBA

## FreeBSD Dependencies

```bash
pkg install vala meson libadwaita gstreamer1-plugins-all gettext gtk4
```

## How to build 
It is written in Vala, simple and clean code, with few third-party dependencies:

1. Clone the code from GitHub.
2. Install vala, develop packages of gtk4, libadwaita, gstreamer.
3. Run in the project directory:

    `meson setup build --buildtype=release`

    `meson install -C build`

## Change Log
Check the [release tags](https://github.com/TERRsalt/Muzika/-/tags) for change log.
