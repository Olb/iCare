#!/usr/bin/perl

$viewControllerName = $ARGV[0]."ViewController";
print "\n\n";
print "#import <UIKit/UIKit.h>\n";
print "#import \"BBFormSectionDelegate.h\"\n";
print "#import \"FormSection.h\"\n\n";
print "\@interface ".$viewControllerName." : UIViewController\n";
print "\@property id <BBFormSectionDelegate> delegate;\n";
print "\@property FormSection * section;\n\n";
print "+(NSString*) sectionTitle;\n";
print "\@end\n";
