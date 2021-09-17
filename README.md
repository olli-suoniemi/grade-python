Grading environment with specific Python version in path.

Includes following extra packages:

 * [Python grader-utils](https://github.com/apluslms/python-grader-utils)
 * [Pytest](https://docs.pytest.org/en/stable/)

Tags
----

Images are tagged with Python and grading-base versions in format `<Python>-<grading-base>`.
Version tag can also include `uN` meaning _update N_ where N is an increasing number.
The update part is used to indicate updates to the image, where software versions did not change.
For an example, `3.5-2.0u1` includes Python 3.5 on top of grading-base 2.0 and has one update after first release.
Newer tags include the version of Python grader-utils in the middle of the tag.
For example, `3.7-3.3-3.1` includes Python 3.7 and Python grader-utils 3.3 on top of grading-base 3.1.

There is also few additional versions of the image:

 * `math-*` includes Python packages matplotlib, scipy, numpy and bokeh on top of the base and in addition, openpyxl, xlrd and xlwt for Excel file parsing
 * `ml-*` includes Python packages pandas, scikit-learn and numpy on top of the math layer
 * `rdf-*` includes Python package rdflib on top of the base
 * `xls-*` includes Python packages xlrd and xlwt on top of the base for parsing Excel files
 * `ply-*` includes the Python package PLY (parser and lexer generator)


Utility commands
----------------

In addition to [grading-base](https://github.com/apluslms/grading-base), this container provides following utilities.

* `graderutils [--use-iotester] [--use-rpyc] [--novalidate] [--container] [--show-config] [--develop-mode] -- path_to_test_config`
  * `--use-iotester`

    Create the necessary directory structure with the correct permissions required by iotester.
  * `--use-rpyc`

    Use RPyC (Remote Python Call) to import and call student code running in a separate process.
  * `--novalidate`

    Skip validation of test config.
  * `--container`

    This flag can be used when running graderutils inside docker container based on apluslms/grading-base to raise and print exceptions that occur in graderutils itself to stderr (normally not used).
  * `--show-config`

    Print test configuration into warnings.
  * `--develop-mode`

    Display all unhandled exceptions unformatted.
    Also implies `--show-config`.
    By default, exceptions related to improperly configured tests are caught and hidden behind a generic error message.
    This is to prevent unwanted leaking of grader test details, which might reveal e.g. parts of the model solution, if one is used.

  Executes `graderutils.main` (or `graderutils.__main__` when `--use-rpyc` flag is set) Python module using `capture` wrapper (check [grading-base](https://github.com/apluslms/grading-base)).
  Provided arguments, except for `--use-iotester` and `--use-rpyc`, are passed to the Python module.
  If there are no arguments, then the module is executed with `/exercise/test_config.yaml` as the first argument.
  In other words, if you define graderutils configuration in `test_config.yaml`, you only need to have `graderutils` in the config.yaml `cmd` field.

* `unittest`

    Alias for `python3 -m unittest`.
    Adds `/exercise` to `PYTHONPATH`.

* `unittest-capture`

    Wrapper around `capture` and `unittest` Python module.
    Adds `/exercise` to `PYTHONPATH`.
    Does execute `err-to-out` if there is no errors.

* `unittest-testcase [-t title] [-p points] [-s skip] [unittest arguments]`

    Wrapper around `testcase` and `unittest` Python module.
    Adds `/exercise` to `PYTHONPATH`.
    Arguments are passed to `testcase` and unittest arguments for the Python module.
    Check `testcase` documentation in [grading-base](https://github.com/apluslms/grading-base).

* `python-compile-all`

    Alias for `python3 -m compileall`.
    Use it to validate Python syntax of input files before tests.

* `run-all-unittests [-S] [-p points_per_test_class]`

    Command to do it all.
    Can replace `run.sh` in trivial cases.

    First, script validates syntax, unless `-S` is provided.
    If syntax is not valid, no tests are run.
    Second, script finds all files matching `*test*.py` pattern from submission and exercise paths.
    Then, it runs every class that directly inherits `unittest.TestCase` using `testcase` and `unittest`.
    Testcase will give `points_per_test_class` many points per successful execution of unittest.
