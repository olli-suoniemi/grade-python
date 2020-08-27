Grading environment with specific Python version in path.

Includes following extra packages:

 * [Python grader-utils](https://github.com/aalto-letech/python-grader-utils)
 * [Pytest](https://docs.pytest.org/en/stable/)

Tags
----

Images are tagged with Python and grading-base versions in format `<python>-<grading-base>`.
Version tag can also include `uN` meaning _update N_ where N is an increasing number.
The update part is used to indicate updates to the image, where software versions did not change.
For an example, `3.5-2.0u1` includes Python 3.5 on top of grading-base 2.0 and has one update after first release.
Newer tags include the version of Python grader-utils in the middle of the tag.
For example, `3.7-3.3-3.1` includes Python 3.7 and Python grader-utils 3.3 on top of grading-base 3.1.

There is also few additional versions of the image:

 * `math-*` includes python packages matplotlib, scipy and numpy on top of the base
 * `rdf-*` includes python package rdflib on top of the base
 * `xls-*` includes python package xlrd on top of the base for parsing excel files


Utility commands
----------------

In addition to [grading-base](https://github.com/apluslms/grading-base), this container provides following utilities.

* `graderutils [arguments]`

    Executes `graderutils.main` python module using `capture` wrapper (check [grading-base](https://github.com/apluslms/grading-base)).
    Provided arguments are passed to the python module.
    If there is no arguments, then the module is executed with `/exercise/test_config.yaml` is the first argument.
    In other words, if you define graderutils configuration in `test_config.yaml`, you only need to have `graderutils` in config.yaml `cmd` field.

* `unittest`

    Alias for `python3 -m unittest`.
    Adds `/exercise` to `PYTHONPATH`.

* `unittest-capture`

    Wrapper around `capture` and `unittest` python module.
    Adds `/exercise` to `PYTHONPATH`.
    Does execute `err-to-out` if there is no errors.

* `unittest-testcase [-t title] [-p points] [-s skip] [unittest arguments]`

    Wrapper around `testcase` and `unittest` python module.
    Adds `/exercise` to `PYTHONPATH`.
    Arguments are passed to `testcase` and unittest arguments for the python module.
    Check `testcase` documentation in [grading-base](https://github.com/apluslms/grading-base).

* `python-compile-all`

    Alias for `python3 -m compileall`.
    Use it to validate python syntax of input files before tests.

* `run-all-unittests [-S] [-p points_per_test_class]`

    Command to do it all.
    Can replace `run.sh` in trivial cases.

    First, script validates syntax, unless `-S` is provided.
    If syntax is not valid, no tests are run.
    Second, script finds all files matching `*test*.py` pattern from submission and exercise paths.
    Then, it runs every class that directly inherits `unittest.TestCase` using `testcase` and `unittest`.
    Testcase will give `points_per_test_class` many points per successful execution of unittest.
