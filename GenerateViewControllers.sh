#!/bin/sh

#  GenerateViewControllers.sh
#  iCare2
#
#  Created by Billy Bray on 9/15/14.
#  Copyright (c) 2014 Spartan Systems Inc. All rights reserved.
skip_view_controllers="false"
while getopts ":p" opt; do
    case $opt in
    p)
        skip_view_controllers="true";
    ;;
    \?)
        echo "Invalid option: -$OPTARG" >&2
        exit
    ;;
    esac
done

if ("$skip_view_controllers" == "true")
then
    echo "\nSkipping view controller generation...\n"
else
    for xmlFile in `ls | grep '.*\.xml'`;
    do
        name=${xmlFile%.xml}
        perl perlxml.pl $xmlFile >$name"ViewController.m";
        perl perlheader.pl $name > $name"ViewController.h";
    done
fi

echo "\nGenerating pdf code..."
perl perlpdf.pl `ls | grep '.*\.xml'` > "BBPdfSectionBuilder.m";
echo "\nDone!\n"