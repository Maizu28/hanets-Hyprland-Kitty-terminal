#!/bin/bash

# --- Variabel Lokasi ---
DOTFILES_DIR=$(pwd)
CONFIG_DIR="$HOME/.config"

echo "🌸 Memulai instalasi dotfiles Kaoruko Waguri by hanets..."

# --- Membuat folder .config jika belum ada ---
mkdir -p "$CONFIG_DIR"

# --- 1. Cek & Install Starship ---
if ! command -v starship &> /dev/null; then
    echo "🚀 Starship tidak ditemukan. Mengunduh dan menginstall..."
    # Menggunakan script resmi starship.rs
    curl -sS https://starship.rs/install.sh | sh -s -- -y
else
    echo "✅ Starship sudah terinstall."
fi

# --- 2. Membuat folder .config jika belum ada ---
mkdir -p "$CONFIG_DIR"

# --- 3. Fungsi untuk membuat Symlink ---
link_file() {
    local src="$DOTFILES_DIR/$1"
    local dest="$2"

    if [ -e "$dest" ] || [ -L "$dest" ]; then
        echo "🔄 Menghapus config lama: $dest"
        rm -rf "$dest"
    fi

    echo "🔗 Menautkan: $1 -> $dest"
    ln -s "$src" "$dest"
} ln -s "$src" "$dest"
}

# --- Eksekusi Penautan (Berdasarkan Folder Kamu) ---

# 1. Folder di dalam .config
link_file "fastfetch" "$CONFIG_DIR/fastfetch"
link_file "hypr" "$CONFIG_DIR/hypr"
link_file "kitty" "$CONFIG_DIR/kitty"
link_file "starship.toml" "$CONFIG_DIR"

# 2. Folder Asset (Wallpaper & Theme)
link_file "theme-custom" "$HOME/Pictures/theme-custom"
link_file "wallpapers" "$HOME/Pictures/wallpapers"

# 3. File di Home Directory
link_file ".zshrc" "$HOME/.zshrc"

echo "✅ Selesai! Semua config telah ditautkan."
echo "Silakan restart terminal atau ketik 'source ~/.zshrc' untuk melihat perubahan."
