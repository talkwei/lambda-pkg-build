#!/bin/bash
do_pip () {
		pip install --upgrade pip wheel		
		pip install -r /app/requirements.txt
		# It seems scipy==0.20 is not compile with the script.
		# scikit-learn==0.18.0 need to fix numpy_pickle_utils.py under folder of /lambda_build/lib/python3.6/site-packages/sklearn/externals/joblib/
		# 2.0.6 has issue with my model on num_leavs.
	}

strip_virtualenv () {
		echo "original size $(du -sh $VIRTUAL_ENV | cut -f1)"
		find $VIRTUAL_ENV/lib/python3.6/site-packages/ -name "tests*"| xargs rm -r
		find $VIRTUAL_ENV/lib/python3.6/site-packages/ -name "dataset*" | xargs rm -r

		# Can't remove tests files from pandas
		pip install pandas==0.20.3
		find $VIRTUAL_ENV/lib/python3.6/site-packages/ -name "*.txt" | xargs rm -r
		find $VIRTUAL_ENV/lib/python3.6/site-packages/ -name "*.so" | xargs strip
				
		
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

    	pip list
}

main

