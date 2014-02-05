## Checking out the source

Clone the repository from GitHub.

```
$ git clone https://github.com/josh/senv
```

## Testing

The test suite uses a test runner called [bats](https://github.com/sstephenson/bats). If you're on OS X, you can just `brew install bats` to get started.

To run the tests

``` sh
$ bats test/senv.bats
 ✓ invoking senv without arguments prints usage
 ✓ invoking senv with invalid arguments prints usage
 ✓ encrypt stdin
 ✓ encrypt file argument
 ✓ decrypt stdin
 ✓ decrypt without input prints usage
 ✓ ignores plain test file on decrypt
 ✓ ignores invalids lines on decrypt
 ✓ encrypt/decrypt stdin

9 tests, 0 failures
```
