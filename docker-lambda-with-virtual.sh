#!/bin/bash
do_pip () {
		pip install --upgrade pip wheel		
		pip install numpy==1.13.1
		pip install scipy==0.19.0
		pip install scikit-learn==0.18.1
		cp /app/numpy_pickle_utils.py $VIRTUAL_ENV/lib/python3.6/site-packages/sklearn/externals/joblib/
		pip install lightgbm==2.0.3
	}

# Need to replayce joblib/numpy_pickle_utils.py
# docker cp Research/Lambda-python-code/sklern-fixed/numpy_pickle_utils.py 9740695410e3:/lambda_build
# mv numpy_pickle_utils.py /lambda_build/lib/python3.6/site-packages/sklearn/externals/joblib/

strip_virtualenv () {
		echo "original size $(du -sh $VIRTUAL_ENV | cut -f1)"
		find $VIRTUAL_ENV/lib/python3.6/site-packages/ -name "tests*"| xargs rm -r
		find $VIRTUAL_ENV/lib/python3.6/site-packages/ -name "dataset*" | xargs rm -r

		# Can't remove tests files from pandas
		pip install pandas==0.19.1
		#mv $VIRTUAL_ENV/lightgbm/* $VIRTUAL_ENV/lib/python3.6/site-packages/.
		find $VIRTUAL_ENV/lib/python3.6/site-packages/ -name "*.txt" | xargs rm -r
		find $VIRTUAL_ENV/lib/python3.6/site-packages/ -name "*.so" | xargs strip
		#ImportError: /var/task/lambda_build/lib/python3.6/site-packages/scipy/sparse/linalg/isolve/_iterative.cpython-36m-x86_64-linux-gnu.so: ELF load command address/offset not properly 
		
		
		
		find $VIRTUAL_ENV/lib/python3.6/site-packages/ -name "*.pyc" -delete
		find $VIRTUAL_ENV/lib/python3.6/site-packages/ -type d -empty -delete
		echo "current size $(du -sh $VIRTUAL_ENV | cut -f1)"
	    pushd $VIRTUAL_ENV/lib/python3.6/site-packages/ && zip -r -9 -q /outputs/lambda.zip scipy numpy sklearn pandas pytz lightgbm ; popd
	}

main () {
		pip install virtualenv
		virtualenv -p /var/lang/bin/python \
			        --always-copy \
			        --no-site-packages \
			        lambda_build

		source lambda_build/bin/activate
    
    	do_pip

		
    	strip_virtualenv		
}

main

# To build a docker images which is replica of AWS Lambda env.
#docker run -v "$PWD":/var/task lambci/lambda:python3.6 post.predic_handler '{"Age": 38.0,"Pclass": 1.0, "SibSp": 1.0}'

# docker build docker-lambda/python3.6/build/Dockerfile
# docker run -v $(pwd):/outputs -it lambci/lambda:python3.6 /bin/bash /outputs/build.sh
# From lambci/lambda:python3.6

# if R is needed
#yum install -y R.x86_64 --skip-broken
# Build virtualenv to build the deployment


#https://s3.eu-west-2.amazonaws.com/vivantlendingworkstest/Vivi+Score/model3.pkl