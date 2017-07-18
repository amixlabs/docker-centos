#!/bin/bash

# Add local user
# Either use the LOCAL_USER_ID if passed in at runtime or
# fallback

USER_ID=${LOCAL_USER_ID:-9001}

echo "Starting with UID : $USER_ID"
export HOME=/home/user
if [[ -d $HOME ]]; then
    useradd --shell /bin/bash -u $USER_ID -o -c "" -M user
else
    useradd --shell /bin/bash -u $USER_ID -o -c "" -m user
fi

exec /usr/local/bin/gosu user "$@"
