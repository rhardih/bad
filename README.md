# bad

**[B](https://github.com/rhardih/bad)uilding for [A](https://github.com/rhardih/bad)ndroid with [D](https://github.com/rhardih/bad)ocker**

This is a collection of Dockerfiles, for building various native libraries using
the Android NDK.

## Why?

Cross compiling native libraries can sometimes be a
[**pita**](https://www.urbandictionary.com/define.php?term=pita). More often than
not, you'll need architecture specific versions of dependent libraries in order
to succeed and you'll quickly find yourself cross compiling those dependencies,
as well as the their dependencies, and so on and so forth. Down the
rabbit hole we go.

Sometimes it would be nice to just have a sure-fire way of getting a hold of
that elusive library, without having to get into different toolchains, build
systems etc. etc.

That is what this project aims to accomplish. By using [**docker**](https://www.docker.com), it's possible to
lock down a specific enviroment with just the right dependencies met, in order
to successfully build a specific native library for the architecture of your
choice.

The assumption is, if it builds *once*, it will *always* build.

## Building

Make is used to define the various build targets and dependencies.

### Example

In order to build **libsqlite3**, this command would do:

`make sqlite3`

Note, extra options for `docker build`, can be passed via `BUILD_ARGS` e.g.:

`make BUILD_ARGS="--no-cache" sqlite3`

Once it's done, the libraries are available under the install target, `/sqlite3-build`, within the container.

```bash
$ docker run --rm -it bad-libsqlite3
root@bcd377ee512d:/sqlite# ls -la /sqlite3-build/lib/
total 6696
drwxr-xr-x 3 root root    4096 Dec 11 09:34 .
drwxr-xr-x 5 root root    4096 Dec 11 09:34 ..
-rw-r--r-- 1 root root 4135994 Dec 11 09:34 libsqlite3.a
-rwxr-xr-x 1 root root     943 Dec 11 09:34 libsqlite3.la
lrwxrwxrwx 1 root root      19 Dec 11 09:34 libsqlite3.so -> libsqlite3.so.0.8.6
lrwxrwxrwx 1 root root      19 Dec 11 09:34 libsqlite3.so.0 -> libsqlite3.so.0.8.6
-rwxr-xr-x 1 root root 2701988 Dec 11 09:34 libsqlite3.so.0.8.6
drwxr-xr-x 2 root root    4096 Dec 11 09:34 pkgconfig
```

If you need to, you can copy them to the host using the included extraction
script. The script is available as a built-in
**[sub](https://github.com/basecamp/sub)** command. First make the
**bad** command available, by initalising the sub like so:

```bash
$ eval "$(.bad/bin/bad init -)"
```

Then issue the sub command *extract*, e.g:

```bash
bad extract sqlite3

Now you should have all the files from the installation:

```bash
$ tree sqlite3-build/
sqlite3-build/
├── bin
│   └── sqlite3
├── include
│   ├── sqlite3.h
│   └── sqlite3ext.h
└── lib
    ├── libsqlite3.a
    ├── libsqlite3.la
    ├── libsqlite3.so -> libsqlite3.so.0.8.6
    ├── libsqlite3.so.0 -> libsqlite3.so.0.8.6
    ├── libsqlite3.so.0.8.6
    └── pkgconfig
        └── sqlite3.pc
```

**Alternatively** you can run the same docker command directly yourself:

```bash
$ docker run --rm -i -v `pwd`:/host bad-libsqlite3 cp -r /sqlite3-build /host/
```
### Versions

For some make rules it's possible to build specific versions of a target using
the following form:

`make sqlite3/3.21.0`

Check the [Makefile](https://github.com/rhardih/bad/blob/master/Makefile) to see
which ones.

## Dependencies

First and foremost **docker**. See
[https://docs.docker.com/engine/installation](https://docs.docker.com/engine/installation) for installation instructions.

Besides this, most Dockerfiles uses a containerised NDK toolchain build with
[stand](https://github.com/rhardih/stand). A list of current available
toolchains can be seen at
[https://hub.docker.com/r/rhardih/stand/tags](https://hub.docker.com/r/rhardih/stand/tags)
and new ones can be be created using [By](https://github.com/rhardih/by),
available at [https://standby.rhardih.io](https://standby.rhardih.io).
