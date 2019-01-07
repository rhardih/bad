# bad tests

This folder contains a number of tests for checking that the libraries produced
by **bad**, can actually be loaded and run on an actual device.

The tests are minimal Qt autotest applications, which usually does little more,
than load the library in question, and invoke a function or two from said
library.

The included .pro files for each test, assumes the environment variable
`BAD_PATH` to be set, and will look for the libraries *.so* files, based on the
path it contains.
