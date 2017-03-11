# sigmoid Gentoo Overlay

This is just to experiment with Gentoo Ebuilds and add sometimes missing or newer versions of packages.

## How to use this overlay

You definately want to install layman:
```
emerge -av app-portage/layman
```

To add this overlay to your Gentoo:
```
layman -f -o https://raw.githubusercontent.com/sigmoidal/gentoo-overlay/master/overlay.xml -a sigmoid
```
