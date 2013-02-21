# rebind prefix
set -g prefix C-a
unbind-key C-b

# vi-like behaviour
set -g mode-keys vi

# screen-like sending commend sequence
bind-key a send-prefix

# default delay
set -sg escape-time 1

# index windows/panes starting from 1
set -g base-index 1
set -g pane-base-index 1

# resizing only if someone is looking at window
setw -g aggressive-resize on

# turn all mouse features
setw -g mode-mouse off

bind-key b set-option status

# screen like last active window
bind-key C-a last-window

# easy bindig for config reloading
bind r source-file ~/.tmux.conf \; display "RELOADED"

# intuitive window splitting
unbind %
bind \ split-window -h
bind - split-window -v 

# vi-like moving through panes
bind h select-pane -L
bind j select-pane -D
bind k select-pane -U
bind l select-pane -R

# vi-like pane resizing
bind -r H resize-pane -L
bind -r J resize-pane -D
bind -r K resize-pane -U
bind -r L resize-pane -R

# more intuitive vi selection
bind-key -t vi-copy v begin-selection
bind-key -t vi-copy y copy-selection

# notify of activities
setw -g monitor-activity on
set -g visual-activity on

# 256-color mode
set -g default-terminal "screen-256color"

# color & styles
set -g status-bg colour235 
set -g status-fg colour244
set -g status-attr default
set -g status-justify left
set -g status-interval 5

setw -g window-status-fg colour244
setw -g window-status-bg default
setw -g window-status-current-fg white
setw -g window-status-current-attr none

set -g pane-border-fg colour235
set -g pane-active-border-fg colour240

set -g display-panes-active-colour colour33
set -g display-panes-colour white

setw -g clock-mode-colour colour64

set -g message-attr bold
set -g message-fg black
set -g message-bg white

set -g status-left '[#[fg=white]#S#[fg=default]]'
set -g status-left-length 40

set -g status-right '#[fg=colour244]@#H | #[fg=default]%H:%M'

