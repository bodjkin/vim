#Based on "POWERLINE"
# For use with oh-my-zsh
# Install to ~/.oh-my-zsh/custom/themes/

COMRADE_RIGHT_B=%D{%H:%M:%S}
COMRADE_RIGHT_A=%D{%Y-%m-%d}

COMRADE_COLOR_BG_GRAY=%K{240}
COMRADE_COLOR_BG_LIGHT_GRAY=%K{240}
COMRADE_COLOR_BG_WHITE=%K{255}

COMRADE_COLOR_FG_GRAY=%F{240}
COMRADE_COLOR_FG_LIGHT_GRAY=%F{240}
COMRADE_COLOR_FG_WHITE=%F{255}

# GIT_DIRTY_COLOR=%F{133}
GIT_DIRTY_COLOR=%F{226}
GIT_CLEAN_COLOR=%F{118}
GIT_PROMPT_INFO=%F{012}

ZSH_THEME_GIT_PROMPT_PREFIX=" \ue0a0 "
# ZSH_THEME_GIT_PROMPT_SUFFIX="$GIT_PROMPT_INFO \u2b80"
ZSH_THEME_GIT_PROMPT_SUFFIX="$GIT_PROMPT_INFO "
ZSH_THEME_GIT_PROMPT_DIRTY=" $GIT_DIRTY_COLOR☢ ⋙ "
ZSH_THEME_GIT_PROMPT_CLEAN=" $GIT_CLEAN_COLOR☕ \uE07B  "

ZSH_THEME_GIT_PROMPT_ADDED="%F{082}✚%f"
ZSH_THEME_GIT_PROMPT_MODIFIED="%F{166}✹%f"
ZSH_THEME_GIT_PROMPT_DELETED="%F{160}✖%f"
ZSH_THEME_GIT_PROMPT_RENAMED="%F{220]➜%f"
ZSH_THEME_GIT_PROMPT_UNMERGED="%F{082]═%f"
ZSH_THEME_GIT_PROMPT_UNTRACKED="%F{190]✭%f"

# Brighter teal
PROMPT="%K{051}%F{black}"$' 涛'"%k%f%F{051}%K{black}"$'\ue0b0'" %n@%m %k%f%F{black}%K{255}"$'\ue0b0'"%k%f%F{black}%K{255} %~ %k%f%F{255}%K{black}"$'\ue0b0'"%f%F{051}%K{black}"$'$(git_prompt_info)'"%f%k%{$reset_color%} "
# PROMPT="%K{051}%F{black}"$' 涛'"%k%f%F{051}%K{black}"$'\u2b80'" %n@%m %k%f%F{black}%K{255}"$'\u2b80'"%k%f%F{black}%K{255} %~ %k%f%F{255}%K{black}"$'\u2b80'"%f%F{051}%K{black}"$'$(git_prompt_info)'"%f%k%{$reset_color%} "

# PROMPT="%K{051}%F{black}"$' 方涛 '"%k%f%F{051}%K{black}"$'\u2b80'" %n@%m %k%f%F{black}%K{255}"$'\u2b80'"%k%f%F{black}%K{255} %~ %k%f%F{255}%K{black}"$'\u2b80'"%f%F{051}%K{black}"$'$(git_prompt_info)'"%f%k%{$reset_color%} "

# Richer teal
# PROMPT="%K{045}%F{black}"$' 方涛 '"%k%f%F{045}%K{black}"$'\u2b80'" %n@%m %k%f%F{black}%K{255}"$'\u2b80'"%k%f%F{black}%K{255} %~ %k%f%F{255}%K{black}"$'\u2b80'"%f%F{045}%K{black}"$'$(git_prompt_info)'"%f%k%{$reset_color%} "

# Pale teal
# PROMPT="%K{87}%F{black}"$' 方涛 '"%k%f%F{87}%K{black}"$'\u2b80'" %n@%m %k%f%F{black}%K{255}"$'\u2b80'"%k%f%F{black}%K{255} %~ %k%f%F{255}%K{black}"$'\u2b80'"%f%F{87}%K{black}"$'$(git_prompt_info)'"%f%k%{$reset_color%} "

# Palest teal
# PROMPT="%K{123}%F{black}"$' 方涛 '"%k%f%F{123}%K{black}"$'\u2b80'" %n@%m %k%f%F{black}%K{255}"$'\u2b80'"%k%f%F{black}%K{255} %~ %k%f%F{255}%K{black}"$'\u2b80'"%f%F{123}%K{black}"$'$(git_prompt_info)'"%f%k%{$reset_color%} "

# Too red
# PROMPT="%K{red}%F{black}"$' 方涛 '"%k%f%F{red}%K{black}"$'\u2b80'" %n@%m %k%f%F{black}%K{202}"$'\u2b80'"%k%f%F{black}%K{202} %~ %k%f%F{202}%K{black}"$'\u2b80'"%f%F{red}%K{black}"$'$(git_prompt_info)'"%f%k%{$reset_color%} "

RPROMPT=$COMRADE_COLOR_FG_WHITE$'\ue0b2'"%f$COMRADE_COLOR_BG_WHITE $COMRADE_COLOR_FG_GRAY%@ "$'\ue0b2'"%f%k$COMRADE_COLOR_BG_GRAY$COMRADE_COLOR_FG_WHITE $COMRADE_RIGHT_A %f%k"
