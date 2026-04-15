# RiceARCH 🪐

Bem-vindo ao **RiceARCH**! Este repositório contém meus dotfiles e configurações pessoais para o Arch Linux (ou outras distribuições), focados em produtividade e estética.

## O que está incluso?
* **Gerenciador de Janelas:** Hyprland (0.53+)
* **Barra de Status:** Waybar
* **Terminal:** Kitty + Zsh
* **Prompt:** Starship
* **Lockscreen & Wallpaper:** Hyprlock & Hyprpaper
* **Cores/Tema:** Tema Saturno (tons escuros com detalhes em bronze e ciano)

## Como Instalar
Basta clonar este repositório e executar o script de instalação automatizado:

```bash
git clone https://github.com/glwydson/RiceARCH.git
cd RiceARCH
chmod +x install.sh
./install.sh
```

> **Nota:** Certifique-se de fazer backup dos seus arquivos originais antes de rodar o instalador!

## Estrutura do Projeto
```
RiceARCH/
├── config/
│   ├── hypr/
│   │   ├── hyprland.conf
│   │   ├── hyprlock.conf
│   │   └── hyprpaper.conf
│   ├── waybar/
│   │   ├── config.jsonc
│   │   └── style.css
│   └── starship.toml
├── home/
│   └── .zshrc
├── install.sh
└── README.md
```
