#!/usr/bin/env bash

# Get WebApp URL
APP_URL="https://$GIGALIXIR_APP_NAME.gigalixirapp.com"


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