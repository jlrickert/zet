# Nginx clear cache hack with echo ""

I learned a cool thing from [krisnova](https::/twitch.tv/krisnova) where you can clear the cache without having to restart. This is accomplished by running `echo "" > /nginx/cache`. The reason why it works is that it keeps all the file descriptors open.

It is apparently based on an older kernel hack.

Timestamps of the mention Fri 09 Dec 2022 01:14:34 PM CST
