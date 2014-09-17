#!/usr/bin/perl
use Data::Dumper;
use Switch;
use XML::LibXML;

$i = 0;
sub printElements{
    $i = $i + 1;
    my $root = $_[0];
    my $indent = "";

    for my $j (0 .. $i){
        $indent = $indent."  ";
    }

    print "\n$indent ".$root->nodeName;
    if ($root->hasAttributes){
        foreach $attr ($root->attributes){
            print " ".$attr->name."=\"".$attr->value."\"";
        }
    }
    foreach my $e ($root->getChildrenByLocalName('*')){
        printElements($e);
    }

    $i = $i - 1;
}

print "#import \"FormSection.h\"\n";
print "#import \"FormElement.h\"\n";
print "#import \"FormGroup.h\"\n";
print "#import \"BooleanFormElement.h\"\n";
print "#import \"StringListElement.h\"\n";
print "#import \"TextElement.h\"\n";
print "#import \"Form.h\"\n";
print "#import \"Operation.h\"\n";
print "#import \"Patient.h\"\n";
print "#import \"BBPdfGenerator.h\"\n";


my $parser = XML::LibXML->new();
my @sections;

for my $i (0 .. $#ARGV){
    my $tree = $parser->parse_file($ARGV[$i]);
    my $root = $tree->getDocumentElement;
    @sections[$i] = $root;
}

#printElements(@sections[3]);

print "\@implementation BBPdfSectionBuilder\n";
print "\n";
print "+(void) drawSection:(FormSection*)section atLocation:(CGPoint)sectionOrigin\n";
print "{\n";

$else = "";
for my $section (@sections){
    print "\t ".$else."if ([section.title isEqualToString:\@\"".$section->getAttribute("name")."SectionKey\"]){\n";
    print "\t\t [BBPdfSectionBuilder draw".$section->getAttribute("name")."Section:section atLocation:sectionOrigin];\n";
    $else = "} else ";
}
print "\t } else {\n";
print "\t\t [NSException raise:\@\"UnhandledSection\" format:\@\"section title = '%\@'\",section.title];\n";
print "\t }\n";
print "}\n";

sub printDrawSectionCodeForGroup{
    my $group = $_[0];
    
    
    
    
}

for my $section (@sections){
    print "\n";
    print "+(void) draw".$section->getAttribute("name")."Section:(FormSection*)section atLocation:(CGPoint)sectionOrigin\n";
    print "{\n";
    print "\t CGSize previousElementSize = CGSizeMake(0, 0);\n";
    print "\t CGPoint elementOrigin = sectionOrigin;\n";
    print "\t \n";
    print "\t \n";
    print "\t \n";
    print "\t \n";
    print "}\n";
}

print "\n";
print "\n";
print "\n";
print "\n";
print "\n";