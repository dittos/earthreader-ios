#!/bin/sh
cd earthreader-web
virtualenv tmpenv
tmpenv/bin/pip install .
cp -r tmpenv/lib/python2.7/site-packages/ ../build/python/lib/python2.7/site-packages/
rm -rf tmpenv
