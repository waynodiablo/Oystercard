# Installing OpenSSL

If you're getting errors about OpenSSL when using Ruby or a gem, try the instructions below.

1. Check what version of OpenSSL you have with `openssl version`.  It should return a version greater than `1.0.0`.

2. If it doesn't try using homebrew to install the latest version.  Make sure `openssl version` returns a version greater than `1.0.0`.  If that works, great.

3. If that doesn't work, try following these instructions to upgrade OS X's version of OpenSSL: http://bytefish.de/blog/net_core_mac_os/
