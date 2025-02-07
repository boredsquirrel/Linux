## KDE is awesome

Here are some things that make it better for certain use cases.

## Dolphin

### Service Menus

If you know the syntax, you can create lots of useful right-click actions for
Dolphin.

Just download a service menu (`.desktop`) to the folder
`~/.local/share/kservices5/ServiceMenus/`, and it will work!

### App Desktop Entries

Desktop entries are the graphical icons with text for running apps.

Create your own in `~/.local/share/applications/`, and [follow this
syntax](<<https://specifications.freedesktop.org/desktop-entry-spec/desktop-entry>
->
spec-latest.html).

These entries are preferred over system and Flatpak entries, so if you want to
edit apps, do it there!

Examples:

- [Custom Konsole entry](https://lemmy.kde.social/post/947963) with actions for
Distrobox, root shell, and SSH.
- Custom Firefox entry (coming soon).

#### Konsole Example

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
Comment="$GenericName"

[Desktop Action FedoraBox]
Name=Distrobox
Icon=fedora-logo-icon
Exec=konsole --profile FedoraBox # this launches "distrobox enter FedoraBox"

[Desktop Action root]
Name=root Terminal
Icon=folder-root-symbolic
Exec=konsole -e pkexec $SHELL # or define a shell

[Desktop Action ssh]
Name=ssh to X
Icon=folder-remote-symbolic
Exec=konsole -e ssh user@IP:PORT -i /path/to/key
