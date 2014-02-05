# senv

Encrypted `.env` variables.

Uses an RSA key pair to encrypt and decrypt environment variable configuration. Defaults to the users ssh key.

## Usage

**Encryption**

``` sh
$ cat .env
S3_BUCKET=YOURS3BUCKET
SECRET_KEY=YOURSECRETKEYGOESHERE
$ cat .env | senv --encrypt > .senv
```

**Decryption**

``` sh
$ cat .senv
B+e+RhhbmKz5I88TUSXGA505jAwhX0elwM5yPtWY5vSpifEZMpC6YiqSSVNVpTt+KplM6drF4nYJMlbCXsjs2Xq/9rr2xxKH9nsF30qWpWUb2E5RCsoDKhR8AJZbIDnNFOpzNmt3DhOevMNgBBGu5Mgz/ZyCwOe1QIUyTSYXSkqZeB1H4GU1yS6A74bEBA6dncT/dRmSC0kp+s7LztU0R24uX9+LNSHan1e0kbmJ+xwyGkeVhfAIFBSP5+Pb8QJiqcI0p6qwhKIx8Fu5X3oTwX1Ar8KeghCONudSuwAvKOPgGVplWWX9Zu+WEtPLz2EdzKWPw8yhJO+Ltj6GC26+IA==
OaDpiNDzHLPhGDMFbjJZMC2SV4pZcSYRXt4nY8U2X/Sr4/z3dQw7eUs5+eFkp1goct7rgCIderuUiRWWwzmfV9n62hquOzpoK1aze0lQLJYddSDzPiAOFVv8nzdArxRaWn8t1bYYdTOcFun30sRdttouZ6ACZQUYKXYsLPjzLN2QJYNUPZ93v/lm67vYWxbfPbv8tbVRwY6AcvOsqSINxC55xJjWAbbsm9VJft5uToq1lwvOLPkGcyYvgIXfmH9uzYZ3g68UxmcoMkW/Uh1eo57LEDfHl0c6qz0BKew+6jGx2bWoMCy/L7uQE6P8O33wMpGbi/qzDOrxRBr4yl9H8g==
$ cat .senv | senv --decrypt > .env
```


## Use Cases

* Encrypting personal development credentials on an open source repository.
* Encrypting CI credentials on an open source or private repository.
* Encrypting deployment credentials on a private repository.

Its handy to encrypt environment variables with the same single use deploy key thats associated with the repository.


## Format

`.env` files are formatted with a environment variable key and value on each line.

```
S3_BUCKET=YOURS3BUCKET
SECRET_KEY=YOURSECRETKEYGOESHERE
```

A `.senv` file includes one encrypted variable key and value on each line. The data is Base64 encoded with no extra line breaks.

```
B+e+RhhbmKz5I88TUSXGA505jAwhX0elwM5yPtWY5vSpifEZMpC6YiqSSVNVpTt+KplM6drF4nYJMlbCXsjs2Xq/9rr2xxKH9nsF30qWpWUb2E5RCsoDKhR8AJZbIDnNFOpzNmt3DhOevMNgBBGu5Mgz/ZyCwOe1QIUyTSYXSkqZeB1H4GU1yS6A74bEBA6dncT/dRmSC0kp+s7LztU0R24uX9+LNSHan1e0kbmJ+xwyGkeVhfAIFBSP5+Pb8QJiqcI0p6qwhKIx8Fu5X3oTwX1Ar8KeghCONudSuwAvKOPgGVplWWX9Zu+WEtPLz2EdzKWPw8yhJO+Ltj6GC26+IA==
OaDpiNDzHLPhGDMFbjJZMC2SV4pZcSYRXt4nY8U2X/Sr4/z3dQw7eUs5+eFkp1goct7rgCIderuUiRWWwzmfV9n62hquOzpoK1aze0lQLJYddSDzPiAOFVv8nzdArxRaWn8t1bYYdTOcFun30sRdttouZ6ACZQUYKXYsLPjzLN2QJYNUPZ93v/lm67vYWxbfPbv8tbVRwY6AcvOsqSINxC55xJjWAbbsm9VJft5uToq1lwvOLPkGcyYvgIXfmH9uzYZ3g68UxmcoMkW/Uh1eo57LEDfHl0c6qz0BKew+6jGx2bWoMCy/L7uQE6P8O33wMpGbi/qzDOrxRBr4yl9H8g==
```

Any line that can not be decrypted should simply be ignored. This allows data to be encrypted multiple times under different keys.


## See Also

* [Foreman](https://github.com/ddollar/foreman)
* Ruby [dotenv](https://github.com/bkeepers/dotenv)
* Travis CI [encrypt](https://github.com/travis-ci/travis#encrypt) command


## License

Copyright (c) 2014 Joshua Peek

Distributed under an MIT-style license. See LICENSE for details.
