# My dotfiles

## Installation

### Quick Install
```
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/IvanEstradaa/.dotfiles/HEAD/install.sh)" 
```

> [!NOTE]
> If you haven't installed the Xcode Commmand Line Tools (such as `git`). I recommend you to use this method.

### Manual Installation
Clone GitHub repository running the following command in your terminal.
```
git clone https://github.com/IvanEstradaa/.dotfiles.git ~/.dotfiles && cd ~/.dotfiles
```

Then execute the initialization script, to start downloading packages and setting up apps.
```
source bootstrap.sh
```

Once the previous script is done, execute MacOS setup script to change looks and behaviors of the MacOS.
```
source macos/setup.sh
``` 

Once the macOS setup is complete, a pop-up will appear asking you to reboot your machine in order for some changes to take effect.