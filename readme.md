# Elastic Beanstalk dotfiles

This repo is used to setting up the shell on AWS EB. This used some of my
[my dotfiles](https://github.com/letientai299/dotfiles/), trimmed down for
working on the cloud.

## Caveats

- Only tested on Amazon Linux 1 and 2.
- This means to be used on **fresh new env**. It makes no effort to backup the
  existing config.

## What in it?

- Change default shell to zsh
- zsh:
  - Use oh-my-zsh, with some plugins
- vim:

## Tip

When develop this repo, I use direnv, docker, tmux and nodemon to automate the
repetitive steps like build the docker, kill old contains and start fresher new
one with loaded config.

Here's how

```sh
nodemon -w .
  -x 'make img; \
  docker kill aim || true; \
  tmux send-keys -t left "docker run --rm -it --name aim amazonlinux-eb bash" enter c-l'
```
