# Installing OpenSSL on OS X

If you're getting errors that mention OpenSSL when using Ruby or a gem, try the instructions below.

This guide assumes that the basic problem is that OS X is using an insecure version of OpenSSL (e.g. `0.9.8`).

1. Try using homebrew to install the latest version of OpenSSL.  Make sure `openssl version` returns a version greater than or equal to `1.1.0`.  If that works, great.

2. If that doesn't work, follow the instructions below to upgrade OS X's version of OpenSSL.

## Upgrade OS X's version of OpenSSL

* Go to https://www.openssl.org/source/ and download the `1.1.0e` version of OpenSSL.

* Unpack the downloaded file by double clicking on it.

* `cd` into the unpacked directory.

* Run these commands to compile and install OpenSSL:

```
./Configure darwin64-x86_64-cc shared enable-ec_nistp_64_gcc_128 no-ssl2 no-ssl3 no-comp --openssldir=/usr/local/ssl/macos-x86_64
make depend
sudo make install
```

* Open a new terminal window.

* Check that you have OpenSSL version 1.1.0 installed with:

```
openssl version
```
