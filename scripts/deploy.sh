#!/usr/bin/env bash
source scripts/telegram.sh

echo "Imported telegram functions"
git remote add gigalixir https://$GIGALIXIR_EMAIL:$GIGALIXIR_API_KEY@git.gigalixir.com/$GIGALIXIR_APP_NAME.git
BRANCH=$(if [ "$TRAVIS_PULL_REQUEST" == "false" ]; then echo $TRAVIS_BRANCH; else echo $TRAVIS_PULL_REQUEST_BRANCH; fi)
echo "TRAVIS_BRANCH=$TRAVIS_BRANCH, PR=$PR"
echo "------------------------------------"
echo "BRANCH=$BRANCH"


if [ "$BRANCH" == "master" ]; then
  echo "Pushing HEAD to master branch on Gigalixir."
  git push gigalixir HEAD:master --verbose
  echo "Deploy completed."
  send_msg "<i>Successfully deployed GitHub repo for $TRAVIS_REPO_SLUG</i>
    $APP_URL
    <code>Message: $TRAVIS_COMMIT_MESSAGE</code>
    <code>Pushed by: $AUTHOR_NAME</code>"
  echo "Telegram notification Send"
fi
echo "Exiting."