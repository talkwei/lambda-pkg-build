#!/bin/bash

SITE_PACKAGES=$LAMBDA_BUILD/lib/python3.6/site-packages
pushd $SITE_PACKAGES
# zip -r -9 -q $LAMBDA_BUILD/placement.zip \
# 		urllib3 requests idna chardet certifi pytz \
# 		numpy pandas
# zip -r -9 -q $LAMBDA_BUILD/predictor.zip \
# 		urllib3 requests idna chardet certifi pytz simplejson \
# 		numpy scipy sklearn xgboost
zip -r -9 -q $LAMBDA_BUILD/lambda.zip \
		urllib3 requests idna chardet certifi pytz simplejson \
		numpy pandas scipy sklearn xgboost
popd
