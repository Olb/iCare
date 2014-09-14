#!/usr/bin/perl

use XML::Simple;
use Data::Dumper;
use Switch;

$xml = new XML::Simple (KeyAttr=>[]);

$section = $xml->XMLin("PreOpActions.xml");

if ( ref $section->{Group} eq 'ARRAY'){
    @groups = @{$section->{Group}};
} else {
    @groups = ($section->{Group});
}

foreach $group (@groups){
    if ( ref $group->{Element} eq 'ARRAY'){
        foreach $element (@{$group->{Element}}){
            push(@elements, $element);
        }
    } else {
        push(@elements, $group->{Element});
    }
}
# include section

$viewControllerName = "BB".$section->{name}."ViewController";
print "#import \"".$viewControllerName.".h\"\n";
print "#import \"BBUtil.h\"\n";
print "#import \"FormSection.h\"\n";
print "#import \"FormElement.h\"\n";
print "#import \"FormGroup.h\"\n";
print "#import \"BBCheckBox.h\"\n";
print "#import \"BooleanFormElement.h\"\n";
print "#import \"StringListElement.h\"\n";
print "#import \"BBStringArrayTableAdapter.h\"\n\n";

# const section

print "NSString *const SECTION_TITLE = @\"$section->{name}SectionKey\";\n";

foreach $element (@elements){
    print "NSString *const \U$element->{name}\E_KEY = @\"$element->{name}Key\";\n";
}

print "\n";

# interface section

sub getOutletTypeFor{
    local $type;
    $type = $_[0];
    
    switch ($type){
        case "BooleanFormElement" { return "BBCheckBox"}
        else { die "Unknown type: $type"}
    }
}

sub printPropertiesForElement{
    local $element;
    $element = $_[0];
    
    switch($element->{type}){
        case "StringListElement" {
            print "\@property (weak, nonatomic) IBOutlet UITextField *".$element->{name}."TextField;\n";
            print "\@property (weak, nonatomic) IBOutlet UITableView *".$element->{name}."Table;\n";
            print "\@property (strong, nonatomic) BBStringArrayTableAdapter *".$element->{name}."TableAdapter;\n";
        }
        else {
            print "\@property (weak, nonatomic) IBOutlet ".getOutletTypeFor($element->{type})." *".$element->{name}.getOutletTypeFor($element->{type}).";\n";
        }
    }
    
}

print "\@interface ".$viewControllerName." () <BBStringArrayTableDelegate, UITextFieldDelegate>\n";

foreach $group (@groups)
{
    foreach $element (@elements){
        printPropertiesForElement($element);
    }
}

print "\@end\n\n";

# IMPLEMENTATION

# viewDidLoad

sub printTableInitializationForGroup{
    local $group;
    local @elements;
    $group = $_[0];

    if ( ref $group->{Element} eq 'ARRAY'){
        @elements = @{$group->{Element}};
    } else {
        @elements = ($group->{Element});
    }

    
}
print "\@implementation $viewControllerName\n";
print "- (void)viewDidLoad\n";
print "{\n";
print "\t[super viewDidLoad];\n";

foreach $element (@elements){
    if ($element->{type} eq "StringListElement"){
        print "\tself.".$element->{name}."TableAdapter = [[BBStringArrayTableAdapter alloc] init];\n";
        print "\tself.".$element->{name}."Table.dataSource = self.".$element->{name}."TableAdapter;\n";
        print "\tself.".$element->{name}."Table.delegate = self.".$element->{name}."TableAdapter;\n";
    }
}

print "[self validateSection:_section];\n";
print "if ([_section.groups count] == 1) {\n";
print "\n";
print "\n";
print "\n";

