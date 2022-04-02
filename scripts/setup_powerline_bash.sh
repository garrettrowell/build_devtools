#!/bin/bash

# Run: pip show powerline-status
#
# in output theres a line like:
# Location: /root/.local/lib/python2.7/site-packages
#
# This is REPO_ROOT


REPO_ROOT=$(pip3 show powerline-status 2>/dev/null | grep Location | cut -d ' ' -f 2)
USER_PROFILE='/root/.bash_profile'


cat <<EOT >> $USER_PROFILE
powerline-daemon -q
POWERLINE_BASH_CONTINUATION=1
POWERLINE_BASH_SELECT=1
. $REPO_ROOT/powerline/bindings/bash/powerline.sh
EOT