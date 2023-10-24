[ all about xargs ! (beginner - intermediate) anthony explains #200 ](https://www.youtube.com/watch?v=ED9AUfFrak8)
```
touch foo bar
ls * | xargs echo hello hello
# hello hello bar foo
```

```
# better
ls * | xargs --verbose echo hello hello
# echo hello hello bar foo
# hello hello bar foo
```

```
# better macos
ls * | xargs -t echo hello hello
# echo hello hello bar foo
# hello hello bar foo
```

### for each argument
```
ls * | xargs -t -n1 echo hello hello

# echo hello hello bar
# hello hello bar
# echo hello hello foo
# hello hello foo
```

```
# macos
ls * | xargs -t -I{} echo hello hello {} {} {}

# echo hello hello bar bar bar
# hello hello bar bar bar
# echo hello hello foo foo foo
# hello hello foo foo foo
```


```
# linux 
ls * | xargs -t -replace={} echo hello hello {} {} {}

# echo hello hello bar bar bar
# hello hello bar bar bar
# echo hello hello foo foo foo
# hello hello foo foo foo
```


### backup all files
```
ls * | xargs -i -I{} mv {} {}.bak
```


### parallel work
```
git clone git@github.com:pre-commit/pre-commit
git ls-files -- '*.py' | xargs -t -P 5 -n 2 flake8
```


### space inside filename + zero delimiter \0

```
find . -type f -maxdepth 1 -print0 | xargs -0 -t -n1
# /bin/echo ./hi hi word
# ./hi hi word
# /bin/echo ./foo
# ./foo
# /bin/echo ./bar
# ./bar

-z option for git ls-files
```

### no run if empty
`xargs --no-run-if-empty` # does not work on macos


### sort of dry-run
```
find . -type f -maxdepth 1 -print0 | xargs -0 -t -n1 echo rm
# echo rm ./hi hi word
# rm ./hi hi word
# echo rm ./foo
# rm ./foo
# echo rm ./bar
# rm ./bar
```
