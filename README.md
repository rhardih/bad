# bad

**Building for Android with Docker**

This is a collection of Dockerfiles, for building various native libraries using
the Android NDK.

## Why?

Cross compiling native libraries can sometimes be a **pita**. More often than
not, you'll need architecture specific versions of dependent libraries in order
to succeed and you'll quickly find yourself cross compiling those dependencies,
as well as the dependencies' dependencies, and so on and so forth. Down the
rabbit hole we go.

Sometimes it would be nice to just have a sure-fire way of getting a hold of
that elusive library, without having to get into different toolchains, build
systems etc. etc.

That is what this project aims to accomplish. By using docker, it's possible to
lock down a specific enviroment with just the right dependencies met, in order
to successfully build a specific native library for the architecture of your
choice. The thesis is, if it builds *once*, it will always build.

## Building

Make is used to define the various build targets and dependencies.

As an example, in order to build `libsqlite3`, this command would do:

`make sqlite`
