#!/usr/bin/perl

#use module
use XML::Simple;
use Data::Dumper;

#create object
$xml = new XML::Simple (KeyAttr=>[]);

#read XML file
$data = $xml->XMLin("PreOpActions.xml");

$section = $data;

$group = $section->{Group};

$viewControllerName = "BB".$section->{name}."ViewController";
print "#import ".$viewControllerName.".h\n";
print "#import BBUtil.h\n";
print "#import FormSection.h\n"
print "#import FormElement.h\n"
print "#import FormGroup.h\n"
print "#import BBCheckBox.h\n"
print "#import BooleanFormElement.h\n"
print "#import StringListElement.h\n"
print "#import BBStringArrayTableAdapter.h\n\\n"

foreach $e (@{$group->{Element}})
{
	print "$e->{name} type: $e->{type} \n";
}
