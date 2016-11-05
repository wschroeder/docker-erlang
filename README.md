# Erlang in Docker

This is a full build of OTP 19.1.5 in docker for development purposes,
including applications like observer on top of a working wxWidgets
installation.  rebar3 is installed for convenience.

How I use this in Linux:

    docker run -u 1000:1000 -e DISPLAY=:0 -w /work -v $PWD:/work -v $HOME/.hex:$HOME/.hex:rw -v $HOME/.mix:$HOME/.mix:rw -v /etc/passwd:/etc/passwd:ro -v /tmp/.X11-unix:/tmp/.X11-unix -it --rm wschroeder/erlang:19.1.5


For Mac OS, you will need to use the socat trick in order to pipe the X11
display for observer.

