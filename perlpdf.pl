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

sub printMaxSizeCheck{
    my $orientation = $_[0];
    my $groupName = $_[1];
    my $marginTB = $_[2];
    my $marginLR = $_[3];
    
    switch ($orientation){
        case "vertical" {
            print "\t cursor.y += previousElementSize.height + ".$marginTB.";\n";
            print "\t if ( previousElementSize.width + ".$groupName."Indentation > ".$groupName."MaxWidth){\n";
            print "\t\t ".$groupName."MaxWidth = previousElementSize.width + ".$groupName."Indentation;\n";
            print "\t }\n\n";
        }
        case "horizontal"{
            print "\t cursor.x += previousElementSize.width + ".$marginLR.";\n";
            print "\t if ( previousElementSize.height + ".$groupName."Indentation > ".$groupName."MaxHeight){\n";
            print "\t\t ".$groupName."MaxHeight = previousElementSize.height + ".$groupName."Indentation;\n";
            print "\t }\n\n";
        }
        else { print "\n Error: Unknown orientation: $orientation\n"; }
    }

}

$groupNr = 1;
sub printDrawSectionCodeForGroup{
    my $group = $_[0];
    my $section = $_[1];
    my $groupName = "group".$groupNr;
    my $orientation = $group->getAttribute("orientation");
    
    $groupNr++;
    
    print "\t //start of draw ".$groupName."\n";
    print "\t CGPoint ".$groupName."CursorStart = cursor;\n";
    my $indentation = 0;
    if ( ( $orientation eq "vertical" ) && ($group->getAttribute("label") ne "") ){
        $indentation = 15;
    }
    switch ($orientation){
        case "vertical" {
            if ( $group->getAttribute("label") ne "" ){
                $indentation = 15;
            }
            print "\t int ".$groupName."MaxWidth = 0;\n";
        }
        case "horizontal"{
            print "\t int ".$groupName."MaxHeight = 0;\n\n";
        }
        else { print "\n Error: Unknown orientation: $orientation\n"; }
    }
    
    print "\t int ".$groupName."Indentation = ".$indentation.";\n";
    
    
    foreach my $child ($group->getChildrenByLocalName("*")){
        if ( $child->nodeName eq "Group" ){
            printDrawSectionCodeForGroup($child, $section);
            my $marginLR = 10;
            my $marginTB = 20;
            printMaxSizeCheck($orientation,$groupName,$marginTB,$marginLR);
        } elsif ( $child->nodeName eq "Element" ) {
            if ( $child->getAttribute("name") ne ""){
                my $xPath = '//Data/Element[@name="'.$child->getAttribute("name").'"]';
                my $nodeData = $child->find($xPath)->get_node(0);
                my $marginLR = 10;
                my $marginTB = 20;
                
                switch ($nodeData->getAttribute("type")){
                    case "BooleanFormElement" {
                        print "\t previousElementSize = [BBPdfGenerator drawCheckBoxChecked:[((BooleanFormElement*)[section getElementForKey:\@\"".$child->getAttribute("name")."Key\"]).value boolValue] atLocation:cursor];\n";
                        print "\t cursor.x += previousElementSize.width + ".$marginLR.";\n";
                        print "\t \n";
                        print "\t previousElementSize = [BBPdfGenerator drawText:\@\"".$child->getAttribute("label")."\" atLocation:cursor];\n";
                        if ( $orientation eq "vertical" ){
                            print "\t cursor.x = ".$groupName."CursorStart.x;\n";
                        }
                        printMaxSizeCheck($orientation,$groupName,$marginTB,$marginLR);
                    }
                    case "TextElement" {
                        print "\t previousElementSize = [BBPdfGenerator drawText:\@\"".$child->getAttribute("label")."\" atLocation:cursor];\n";
                        printMaxSizeCheck($orientation,$groupName,$marginTB,$marginLR);
                    }
                    case "StringListElement" {
                        print "\t previousElementSize = [BBPdfGenerator drawText:\@\"".$child->getAttribute("label")."\" atLocation:cursor];\n";
                        printMaxSizeCheck($orientation,$groupName,$marginTB,$marginLR);
                        
                        print "\t for (NSString *text in ((StringListElement*)[section getElementForKey:\@\"".$child->getAttribute("name")."Key\"]).value) {\n";
                        print "\t previousElementSize = [BBPdfGenerator drawText:text atLocation:cursor];\n";
                        printMaxSizeCheck($orientation,$groupName,$marginTB,$marginLR);
                        print "\t }\n\n";
                    }
                    else { die "Unknown type: ".$nodeData->getAttribute("type"); }
                }
            
            } else {
                my $marginLR = 10;
                my $marginTB = 20;
                print "\t previousElementSize = [BBPdfGenerator drawText:\@\"".$child->getAttribute("label")."\" atLocation:cursor];\n";
                printMaxSizeCheck($orientation,$groupName,$marginTB,$marginLR);
            }
        } else {
            die "unknown node type: ".$child->nodeName;
        }
    }
    
    print "\t //end of draw ".$groupName."\n";
    switch ($orientation){
        case "vertical" {
            print "\t \n";
        }
        case "horizontal"{
            print "\t previousElementSize = CGSizeMake(cursor.x - ".$groupName."CursorStart.x, ".$groupName."MaxHeight);\n";
        }
        else { print "\n Error: Unknown orientation: $orientation\n"; }
    }
    print "\t cursor = group1CursorStart;\n\n";
    
}
print "\n\n";
print "#import \"BBPdfSectionBuilder.h\"\n";
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

print "\@implementation BBPdfSectionBuilder : NSObject\n";
print "\n";
print "+(void) drawSection:(FormSection*)section atLocation:(CGPoint)sectionOrigin\n";
print "{\n";

$else = "";
for my $section (@sections){
    my $graphics = $section->getChildrenByLocalName("Graphics")->get_node(0);
    if (not (defined $graphics)) {
        next;
    }
    
        
    print "\t ".$else."if ([section.title isEqualToString:\@\"".$section->getAttribute("name")."SectionKey\"]){\n";
    print "\t\t [BBPdfSectionBuilder draw".$section->getAttribute("name")."Section:section atLocation:sectionOrigin];\n";
    $else = "} else ";
}
print "\t } else {\n";
print "\t\t [NSException raise:\@\"UnhandledSection\" format:\@\"section title = '%\@'\",section.title];\n";
print "\t }\n";
print "}\n";



for my $section (@sections){
    my $graphics = $section->getChildrenByLocalName("Graphics")->get_node(0);
    if (not (defined $graphics)) {
        next;
    }
    print "\n";
    print "+(void) draw".$section->getAttribute("name")."Section:(FormSection*)section atLocation:(CGPoint)sectionOrigin\n";
    print "{\n";
    print "\t CGSize previousElementSize;\n";
    print "\t CGPoint cursor = sectionOrigin;\n";
    
    my $graphics = $section->getChildrenByLocalName("Graphics")->get_node(0);
    
    if ((defined $graphics) && ($graphics->hasChildNodes)){
        foreach my $group ($graphics->getChildrenByLocalName("Group")){
            $groupNr=1;
            printDrawSectionCodeForGroup($group,$section);
        }
    } else {
        print  "\n\t Error: can't find Graphics object in section ".$section->getAttribute("name");
    }
    
    print "\t \n";
    print "}\n";
}
print "\@end";
print "\n";
print "\n";
print "\n";
print "\n";
print "\n";