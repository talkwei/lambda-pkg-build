#!/bin/bash

# Install
python3 -m virtualenv --always-copy --no-site-packages $LAMBDA_BUILD
source $LAMBDA_BUILD/bin/activate
pip install --upgrade pip wheel
pip install -r requirements.txt
pip list

# Strip
SITE_PACKAGES=$LAMBDA_BUILD/lib/python3.6/site-packages
echo "original size $(du -sh $VIRTUAL_ENV | cut -f1)"
find $SITE_PACKAGES -name "tests*"| xargs rm -r
find $SITE_PACKAGES -name "dataset*" | xargs rm -r

# Can't remove tests files from pandas
pushd $SITE_PACKAGES/scipy/.libs && \
    rm *; ln ../../numpy/.libs/* . && \
      	rm -rf /root/.cache  ; popd

find $SITE_PACKAGES -name "*.txt" | xargs rm -r
find $SITE_PACKAGES -name "*.so" | grep -v ufuncs | grep -v fblas | grep -v flapack | \
                                                                grep -v cython_blas | grep -v cython_lapack | grep -v ellip_harm | \
                                                                grep -v odepack | grep -v quadpack | grep -v vode | grep -v lsoda | \
                                                                grep -v iterative | grep -v superlu | grep -v arpack | grep -v trlib | \
                                                                grep -v lbfgs | grep -v qhull | xargs strip
find $SITE_PACKAGES -name "*.pyc" -delete
find $SITE_PACKAGES -type d -empty -delete
echo "current size $(du -sh $VIRTUAL_ENV | cut -f1)"
