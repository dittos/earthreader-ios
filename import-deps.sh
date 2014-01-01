#!/bin/sh
virtualenv tmpenv
tmpenv/bin/pip install EarthReader-Web
rm -rf build/python/lib/python2.7/site-packages/*
cp -r tmpenv/lib/python2.7/site-packages/ build/python/lib/python2.7/site-packages/
rm -rf tmpenv
