#!/bin/bash
# aii = AppImage Installer
# Usage: aii install app.AppImage | aii remove appname | aii list

APPS="$HOME/Applications"
DESK="$HOME/.local/share/applications"
ICONS="$HOME/.local/share/icons/hicolor/256x256/apps"
DOWNLOADS="$HOME/Downloads"

resolve_appimage_source() {
  local src="$1"
  local matches=()

  [[ -z "$src" ]] && echo "No AppImage specified" >&2 && return 1

  # If a path is provided, use it directly.
  if [[ "$src" == */* ]]; then
    [[ -f "$src" ]] && echo "$src" && return 0
    echo "File not found: $src" >&2
    return 1
  fi

  # Otherwise look in the configured downloads folder by name, case-insensitively.
  if [[ "$src" == *.AppImage || "$src" == *.appimage ]]; then
    mapfile -t matches < <(find "$DOWNLOADS" -maxdepth 1 -type f -iname "$src" 2>/dev/null)
  else
    mapfile -t matches < <(find "$DOWNLOADS" -maxdepth 1 -type f -iname "*$src*.appimage" 2>/dev/null)
  fi

  case "${#matches[@]}" in
    0)
      echo "No matching AppImage found in $DOWNLOADS for: $src" >&2
      return 1
      ;;
    1)
      echo "${matches[0]}"
      ;;
    *)
      echo "Multiple AppImages found in $DOWNLOADS. Specify the path:" >&2
      printf '  %s\n' "${matches[@]}" >&2
      return 1
      ;;
  esac
}

ensure_dirs() {
  mkdir -p "$APPS" "$DESK" "$ICONS"
}

remove_appimage_files() {
  local appname="$1"
  find "$APPS" -maxdepth 1 -type f -iname "${appname}*.appimage" -delete 2>/dev/null
}

list_download_appimages() {
  local files=()
  mapfile -t files < <(find "$DOWNLOADS" -maxdepth 1 -type f -iname "*.appimage" 2>/dev/null | sort)

  if [[ "${#files[@]}" -eq 0 ]]; then
    echo "No AppImages found in $DOWNLOADS"
    return 0
  fi

  echo "📥 AppImages available in $DOWNLOADS:"
  printf '  %s\n' "${files[@]##*/}"
}

show_help() {
  echo "Usage:"
  echo "  aii install app.AppImage   → install & add to launcher"
  echo "  aii install obs            → find matching AppImage in $DOWNLOADS"
  echo "  aii update  app.AppImage   → replace old version"
  echo "  aii update  obs            → find matching AppImage in $DOWNLOADS"
  echo "  aii remove  appname        → uninstall"
  echo "  aii list                   → show installed apps"
  echo "  aii q                      → show AppImages available in $DOWNLOADS"
  echo "  aii help                   → show this help"
}

case "$1" in

  install)
    SRC=$(resolve_appimage_source "$2") || exit 1

    FNAME=$(basename "$SRC")
    APPNAME=$(echo "$FNAME" | sed 's/[-_ ].*//' | tr '[:upper:]' '[:lower:]')
    DEST="$APPS/$FNAME"

    # Move & make executable
    ensure_dirs || exit 1
    cp "$SRC" "$DEST" || exit 1
    chmod +x "$DEST" || exit 1

    # Extract desktop + icon from inside the AppImage
    cd /tmp && rm -rf squashfs-root
    "$DEST" --appimage-extract '*.desktop' 2>/dev/null
    "$DEST" --appimage-extract '*.png'     2>/dev/null
    "$DEST" --appimage-extract '*.svg'     2>/dev/null
    "$DEST" --appimage-extract '.DirIcon'  2>/dev/null

    # Copy icon. Use regular files only; some AppImages expose broken symlinks here.
    ICON=$(find /tmp/squashfs-root -type f \( -iname "*.png" -o -iname "*.svg" -o -name ".DirIcon" \) 2>/dev/null | head -1)
    if [[ -n "$ICON" ]]; then
      if [[ "${ICON,,}" == *.svg ]]; then
        cp "$ICON" "$ICONS/$APPNAME.svg"
      else
        cp "$ICON" "$ICONS/$APPNAME.png"
      fi
    fi

    # Fix & copy desktop entry. Use regular files only; symlink targets may not be extracted.
    DFILE=$(find /tmp/squashfs-root -type f -name "*.desktop" 2>/dev/null | head -1)
    if [[ -n "$DFILE" ]]; then
      sed -i "s|Exec=.*|Exec=$DEST %U|" "$DFILE" || exit 1
      sed -i "s|Icon=.*|Icon=$APPNAME|"  "$DFILE" || exit 1
      cp "$DFILE" "$DESK/$APPNAME.desktop" || exit 1
    else
      # Fallback: create a basic desktop entry
      cat > "$DESK/$APPNAME.desktop" <<EOF
[Desktop Entry]
Name=$APPNAME
Exec=$DEST %U
Icon=$APPNAME
Type=Application
Categories=Utility;
EOF
    fi

    update-desktop-database "$DESK"
    rm -rf /tmp/squashfs-root
    echo "✅ Installed: $APPNAME → $DEST"
    ;;

  update)
    SRC=$(resolve_appimage_source "$2") || exit 1

    FNAME=$(basename "$SRC")
    APPNAME=$(echo "$FNAME" | sed 's/[-_ ].*//' | tr '[:upper:]' '[:lower:]')

    # Remove old version, case-insensitively
    remove_appimage_files "$APPNAME"

    # Re-use install logic
    "$0" install "$SRC"
    echo "🔄 Updated: $APPNAME"
    ;;

  remove)
    APPNAME="$2"
    remove_appimage_files "$APPNAME"
    rm -f "$DESK/$APPNAME.desktop" \
          "$ICONS/$APPNAME.png"
    update-desktop-database "$DESK"
    echo "🗑️  Removed: $APPNAME"
    ;;

  list)
    echo "📦 Installed AppImages:"
    ls "$APPS"/*.{AppImage,appimage} 2>/dev/null | xargs -I{} basename {}
    ;;

  q)
    list_download_appimages
    ;;

  help|-h|--help)
    show_help
    ;;

  *)
    show_help
    ;;
esac
