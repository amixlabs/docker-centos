#!/bin/bash
if [[ $LOCAL_USER_ID && $LOCAL_USER_ID -ne 0 ]]; then
    LOCAL_GROUP_ID=${LOCAL_GROUP_ID:-$LOCAL_USER_ID}
    export HOME=/home/user
    usermod --uid "$LOCAL_USER_ID" user
    groupmod --gid "$LOCAL_GROUP_ID" user
    chown -R user.user /home/user
    exec gosu user "$@"
fi
exec "$@"
