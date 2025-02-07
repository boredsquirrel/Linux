## KDE is awesome!

Here are some things that make it better for certain use cases.

## Dolphin

### Service Menus
If you know the syntax, you can create many useful right-click actions for Dolphin.

Just download a service menu (`.desktop`) file to `~/.local/share/kservices5/ServiceMenus/`, and it will work!

### App Desktop Entries
Desktop entries are the graphical icons with text used to launch applications.

Create your own in `~/.local/share/applications/`, and [follow this syntax](https://specifications.freedesktop.org/desktop-entry-spec/desktop-entry-spec-latest.html).

These entries take priority over system and Flatpak entries, so if you want to customize applications, edit them here!

Examples:
- [Custom Konsole entry](https://lemmy.kde.social/post/947963) with actions for Distrobox, root shell, and SSH
- Custom Firefox entry (coming soon)

#### Konsole Example:
```ini
[Desktop Entry]
Type=Application
TryExec=konsole
Exec=konsole --new-tab
Icon=utilities-terminal
Categories=System;TerminalEmulator;
Actions=FedoraBox;root;ssh;
X-DocPath=konsole/index.html
X-DBUS-StartupType=Unique
X-KDE-AuthorizeAction=shell_access
X-KDE-Shortcuts=Ctrl+Alt+T
StartupWMClass=konsole
Keywords=terminal;console
Name=Konsole
GenericName=Terminal
Comment=$GenericName

[Desktop Action FedoraBox]
Name=Distrobox
Icon=fedora-logo-icon
Exec=konsole --profile FedoraBox # Launches "distrobox enter FedoraBox"

[Desktop Action root]
Name=Root Terminal
Icon=folder-root-symbolic
Exec=konsole -e pkexec $SHELL # Define a shell if needed

[Desktop Action ssh]
Name=SSH to X
Icon=folder-remote-symbolic
Exec=konsole -e ssh user@IP -p PORT -i /path/to/key
```

### SDDM Themes
There are many great SDDM themes available, but SDDM requires them to be placed in a `/usr` directory, which is not writable on Fedora Atomic and other "immutable" distributions. 

You can use [sddm2rpm](https://github.com/Lunarequest/sddm2rpm) ([crate](https://crates.io/crates/sddm2rpm)) to convert theme files into RPM packages that can be layered!