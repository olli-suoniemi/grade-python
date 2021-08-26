ARG FULL_TAG=latest
FROM apluslms/grade-python:math-$FULL_TAG

RUN pip_install \
    pandas==1.2.5 \
    scikit-learn \
 && :
