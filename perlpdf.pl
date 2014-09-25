#!/usr/bin/perl
use Data::Dumper;
use Switch;
use XML::LibXML;

$DEF_MARGIN = 8;

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

sub checkSizeAndMoveCursor{
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
    
    my $marginLR = 10;
    if ( $group->getAttribute("marginLR") ne "" ){
        $marginLR = $group->getAttribute("marginLR");
    }
    my $marginTB = 10;
    if ( $group->getAttribute("marginTB") ne "" ){
        $marginTB = $group->getAttribute("marginTB");
    }
    
    print "\t CGPoint ".$groupName."CursorStart = cursor;\n\n";
    print "\t int ".$groupName."Indentation = 0;\n";
    if ($group->getAttribute("label") ne ""){
        print "\t previousElementSize = [BBPdfGenerator drawText:\@\"".$group->getAttribute("label")."\" atLocation:cursor];\n";
        checkSizeAndMoveCursor($orientation,$groupName,$marginLR,$marginTB);
    }
    print "\t ".$groupName."Indentation = ".$indentation.";\n";
    print "\t cursor.x += ".$groupName."Indentation;\n";
    print "\t cursor.x += ".$marginLR.";\n\n";
    print "\t ".$groupName."CursorStart.x += ".$groupName."Indentation;\n";
    print "\t ".$groupName."CursorStart.x += ".$marginLR.";\n";
    
    
    foreach my $child ($group->getChildrenByLocalName("*")){
        if ( $child->nodeName eq "Group" ){
            printDrawSectionCodeForGroup($child, $section);
            
            checkSizeAndMoveCursor($orientation,$groupName,$DEF_MARGIN,$DEF_MARGIN);
        } elsif ( $child->nodeName eq "Element" ) {
            if ( $child->getAttribute("name") ne ""){
                my $xPath = '//Data/Element[@name="'.$child->getAttribute("name").'"]';
                my $nodeData = $child->find($xPath)->get_node(0);
                my $marginLR = $DEF_MARGIN;
                my $marginTB = $DEF_MARGIN;
                if (!(defined $nodeData)){
                    die "Can'f find data element for '".$child->getAttribute("name")."' in section ".$section->getAttribute("name");
                }
                switch ($nodeData->getAttribute("type")){
                    case "BooleanFormElement" {
                        print "\t cursorStartX = cursor.x;\n";
                        print "\t previousElementSize = [BBPdfGenerator drawCheckBoxChecked:[((BooleanFormElement*)[section getElementForKey:\@\"".$child->getAttribute("name")."Key\"]).value boolValue] atLocation:cursor];\n";
                        print "\t cursor.x += previousElementSize.width + ".$marginLR.";\n";
                        print "\t \n";
                        print "\t previousElementSize = [BBPdfGenerator drawText:\@\"".$child->getAttribute("label")."\" atLocation:cursor];\n";
                        print "\t cursor.x += previousElementSize.width + ".$marginLR.";\n";
                        print "\t previousElementSize.width = cursor.x - cursorStartX;\n";
                       
                    }
                    case "TextElement" {
                        print "\t cursorStartX = cursor.x;\n";
                        print "\t previousElementSize = [BBPdfGenerator drawText:\@\"".$child->getAttribute("label")."\" atLocation:cursor];\n";
                        print "\t cursor.x += previousElementSize.width + ".$marginLR.";\n";
                        print "\t \n";
                        print "\t previousElementSize = [BBPdfGenerator drawText:((TextElement*)[section getElementForKey:\@\"".$child->getAttribute("name")."Key\"]).value atLocation:cursor];\n";
                        print "\t cursor.x += previousElementSize.width + ".$marginLR.";\n";
                        print "\t previousElementSize.width = cursor.x - cursorStartX;\n";
                        
                    }
                    case "StringListElement" {
                        print "\t previousElementSize = [BBPdfGenerator drawText:\@\"".$child->getAttribute("label")."\" atLocation:cursor];\n";
                        checkSizeAndMoveCursor($orientation,$groupName,$marginTB,$marginLR);
                        
                        print "\t for (NSString *text in ((StringListElement*)[section getElementForKey:\@\"".$child->getAttribute("name")."Key\"]).value) {\n";
                        print "\t previousElementSize = [BBPdfGenerator drawText:text atLocation:cursor];\n";
                        checkSizeAndMoveCursor("vertical",$groupName,$marginTB,$marginLR);
                        print "\t }\n\n";
                    }
                    case "ElementListFormElement" {
                        print "\t previousElementSize = [BBPdfGenerator drawText:\@\"".$child->getAttribute("label")."\" atLocation:cursor];\n";
                        checkSizeAndMoveCursor($orientation,$groupName,$marginTB,$marginLR);
                        
                        switch ($nodeData->getAttribute("listOf")){
                            case "MedicationFormElement"{
                                print "\t for (MedicationFormElement *e in ((ElementListFormElement*)[section getElementForKey:\@\"".$child->getAttribute("name")."Key\"]).elements) {\n";
                                print "\t\t cursorStartX = cursor.x;\n";
                                print "\t\t previousElementSize = [BBPdfGenerator drawText:e.name atLocation:cursor];\n";
                                print "\t\t cursor.x += previousElementSize.width + ".$marginLR.";\n";
                                print "\t\t \n";
                                print "\t\t previousElementSize = [BBPdfGenerator drawText:e.dose atLocation:cursor];\n";
                                print "\t\t cursor.x += previousElementSize.width + ".$marginLR.";\n";
                                print "\t\t \n";
                                print "\t\t previousElementSize = [BBPdfGenerator drawText:e.doseUnit atLocation:cursor];\n";
                                print "\t\t cursor.x += previousElementSize.width + ".$marginLR.";\n";
                                print "\t\t previousElementSize.width = cursor.x - cursorStartX;\n";
                                if ( "vertical" eq "vertical" ){
                                    print "\t\t cursor.x = ".$groupName."CursorStart.x;\n";
                                }
                                checkSizeAndMoveCursor("vertical",$groupName,$marginTB,$marginLR);
                                print "\t }\n\n";
                            }
                            case "AntibioticFormElement"{
                                print "\t for (AntibioticFormElement *e in ((ElementListFormElement*)[section getElementForKey:\@\"".$child->getAttribute("name")."Key\"]).elements) {\n";
                                print "\t\t cursorStartX = cursor.x;\n";
                                print "\t\t previousElementSize = [BBPdfGenerator drawText:e.name atLocation:cursor];\n";
                                print "\t\t cursor.x += previousElementSize.width + ".$marginLR.";\n";
                                print "\t\t \n";
                                print "\t\t previousElementSize = [BBPdfGenerator drawText:e.dose atLocation:cursor];\n";
                                print "\t\t cursor.x += previousElementSize.width + ".$marginLR.";\n";
                                print "\t\t \n";
                                print "\t\t previousElementSize = [BBPdfGenerator drawText:e.doseUnit atLocation:cursor];\n";
                                print "\t\t cursor.x += previousElementSize.width + ".$marginLR.";\n";
                                print "\t\t \n";
                                print "\t\t [dateFormatter setDateFormat:\@\"HH:mm\"];\n";
                                print "\t\t previousElementSize = [BBPdfGenerator drawText:[dateFormatter stringFromDate:e.startTime] atLocation:cursor];\n";
                                print "\t\t cursor.x += previousElementSize.width + ".$marginLR.";\n";
                                print "\t\t previousElementSize.width = cursor.x - cursorStartX;\n";
                                if ( "vertical" eq "vertical" ){
                                    print "\t\t cursor.x = ".$groupName."CursorStart.x;\n";
                                }
                                checkSizeAndMoveCursor("vertical",$groupName,$marginTB,$marginLR);
                                print "\t }\n\n";
                            }
                            else { die "Unknown listOf type: ".$nodeData->getAttribute("listOf"); }
                        }
                    }
                    case "MedicationFormElement" {
                        print "\t cursorStartX = cursor.x;\n";
                        print "\t previousElementSize = [BBPdfGenerator drawCheckBoxChecked:[((MedicationFormElement*)[section getElementForKey:\@\"".$child->getAttribute("name")."Key\"]).selected boolValue] atLocation:cursor];\n";
                        print "\t cursor.x += previousElementSize.width + ".$marginLR.";\n";
                        print "\t \n";
                        print "\t previousElementSize = [BBPdfGenerator drawText:\@\"".$child->getAttribute("label")."\" atLocation:cursor];\n";
                        print "\t cursor.x += previousElementSize.width + ".$marginLR.";\n";
                        print "\t \n";
                        print "\t previousElementSize = [BBPdfGenerator drawText:((MedicationFormElement*)[section getElementForKey:\@\"".$child->getAttribute("name")."Key\"]).dose atLocation:cursor];\n";
                        print "\t cursor.x += previousElementSize.width + ".$marginLR.";\n";
                        print "\t \n";
                        print "\t previousElementSize = [BBPdfGenerator drawText:((MedicationFormElement*)[section getElementForKey:\@\"".$child->getAttribute("name")."Key\"]).doseUnit atLocation:cursor];\n";
                        print "\t cursor.x += previousElementSize.width + ".$marginLR.";\n";
                        print "\t previousElementSize.width = cursor.x - cursorStartX;\n";
                        
                    }
                    case "AntibioticFormElement" {
                        print "\t cursorStartX = cursor.x;\n";
                        print "\t previousElementSize = [BBPdfGenerator drawCheckBoxChecked:[((AntibioticFormElement*)[section getElementForKey:\@\"".$child->getAttribute("name")."Key\"]).selected boolValue] atLocation:cursor];\n";
                        print "\t cursor.x += previousElementSize.width + ".$marginLR.";\n";
                        print "\t \n";
                        print "\t previousElementSize = [BBPdfGenerator drawText:\@\"".$child->getAttribute("label")."\" atLocation:cursor];\n";
                        print "\t cursor.x += previousElementSize.width + ".$marginLR.";\n";
                        print "\t \n";
                        print "\t previousElementSize = [BBPdfGenerator drawText:((AntibioticFormElement*)[section getElementForKey:\@\"".$child->getAttribute("name")."Key\"]).dose atLocation:cursor];\n";
                        print "\t cursor.x += previousElementSize.width + ".$marginLR.";\n";
                        print "\t \n";
                        print "\t previousElementSize = [BBPdfGenerator drawText:((AntibioticFormElement*)[section getElementForKey:\@\"".$child->getAttribute("name")."Key\"]).doseUnit atLocation:cursor];\n";
                        print "\t cursor.x += previousElementSize.width + ".$marginLR.";\n";
                        print "\t \n";
                        print "\t NSDate *startTime = ((AntibioticFormElement*)[section getElementForKey:\@\"".$child->getAttribute("name")."Key\"]).startTime;\n";
                        print "\t [dateFormatter setDateFormat:\@\"HH:mm\"];\n";
                        print "\t \n";
                        print "\t previousElementSize = [BBPdfGenerator drawText:[dateFormatter stringFromDate:startTime] atLocation:cursor];\n";
                        print "\t cursor.x += previousElementSize.width + ".$marginLR.";\n";
                        print "\t previousElementSize.width = cursor.x - cursorStartX;\n";
                        
                    }
                    else { die "Unknown type: ".$nodeData->getAttribute("type"); }
                }
                if ( $orientation eq "vertical" ){
                    print "\t cursor.x = ".$groupName."CursorStart.x;\n";
                }
                checkSizeAndMoveCursor($orientation,$groupName,$marginTB,$marginLR);
            
            } else { #element is just a label
                my $marginLR = $DEF_MARGIN;
                my $marginTB = $DEF_MARGIN;
                print "\t previousElementSize = [BBPdfGenerator drawText:\@\"".$child->getAttribute("label")."\" atLocation:cursor];\n";
                checkSizeAndMoveCursor($orientation,$groupName,$marginTB,$marginLR);
            }
        } else {
            die "unknown node type: ".$child->nodeName;
        }
    }
    
    print "\t //end of draw ".$groupName."\n";
    print "\t ".$groupName."CursorStart.x -= ".$groupName."Indentation;\n";
    print "\t ".$groupName."CursorStart.x -= ".$marginLR.";\n";
    switch ($orientation){
        case "vertical" {
            print "\t previousElementSize = CGSizeMake(".$groupName."MaxWidth + ".$indentation.", cursor.y -".$groupName."CursorStart.y + $marginTB);\n";
        }
        case "horizontal"{
            print "\t previousElementSize = CGSizeMake(cursor.x - ".$groupName."CursorStart.x, ".$groupName."MaxHeight);\n";
        }
        else { print "\n Error: Unknown orientation: $orientation\n"; }
    }
    print "\t cursor = ".$groupName."CursorStart;\n\n";
    print "\t [BBUtil drawRect:CGRectMake(cursor.x,cursor.y,previousElementSize.width,previousElementSize.height) withRed:1.0 green:0.0 blue:0.0];\n"
    
}
print "\n\n";
print "#import \"BBPdfSectionBuilder.h\"\n";
print "#import \"FormSection.h\"\n";
print "#import \"FormElement.h\"\n";
print "#import \"FormGroup.h\"\n";
print "#import \"BooleanFormElement.h\"\n";
print "#import \"StringListElement.h\"\n";
print "#import \"AntibioticFormElement.h\"\n";
print "#import \"MedicationFormElement.h\"\n";
print "#import \"ElementListFormElement.h\"\n";
print "#import \"TextElement.h\"\n";
print "#import \"Form.h\"\n";
print "#import \"Operation.h\"\n";
print "#import \"Patient.h\"\n";
print "#import \"BBPdfGenerator.h\"\n";
print "#import \"BBUtil.h\"\n";


my $parser = XML::LibXML->new();
my @sections;

for my $i (0 .. $#ARGV){
    my $tree = $parser->parse_file($ARGV[$i]);
    my $root = $tree->getDocumentElement;
    @sections[$i] = $root;
}

#printElements(@sections[3]);

print "\@implementation BBPdfSectionBuilder : NSObject\n";
print "NSDateFormatter* dateFormatter;\n";
print "\n";
print "+(CGSize) drawSection:(FormSection*)section atLocation:(CGPoint)sectionOrigin\n";
print "{ \n";
print "\t if (!dateFormatter) {\n";
print "\t\t  dateFormatter = [[NSDateFormatter alloc] init];\n";
print "\t }\n";

$else = "";
for my $section (@sections){
    my $graphics = $section->getChildrenByLocalName("Graphics")->get_node(0);
    if (not (defined $graphics)) {
        next;
    }
    
        
    print "\t ".$else."if ([section.title isEqualToString:\@\"".$section->getAttribute("name")."SectionKey\"]){\n";
    print "\t\t return [BBPdfSectionBuilder draw".$section->getAttribute("name")."Section:section atLocation:sectionOrigin];\n";
    $else = "} else ";
}
print "\t } else {\n";
print "\t\t [NSException raise:\@\"UnhandledSection\" format:\@\"section title = '%\@'\",section.title];\n";
print "\t }\n";
print "\t return CGSizeZero;\n";
print "}\n";



for my $section (@sections){
    my $graphics = $section->getChildrenByLocalName("Graphics")->get_node(0);
    if (not (defined $graphics)) {
        next;
    }
    print "\n";
    print "+(CGSize) draw".$section->getAttribute("name")."Section:(FormSection*)section atLocation:(CGPoint)sectionOrigin\n";
    print "{\n";
    print "\t CGSize previousElementSize;\n";
    print "\t CGPoint cursor = sectionOrigin;\n";
    print "\t int cursorStartX;\n";
    
    my $graphics = $section->getChildrenByLocalName("Graphics")->get_node(0);
    
    if ((defined $graphics) && ($graphics->hasChildNodes)){
        foreach my $group ($graphics->getChildrenByLocalName("Group")){
            $groupNr=1;
            printDrawSectionCodeForGroup($group,$section);
        }
    } else {
        print  "\n\t Error: can't find Graphics object in section ".$section->getAttribute("name");
    }
    
    print "\t return previousElementSize;\n";
    print "}\n";
}
print "\@end";
print "\n";
print "\n";
print "\n";
print "\n";
print "\n";