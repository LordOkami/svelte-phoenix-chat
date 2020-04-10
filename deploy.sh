#!/usr/bin/env bash
git remote add gigalixir https://$GIGALIXIR_EMAIL:$GIGALIXIR_API_KEY@git.gigalixir.com/$GIGALIXIR_APP_NAME.git
BRANCH=$(if [ "$TRAVIS_PULL_REQUEST" == "false" ]; then echo $TRAVIS_BRANCH; else echo $TRAVIS_PULL_REQUEST_BRANCH; fi)
echo "TRAVIS_BRANCH=$TRAVIS_BRANCH, PR=$PR"
echo "------------------------------------"
echo "BRANCH=$BRANCH"

# Set up Telegram
BOT_URL="https://api.telegram.org/bot$TELEGRAM_TOKEN/sendMessage"

# Send messages to Telegram bot
function send_msg () {
    # Use "$1" to get the first argument (desired message) passed to this function
    # Set parsing mode to HTML because Markdown tags don't play nice in a bash script
    # Redirect curl output to /dev/null since we don't need to see it
    # (it just replays the message from the bot API)
    # Redirect stderr to stdout so we can still see an error message in curl if it occurs
    curl -s -X POST $BOT_URL -d chat_id=$TELEGRAM_CHAT_ID -d text="$1" -d parse_mode="HTML" > /dev/null 2>&1
}

if [ "$BRANCH" == "master" ]; then
  echo "Pushing HEAD to master branch on Gigalixir."
  git push gigalixir HEAD:master --verbose
  echo "Deploy completed."
  send_msg "<i>Successfully deployed GitHub repo for $TRAVIS_REPO_SLUG</i>
    <code>Message: $TRAVIS_COMMIT_MESSAGE</code>
    <code>Pushed by: $AUTHOR_NAME</code>"
  echo "Telegram notification Send"
fi
echo "Exiting."