# KWin Rules: Fixing App Behavior

Using this tool, you can fix some app behavior.

The config file is located at:  
`~/.config/kwinrulesrc`

---

## Fullscreen Some Apps

### Firefox

```ini
[99137bf3-b420-4854-ab39-dcf4ce4fe8bd]
Description=firefox
maximizehoriz=true
maximizehorizrule=3
maximizevert=true
maximizevertrule=3
types=1
wmclass=firefox
wmclassmatch=1
```

---

### Haruna Video Player

```ini
[2b4cce63-63a4-4fdf-8411-d8255f60e758]
Description=Haruna Fullscreen
maximizehoriz=true
maximizehorizrule=3
maximizevert=true
maximizevertrule=3
types=1
wmclass=haruna
wmclasscomplete=true
wmclassmatch=2
```

---

### Thunderbird

```ini
[1c5d0e01-4366-4566-847a-225ba9c09519]
Description=thunderbird
maximizehoriz=true
maximizehorizrule=3
maximizevert=true
maximizevertrule=3
types=1
wmclass=thunderbird
wmclassmatch=1
```

---

### Dolphin File Manager

```ini
[11448a0f-19e9-41b6-b038-ac69f37a3fe9]
Description=dolphin
maximizehoriz=true
maximizehorizrule=3
maximizevert=true
maximizevertrule=3
types=1
wmclass=dolphin
wmclassmatch=1
```

---

### Kate Editor

```ini
[5a577c79-3c5a-4fd5-97c1-fec726abb511]
Description=kate
maximizehoriz=true
maximizehorizrule=3
maximizevert=true
maximizevertrule=3
types=1
wmclass=kate
wmclassmatch=1
```

---

### COSMIC Term

```ini
[804f4c6f-6525-4c60-ade1-6c40a6cd08aa]
Description=COSMIC-Term fullscreen
maximizehoriz=true
maximizehorizrule=3
maximizevert=true
maximizevertrule=3
types=1
wmclass=com.system76.CosmicTerm
wmclassmatch=1
```

---

## Fix COSMIC Terminal

By default, it shows a **"winit"** window with no content. You can hide it easily from the panel.

```ini
[336d0b17-c70b-4f6f-8a89-e825f0aaf410]
Description=COSMIC Term hide
skiptaskbar=true
skiptaskbarrule=2
title=winit window
titlematch=1
types=1
wmclass=COSMIC Terminal
```

---

## Pin Tray Popup Windows to the Corner

Popup windows like **Nextcloud** or your **VPN** should not appear in the middle of the screen.

Currently, my rule is broken when using multiple monitors, but the idea is:

```ini
[390bea6c-c956-417a-91a0-5f45bc46b1f0]
Description=nextcloud
position=1085,244
positionrule=3
wmclass=nextcloud
wmclassmatch=2
```