ARG FULL_TAG=latest
FROM apluslms/grade-python:math-$FULL_TAG

RUN pip_install \
    scikit-learn \
 && apt_install \
    python3-pandas \
 && :
