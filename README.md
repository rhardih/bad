# bad

**Building for Android with Docker**

This is a collection of Dockerfiles, for building various native libraries using
the Android NDK.

## Why?

Cross compiling native libraries can sometimes be a
[**pita**](https://www.urbandictionary.com/define.php?term=pita). More often than
not, you'll need architecture specific versions of dependent libraries in order
to succeed and you'll quickly find yourself cross compiling those dependencies,
as well as the dependencies' dependencies, and so on and so forth. Down the
rabbit hole we go.

Sometimes it would be nice to just have a sure-fire way of getting a hold of
that elusive library, without having to get into different toolchains, build
systems etc. etc.

That is what this project aims to accomplish. By using [**docker**](https://www.docker.com), it's possible to
lock down a specific enviroment with just the right dependencies met, in order
to successfully build a specific native library for the architecture of your
choice.

The thesis is, if it builds *once*, it will *always* build.

## Building

Make is used to define the various build targets and dependencies.

### Example

In order to build **libsqlite3**, this command would do:

`make sqlite3`

Once it's done, the libraries are available under the install target, `/sqlite-build`, within the container.

```bash
$ docker run --rm -it bad-libsqlite3
root@bcd377ee512d:/sqlite# ls -la /sqlite-build/lib/
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
If you need to, you can copy them to the host with a one-off `docker run` command like so:

```bash
$ docker run --rm -i -v `pwd`:/host bad-libsqlite3 cp -r /sqlite-build /host/
```

Now you should have all the files from the installation:

```bash
$ tree sqlite-build/
sqlite-build/
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

## Dependencies

First and foremost **docker**. See
[https://docs.docker.com/engine/installation](https://docs.docker.com/engine/installation) for installation instructions.

Besides this, most Dockerfiles uses a containerised NDK toolchain build with
[stand](https://github.com/rhardih/stand). A list of current available
toolchains can be seen at
[https://hub.docker.com/r/rhardih/stand/tags](https://hub.docker.com/r/rhardih/stand/tags)
and new ones can be be created using [By](https://github.com/rhardih/by),
available at [https://standby.rhardih.io](https://standby.rhardih.io).
