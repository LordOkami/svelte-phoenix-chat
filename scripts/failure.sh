#!/usr/bin/env bash

source scripts/telegram.sh

send_msg "<i >Error deploying $TRAVIS_REPO_SLUG</i>
    $TRAVIS_BUILD_WEB_URL
    <code>Message: $TRAVIS_COMMIT_MESSAGE</code>
    <code>Pushed by: $AUTHOR_NAME</code>"