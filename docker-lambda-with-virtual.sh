#!/bin/bash
do_pip () {
		pip install --upgrade pip wheel		
		pip install -r /app/requirements.txt
	}

strip_virtualenv () {
		echo "original size $(du -sh $VIRTUAL_ENV | cut -f1)"
		find $VIRTUAL_ENV/lib/python3.6/site-packages/ -name "tests*"| xargs rm -r
		find $VIRTUAL_ENV/lib/python3.6/site-packages/ -name "dataset*" | xargs rm -r

		# Can't remove tests files from pandas
		pushd $VIRTUAL_ENV/lib/python3.6/site-packages/scipy/.libs && \
		      rm *; ln ../../numpy/.libs/* . && \
              rm -rf /root/.cache  ; popd

		find $VIRTUAL_ENV/lib/python3.6/site-packages/ -name "*.txt" | xargs rm -r
		find $VIRTUAL_ENV/lib/python3.6/site-packages/ -name "*.so" | grep -v ufuncs | grep -v fblas | grep -v flapack | \
                                                                    grep -v cython_blas | grep -v cython_lapack | grep -v ellip_harm | \
                                                                    grep -v odepack | grep -v quadpack | grep -v vode | grep -v lsoda | \
                                                                    grep -v iterative | grep -v superlu | grep -v arpack | grep -v trlib | \
                                                                    grep -v lbfgs | grep -v qhull | xargs strip
		find $VIRTUAL_ENV/lib/python3.6/site-packages/ -name "*.pyc" -delete
		find $VIRTUAL_ENV/lib/python3.6/site-packages/ -type d -empty -delete
		echo "current size $(du -sh $VIRTUAL_ENV | cut -f1)"
	    pushd $VIRTUAL_ENV/lib/python3.6/site-packages/ && zip -r -9 -q /outputs/lambda.zip scipy numpy sklearn pandas pytz lightgbm ; popd
	}

main () {
        apt-get update
        apt-get install zip unzip
		pip install virtualenv
		virtualenv -p /usr/local/bin/python \
			        --always-copy \
			        --no-site-packages \
			        lambda_build

		source lambda_build/bin/activate
    
    	do_pip

		
    	strip_virtualenv		

    	pip list
}

main

