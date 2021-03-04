ARG FULL_TAG=latest
FROM apluslms/grade-python:math-$FULL_TAG

RUN pip_install \
    pandas \
    scikit-learn \
 && :
