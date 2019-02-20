# bad

**[B](https://github.com/rhardih/bad)uilding for [A](https://github.com/rhardih/bad)ndroid with [D](https://github.com/rhardih/bad)ocker**

This is a collection of Dockerfiles, for building various native libraries using
the Android NDK.

## Why?

Cross compiling native libraries can sometimes be a
[**pita**](https://www.urbandictionary.com/define.php?term=pita). More often than
not, you'll need architecture specific versions of dependent libraries in order
to succeed and you'll quickly find yourself cross compiling those dependencies,
as well as the their dependencies, and so on and so forth.

It's turtles all the way down.

Wouldn't it be nice to just be able to `make` that library you need, without having to get into different toolchains, build systems etc. etc.

That is what this project aims to accomplish. By using [**docker**](https://www.docker.com), it's possible to lock down a specific enviroment with just the right dependencies met, in order to successfully build a specific native library for the architecture of your choice.

That's the beauty of an immutable build system. If it builds *once*, it will *always* build!

## Naming convention

Containers are named according to the following convention:

`bad-<name>:<version>-<architecture>`

So as an example, the container to build an *armv7-a* version of **libsqlite3** v. 3.21.0, would have the following name:

`bad-sqlite3:3.21.0-armv7-a`

## Building

All libraries are compiled from source. Each build downloads the corresponding
source at run time, which means the success of a build is tied to the
availability of the sources online.

In case a repository goes down, or is unreachable at the time of a build,
there's just no way to make it succeed. This trade-off is a concious decision,
in order to waiver any concerns about source tampering, which would naturally
follow if sources were bundled.

---

[Make](https://www.gnu.org/software/make) is used, to define the various build
targets and dependencies.


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
bad extract sqlite3-3.21.0
```

Note, in order to see which targets can currently be extracted, either use the
built-in tab completion or use the related `bad list` sub command.

Once done, you should have all the files from the installation, available under
the subfolder *extracted*:

```bash
$ tree extracted/sqlite3-3.21.0-build/
extracted/sqlite3-3.21.0-build/
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

4 directories, 9 files
```

**Alternatively** you can run the same docker command directly yourself:

```bash
$ docker run --rm -i -v `pwd`/extracted:/host bad-libsqlite3:3.21.0 \
  cp -r /sqlite3-build /host/sqlite3-3.21.0-build
```

### Versions

For some make rules it's possible to build specific versions of a target using
the following form:

`make sqlite3/3.21.0`

Check the [Makefile](https://github.com/rhardih/bad/blob/master/Makefile) to see
which ones.

## Dependencies

First and foremost **docker**. See
[https://docs.docker.com/engine/installation](https://docs.docker.com/engine/installation)
for installation instructions.

Besides this, most Dockerfiles uses a containerised NDK toolchain build with
[stand](https://github.com/rhardih/stand). A list of current available
toolchains can be seen at
[https://hub.docker.com/r/rhardih/stand/tags](https://hub.docker.com/r/rhardih/stand/tags)
and new ones can be be created using [By](https://github.com/rhardih/by),
available at [https://standby.rhardih.io](https://standby.rhardih.io).
