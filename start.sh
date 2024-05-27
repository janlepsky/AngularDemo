#!/bin/sh

# Log the MO_GIT_COMMIT_AUTHOR variable
echo "Git Commit Author: ${MO_GIT_COMMIT_AUTHOR}"

# Start Nginx
nginx -g 'daemon off;'
