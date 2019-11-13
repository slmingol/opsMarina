# TravisCI
We use Travis for the CI

## Travis encrypt
If you need to add your github_token to a new Travis project, this is the easiest method we found, install the travis gem and then follow

```
$ travis encrypt --pro GITHUB_TOKEN="XXXXXXXXXXXXXXXXXXXXXXXXXX" --add
```
- https://travis-ci.com/slmingol/opsMarina/
- https://help.github.com/en/github/authenticating-to-github/creating-a-personal-access-token-for-the-command-line
