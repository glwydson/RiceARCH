#!/bin/bash

echo "🪐 Iniciando a instalação do RiceARCH..."

# ─── Pacotes oficiais (pacman) ───
PACMAN_PKGS=(
    # Hyprland & ecossistema
    hyprland
    hyprlock
    hyprpaper
    xdg-desktop-portal-hyprland

    # Barra, launcher e notificações
    waybar
    wofi

    # Terminal & shell
    kitty
    zsh
    starship
    fzf
    zsh-autosuggestions
    zsh-syntax-highlighting

    # Fonte (usada no hyprlock e waybar)
    ttf-jetbrains-mono-nerd

    # Screenshot & clipboard
    grim
    slurp
    wl-clipboard

    # Áudio & brilho
    wireplumber
    pavucontrol
    brightnessctl

    # Rede & Bluetooth
    networkmanager
    blueman

    # Energia
    power-profiles-daemon

    # Gerenciador de arquivos
    nemo

    # Navegador
    firefox

    # Temas GTK/Qt
    adw-gtk3
    qt6ct

    # Wallpaper fallback (usado no exec-once)
    swaybg
)

# ─── Pacotes AUR (yay/paru) ───
AUR_PKGS=(
    hyprlauncher
    visual-studio-code-bin
    zen-browser-bin
    obsidian-bin
)

# ─── Flatpak (opcional) ───
FLATPAK_PKGS=(
    com.spotify.Client
)

install_pacman() {
    echo ""
    echo "📦 Instalando pacotes oficiais com pacman..."
    sudo pacman -S --needed --noconfirm "${PACMAN_PKGS[@]}"
}

install_aur() {
    echo ""
    echo "📦 Instalando pacotes do AUR..."
    if command -v yay &> /dev/null; then
        yay -S --needed --noconfirm "${AUR_PKGS[@]}"
    elif command -v paru &> /dev/null; then
        paru -S --needed --noconfirm "${AUR_PKGS[@]}"
    else
        echo "⚠️  Nenhum AUR helper encontrado (yay/paru)."
        echo "   Instale um deles primeiro: sudo pacman -S --needed git base-devel && git clone https://aur.archlinux.org/yay.git && cd yay && makepkg -si"
        echo "   Pacotes AUR pendentes: ${AUR_PKGS[*]}"
        return 1
    fi
}

install_flatpak() {
    echo ""
    echo "📦 Instalando apps Flatpak..."
    if command -v flatpak &> /dev/null; then
        for pkg in "${FLATPAK_PKGS[@]}"; do
            flatpak install -y flathub "$pkg" 2>/dev/null || echo "⚠️  Falha ao instalar $pkg"
        done
    else
        echo "⚠️  Flatpak não encontrado. Instale com: sudo pacman -S flatpak"
        echo "   Pacotes pendentes: ${FLATPAK_PKGS[*]}"
    fi
}

# ─── Menu de instalação ───
echo ""
echo "Dependências detectadas:"
echo "  • Pacman (${#PACMAN_PKGS[@]} pacotes): hyprland, waybar, kitty, zsh, grim, etc."
echo "  • AUR    (${#AUR_PKGS[@]} pacotes): hyprlauncher, vscode, zen-browser, obsidian"
echo "  • Flatpak (${#FLATPAK_PKGS[@]} pacotes): Spotify"
echo ""

read -p "Instalar pacotes oficiais (pacman)? [S/n] " r1
r1=${r1:-S}
[[ "$r1" =~ ^[Ss]$ ]] && install_pacman

read -p "Instalar pacotes do AUR (yay/paru)? [S/n] " r2
r2=${r2:-S}
[[ "$r2" =~ ^[Ss]$ ]] && install_aur

read -p "Instalar apps Flatpak (Spotify)? [S/n] " r3
r3=${r3:-S}
[[ "$r3" =~ ^[Ss]$ ]] && install_flatpak

# Cria os diretórios de destino caso não existam
mkdir -p ~/.config/hypr
mkdir -p ~/.config/waybar

# Fazendo backup dos arquivos antigos
echo "Criando backups com extensão .bak..."
[ -f ~/.zshrc ] && cp ~/.zshrc ~/.zshrc.bak
[ -f ~/.config/starship.toml ] && cp ~/.config/starship.toml ~/.config/starship.toml.bak
[ -d ~/.config/hypr ] && cp -r ~/.config/hypr ~/.config/hypr.bak 2>/dev/null
[ -d ~/.config/waybar ] && cp -r ~/.config/waybar ~/.config/waybar.bak 2>/dev/null

# Copiando as configurações
echo "Aplicando as novas configurações..."

# Copia tudo de config/ para ~/.config/
cp -r config/* ~/.config/

# Copia os wallpapers
mkdir -p ~/wallpapers
cp -r wallpapers/* ~/wallpapers/
echo "Wallpapers copiados para ~/wallpapers/"

# Copia os arquivos da home para ~/
cp -a home/. ~/

echo "------------------------------------------------------"
echo "✅ Instalação concluída com sucesso! 🎉"
echo "Por favor, reinicie sua sessão do Hyprland para aplicar as mudanças."
