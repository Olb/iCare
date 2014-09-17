#!/bin/sh

#  GenerateViewControllers.sh
#  iCare2
#
#  Created by Billy Bray on 9/15/14.
#  Copyright (c) 2014 Spartan Systems Inc. All rights reserved.


for xmlFile in `ls | grep '.*\.xml'`;
do
name=${xmlFile%.xml}
perl perlxml.pl $xmlFile >& $name"ViewController.m";
perl perlheader.pl $name >& $name"ViewController.h";
done

perl perlpdf.pl `ls | grep '.*\.xml'`
