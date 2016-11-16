Fliperama's dashboard created with http://shopify.github.com/dashing.

# Configuration

```
cp .env.development .env
```

Update `.env` file with your credentials.

Configure Raspberry by running `sudo raspi-config` and setting boot option to
B2 ("command prompt with auto login"). Create a `startB` file at `/home/pi`
with:

```shell
xset -dpms
xset s off
xset s noblank
matchbox-window-manager -use_titlebar no &
WEBKIT_DISABLE_TBS=1 epiphany-browser -a --profile /home/pi/.config  http://site
```

Now edit `/etc/rc.local` and add the following line before `exit 0`:

```shell
sudo xinit ./home/pi/startB &
```

# Starting application

```shell
dashing start
```
