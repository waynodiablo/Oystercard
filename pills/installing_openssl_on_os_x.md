# Installing OpenSSL on OS X

If you're getting errors that mention OpenSSL when using Ruby or a gem, try the instructions below.

This guide assumes that the basic problem is that OS X is using an insecure version of OpenSSL (e.g. `0.9.8`).

1. Try using homebrew to install the latest version.  Make sure `openssl version` returns a version greater than `1.0.0`.  If that works, great.

2. If that doesn't work, try following these instructions to upgrade OS X's version of OpenSSL: http://bytefish.de/blog/net_core_mac_os/
