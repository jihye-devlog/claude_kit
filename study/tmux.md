!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! MAC 일 경우
##### 기본 설정 #####

# Prefix 키를 Ctrl-b 그대로 사용
# Ctrl-a로 바꾸고 싶으면 아래 3줄의 주석을 해제하세요.
# unbind C-b
# set -g prefix C-a
# bind C-a send-prefix

# 마우스 사용: pane 선택, 크기 조절, 스크롤
set -g mouse on

# tmux 클립보드를 시스템 클립보드와 연동 시도
set -s set-clipboard on

# 복사 모드에서 vi 키 사용
setw -g mode-keys vi

# 히스토리 넉넉하게
set -g history-limit 100000

# 창/패널 번호를 1부터 시작
set -g base-index 1
setw -g pane-base-index 1

# 설정 다시 불러오기
bind r source-file ~/.tmux.conf \; display-message "~/.tmux.conf reloaded"

##### 창/패널 생성 #####

# 기본 split 키 해제
unbind '"'
unbind %

# 현재 pane 경로 기준으로 새 창 / 분할
bind c new-window -c "#{pane_current_path}"
bind | split-window -h -c "#{pane_current_path}"
bind - split-window -v -c "#{pane_current_path}"

##### 패널 이동 #####

# Vim 스타일로 pane 이동
bind h select-pane -L
bind j select-pane -D
bind k select-pane -U
bind l select-pane -R

##### 패널 크기 조절 #####

# Alt + 방향키로 pane resize
bind -n M-Left resize-pane -L 5
bind -n M-Right resize-pane -R 5
bind -n M-Up resize-pane -U 3
bind -n M-Down resize-pane -D 3

##### 복사 / 클립보드 #####

# copy-mode-vi에서 v로 선택 시작
bind-key -T copy-mode-vi v send-keys -X begin-selection

# y로 macOS 클립보드에 복사
bind-key -T copy-mode-vi y send-keys -X copy-pipe-and-cancel "pbcopy"

# 마우스 드래그 선택이 끝나면 macOS 클립보드로 복사
bind-key -T copy-mode-vi MouseDragEnd1Pane send-keys -X copy-pipe-and-cancel "pbcopy"

##### 상태바 #####

set -g status on
set -g status-interval 5
set -g status-left "#S "
set -g status-right "%Y-%m-%d %H:%M"

# 현재 pane 강조
set -g pane-border-style fg=colour238
set -g pane-active-border-style fg=green

##### 기본 설정 #####

# Prefix 키를 Ctrl-b 그대로 사용
# Ctrl-a로 바꾸고 싶으면 아래 3줄의 주석을 해제하세요.
# unbind C-b
# set -g prefix C-a
# bind C-a send-prefix

# 마우스 사용: pane 선택, 크기 조절, 스크롤
set -g mouse on

# tmux 클립보드를 시스템 클립보드와 연동 시도
set -s set-clipboard on

# 복사 모드에서 vi 키 사용
setw -g mode-keys vi

# 히스토리 넉넉하게
set -g history-limit 100000

# 창/패널 번호를 1부터 시작
set -g base-index 1
setw -g pane-base-index 1

# 설정 다시 불러오기
bind r source-file ~/.tmux.conf \; display-message "~/.tmux.conf reloaded"

##### 창/패널 생성 #####

# 기본 split 키 해제
unbind '"'
unbind %

# 현재 pane 경로 기준으로 새 창 / 분할
bind c new-window -c "#{pane_current_path}"
bind | split-window -h -c "#{pane_current_path}"
bind - split-window -v -c "#{pane_current_path}"

##### 패널 이동 #####

# Vim 스타일로 pane 이동
bind h select-pane -L
bind j select-pane -D
bind k select-pane -U
bind l select-pane -R

##### 패널 크기 조절 #####

# Alt + 방향키로 pane resize
bind -n M-Left resize-pane -L 5
bind -n M-Right resize-pane -R 5
bind -n M-Up resize-pane -U 3
bind -n M-Down resize-pane -D 3

##### 복사 / 클립보드 #####

# copy-mode-vi에서 v로 선택 시작
bind-key -T copy-mode-vi v send-keys -X begin-selection

# y로 macOS 클립보드에 복사
bind-key -T copy-mode-vi y send-keys -X copy-pipe-and-cancel "pbcopy"

# 마우스 드래그 선택이 끝나면 macOS 클립보드로 복사
bind-key -T copy-mode-vi MouseDragEnd1Pane send-keys -X copy-pipe-and-cancel "pbcopy"

##### 상태바 #####

set -g status on
set -g status-interval 5
set -g status-left "#S "
set -g status-right "%Y-%m-%d %H:%M"

# 현재 pane 강조
set -g pane-border-style fg=colour238
set -g pane-active-border-style fg=green


!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! LINUX 일 경우

# prefix
set -g prefix C-a
unbind C-b
bind C-a send-prefix
 
# 마우스 사용
set -g mouse on
 
# split (Shift 안 쓰는 키)
bind s split-window -h
bind w split-window -v
 
# pane 이동 (vim 스타일)
bind h select-pane -L
bind j select-pane -D
bind k select-pane -U
bind l select-pane -R
 
# pane 닫기
bind x kill-pane
 
# 설정 다시 불러오기
bind r source-file ~/.tmux.conf \; display-message "tmux.conf reloaded"