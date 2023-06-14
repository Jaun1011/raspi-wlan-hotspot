#!/bin/bash

# Skript zum Installieren von Dotnet Version 6.0.x auf dem Raspberry Pi
# Diese Version von Dotnet wird vorausgesetzt um das Test-Framework zu verwenden

echo "Start of the dotnet installation script."

# dotnet version 6.0.x herunterladen, entpacken und installieren
curl -sSL https://dot.net/v1/dotnet-install.sh | bash /dev/stdin --version 6.0.410

# variablen setzen
echo 'export DOTNET_ROOT=$HOME/.dotnet' >> ~/.bashrc
echo 'export PATH=$PATH:$DOTNET_ROOT:$DOTNET_ROOT/tools' >> ~/.bashrc

# libgdiplus installieren
sudo apt-get install -y libgdiplus

# reload .bashrc Einstellungen
source ~/.bashrc

# Test-Framework ausführbar machen
#sudo chmod +x FrameworkCore

# Startbefehl für das Test-Framework
#./FrameworkCore

echo "End of the dotnet installation script."
echo "Start Test-Framework via commandline: ./FrameworkCore"