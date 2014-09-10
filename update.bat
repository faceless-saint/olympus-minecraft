::Fetch latest version and reset local copy
@ECHO off
CALL git fetch origin master
CALL git reset --hard FETCH_HEAD
