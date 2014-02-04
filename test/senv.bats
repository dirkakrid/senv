#!/usr/bin/env bats

load test_helper

@test "invoking senv without arguments prints usage" {
  run senv
  [ "$status" -eq 1 ]
  [ "${lines[0]}" = "Usage: senv [-e | -d] <file>" ]
}

@test "invoking senv with invalid arguments prints usage" {
  run senv --invalid
  [ "$status" -eq 1 ]
  [ "${lines[0]}" = "Usage: senv [-e | -d] <file>" ]
}

@test "invoking senv with nonexistent SENV_KEY errors" {
  export SENV_KEY="/tmp/notansshkey"
  run senv
  [ "$status" -eq 1 ]
  [ "${lines[0]}" = "SENV_KEY=/tmp/notansshkey does not exist" ]
}

@test "encrypt stdin" {
  output=$(cat "${BATS_TEST_DIRNAME}/.env" | senv --encrypt)
  status="$?"
  IFS=$'\n' lines=($output)
  [ "$status" -eq 0 ]
  [ "${lines[0]: -1}" = "=" ]
  [ "${lines[1]: -1}" = "=" ]
}

@test "encrypt stdin with shorthand flag" {
  output=$(cat "${BATS_TEST_DIRNAME}/.env" | senv -e)
  status="$?"
  IFS=$'\n' lines=($output)
  [ "$status" -eq 0 ]
  [ "${lines[0]: -1}" = "=" ]
  [ "${lines[1]: -1}" = "=" ]
}

@test "encrypt file argument" {
  run senv --encrypt "${BATS_TEST_DIRNAME}/.env"
  [ "$status" -eq 0 ]
  [ "${lines[0]: -1}" = "=" ]
  [ "${lines[1]: -1}" = "=" ]
}

@test "encrypt .env by default" {
  cd $BATS_TEST_DIRNAME
  run senv --encrypt
  [ "$status" -eq 0 ]
  [ "${lines[0]: -1}" = "=" ]
  [ "${lines[1]: -1}" = "=" ]
}

@test "decrypt stdin" {
  output=$(cat "${BATS_TEST_DIRNAME}/.senv" | senv --decrypt)
  status="$?"
  IFS=$'\n' lines=($output)
  [ "$status" -eq 0 ]
  [ "${lines[0]}" = "S3_BUCKET=YOURS3BUCKET" ]
  [ "${lines[1]}" = "SECRET_KEY=YOURSECRETKEYGOESHERE" ]
}

@test "decrypt stdin with shorthand flag" {
  output=$(cat "${BATS_TEST_DIRNAME}/.senv" | senv -d)
  status="$?"
  IFS=$'\n' lines=($output)
  [ "$status" -eq 0 ]
  [ "${lines[0]}" = "S3_BUCKET=YOURS3BUCKET" ]
  [ "${lines[1]}" = "SECRET_KEY=YOURSECRETKEYGOESHERE" ]
}

@test "decrypt file argument" {
  run senv --decrypt "${BATS_TEST_DIRNAME}/.senv"
  [ "$status" -eq 0 ]
  [ "${lines[0]}" = "S3_BUCKET=YOURS3BUCKET" ]
  [ "${lines[1]}" = "SECRET_KEY=YOURSECRETKEYGOESHERE" ]
}

@test "decrypt without input prints usage" {
  run senv --decrypt
  [ "$status" -eq 1 ]
  [ "${lines[0]}" = "Usage: senv [-e | -d] <file>" ]
}

@test "decrypt .senv by default" {
  cd $BATS_TEST_DIRNAME
  run senv --decrypt
  [ "$status" -eq 0 ]
  [ "${lines[0]}" = "S3_BUCKET=YOURS3BUCKET" ]
  [ "${lines[1]}" = "SECRET_KEY=YOURSECRETKEYGOESHERE" ]
}

@test "ignores plain test file on decrypt" {
  cd $BATS_TEST_DIRNAME
  run senv --decrypt "${BATS_TEST_DIRNAME}/.env"
  [ "$status" -eq 0 ]
  [ "${lines[0]}" = "" ]
}

@test "ignores invalids lines on decrypt" {
  cd $BATS_TEST_DIRNAME
  run senv --decrypt "${BATS_TEST_DIRNAME}/.senv2"
  [ "$status" -eq 0 ]
  [ "${lines[0]}" = "S3_BUCKET=YOURS3BUCKET" ]
  [ "${lines[1]}" = "SECRET_KEY=YOURSECRETKEYGOESHERE" ]
}

@test "encrypt/decrypt stdin" {
  output=$(echo secret | senv -e | senv -d)
  status="$?"
  [ "$status" -eq 0 ]
  [ "${output}" = "secret" ]
}
