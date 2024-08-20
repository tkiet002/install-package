#!/bin/bash


if [[ "$1" = "-help" || "$1" = "-h" ]]; then
  echo "-h or -help : Listing all command"
  echo "-l or -list : Listing all package will be install by default or by optional"
fi

if [[ "$1" = "-l"  ]]; then
  echo "The following package will be install."
  echo "1. Firefox ESR" 
  echo "2. C/C++ Development related package"
  echo "3. Krita"
  echo "4. Blender"
  echo "5. Emacs"
  echo "6. Neovim"
  echo "7. Helix"
  echo " "
  echo "Then there is some optional package behind like: Zig, Rust, npm, VSCode"
fi

echo "Want to isntall package? (y = 1 = YES // n = 0 = NO)"
read input
if [[ $input = 1 || $input = "y" ]]; then
  echo "Update your package..."
  sudo apt update
  echo "Installing package...."
  echo "Set-up your C/C++ Development"
  echo "Running installation..."
  sudo apt-get install gcc g++ build-essential git wget curl
  echo "isntall npm for Web Development"
  curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.5/install.sh | bash
  nvm install node
  echo "Installing Krita..."
  sudo apt install krita
  echo "Install Blender..."
  sudo apt install blender
  #echo "Neovim"
  #sudo apt install neovim
  #sudo apt install blender
  #sudo apt install 
elif [[$input = 0 || $input ="n" ]]; then
  echo "Abort"
fi

echo "Want to install VSCode (type 1 = yes)"
read input
if [[ $input = 1 ]]; then
  sudo apt-get install wget gpg
  wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
  sudo install -D -o root -g root -m 644 packages.microsoft.gpg /etc/apt/keyrings/packages.microsoft.gpg  
  echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" |sudo tee /etc/apt/sources.list.d/vscode.list > /dev/null
  rm -f packages.microsoft.gpg
  sudo apt install apt-transport-https
  sudo apt update
  sudo apt install code 
else
  echo "Abort the VSCode installation"
fi

echo "Want to install Neovim? (type 1 to accept!)"
read input
if [[ $input = 1]]; then
  echo "Isntalling Neovim"
fi


