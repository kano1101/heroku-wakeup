# README

## Environments

1. macOS

## Requires

1. Xvfb install.
https://support.apple.com/ja-jp/HT201341

2. Settings such as this.
```
mkdir /tmp/.X11-unix
sudo chmod 1777 /tmp/.X11-unix
sudo chown root /tmp/.X11-unix/
```

3. Register for LineNotify.
https://notify-bot.line.me/my/

## Usage

```
git clone git@github.com:kano1101/heroku-wakeup.git
cd heroku-wakeup
echo "LINE_NOTIFY_TOKEN='your-registered-token'" > .env
rails console
> HerokuBrowser.start'example-app')
```
