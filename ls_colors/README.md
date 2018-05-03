LS_COLORS
=========

Themes of ls --color for Bash Shell

[Configuring LS_COLORS](http://www.bigsoft.co.uk/blog/index.php/2008/04/11/configuring-ls_colors)

[LS_COLORS Generator](https://geoff.greer.fm/lscolors/)

---

INSTALLATION
------------

### Download

Replace the ls_color theme file you want:

```bash
wget https://raw.githubusercontent.com/yidas/shell/master/ls_colors/yidas.sh
```

You could download into your directory such as `~/ls_colors/monokai.sh` then source it.


### Soruce Automatically

you could add above script with setting path into `.bashrc` or other source you like: 

```bash
# Load Theme
if [ -n "${BASH_VERSION}" ]; then
  ls_colors_theme="${HOME}/ls_colors/yidas.sh"
  if [ -f "$ls_colors_theme" ]; then
    source "$ls_colors_theme"
  fi
fi
```

> Replace the ls_color theme file you want

---

THEME 
-----

### Monokai

[Monokai color to Sherwin-Williams mapping](https://gist.github.com/bryanhunter/6178408)
