# Terminal Basics

Even iOS developers benefit from comfort on the command line.

---

## Navigation

```bash
pwd                  # print working directory
ls                   # list files
ls -la               # long format, include hidden
cd folder            # change directory
cd ..                # up one level
cd ~                 # home
cd -                 # previous directory
```

## Files

```bash
touch file.txt       # create empty
mkdir project        # make directory
cp a.txt b.txt       # copy
mv a.txt b.txt       # rename / move
rm file.txt          # delete (permanent)
rm -rf folder        # delete folder + contents (danger!)
```

## Viewing

```bash
cat file.txt         # print entire file
less file.txt        # scrollable viewer (q to quit)
head -20 file.txt    # first 20 lines
tail -20 file.txt    # last 20 lines
tail -f log.txt      # follow (watch for changes)
```

## Search

```bash
grep "TODO" -r .             # search all files below here
find . -name "*.swift"       # find files by pattern
```

## Plumbing

```bash
command > out.txt            # redirect output to file
command >> out.txt           # append
command1 | command2          # pipe output of 1 into 2
cat file | grep error | wc -l
```

## Processes

```bash
ps aux | grep Xcode          # find running process
kill <PID>                   # stop it
top                          # live process monitor
```

## Package Managers

```bash
brew install wget            # Homebrew on macOS
brew update && brew upgrade  # keep up to date
```

## Shell Niceties

```bash
!!                   # repeat last command
sudo !!              # repeat last command with sudo
history              # recent commands
⌃R                   # interactive search of history
```

## Permissions

```bash
chmod +x run.sh      # make file executable
./run.sh             # run it
```

## Networking

```bash
curl https://api.example.com/foo
curl -X POST -H "Content-Type: application/json" -d '{"x":1}' url
```

## Getting Help

```bash
man ls               # manual page (q to quit)
ls --help
```

## macOS-Specific Favorites

```bash
open .               # open current folder in Finder
open -a Xcode file   # open file with specific app
pbcopy < file.txt    # copy file contents to clipboard
pbpaste > file.txt   # paste clipboard into file
```
