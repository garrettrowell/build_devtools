#!/bin/bash

# Run: pip show powerline-status
#
# in output theres a line like:
# Location: /root/.local/lib/python2.7/site-packages
#
# This is REPO_ROOT


REPO_ROOT=$(pip3 show powerline-status 2>/dev/null | grep Location | cut -d ' ' -f 2)

# Root User
USER_PROFILE='/root/.bash_profile'

cat <<EOT >> $USER_PROFILE
if command -v powerline-daemon 1>/dev/null 2>&1; then
  powerline-daemon -q
  POWERLINE_BASH_CONTINUATION=1
  POWERLINE_BASH_SELECT=1
  . $REPO_ROOT/powerline/bindings/bash/powerline.sh
fi
EOT

# Vagrant User
USER_PROFILE='/home/vagrant/.bash_profile'

cat <<EOT >> $USER_PROFILE
if command -v powerline-daemon 1>/dev/null 2>&1; then
  powerline-daemon -q
  POWERLINE_BASH_CONTINUATION=1
  POWERLINE_BASH_SELECT=1
  . $REPO_ROOT/powerline/bindings/bash/powerline.sh
fi
EOT

