#!/usr/bin/perl



use XML::Simple;
use Data::Dumper;
use Switch;

sub getOutletNameForElement {
    local $element;
    $element = $_[0];
    
    return "\l$element->{name}".getOutletTypeFor($element->{type},$_[1]);
}
sub getKeyConstantForElement{
    local $element;
    $element = $_[0];
    
    local $name;
    $name = $element->{name};
    $name =~ s/((?<=[a-z])[A-Z][a-z]+)/_\U$1/g;
    $name =~ s/(\b[A-Z][a-z]+)/\U$1/g;
    
    return $name."_KEY";
}

sub getOutletTypeFor{
    local $type;
    $type = $_[0];
    
    switch ($type){
        case "BooleanFormElement" { return "BBCheckBox"}
        case "StringListElement" {
            switch ($_[1]){
                case "TEXT_FIELD" { return "TextField"}
                case "TABLE" { return "Table"}
                case "ADAPTER" { return "TableAdapter"}
                else { die "Unknown StringListElement outlet type: '$_[1]'"}
            }
        }
        else { die "Unknown type: '$type'"}
    }
    
}

sub printPropertiesForElement{
    local $element;
    $element = $_[0];
    
    switch($element->{type}){
        case "StringListElement" {
            print "\@property (weak, nonatomic) IBOutlet UITextField *".getOutletNameForElement($element,"TEXT_FIELD").";\n";
            print "\@property (weak, nonatomic) IBOutlet UITableView *".getOutletNameForElement($element,"TABLE").";\n";
            print "\@property (strong, nonatomic) BBStringArrayTableAdapter *".getOutletNameForElement($element,"ADAPTER").";\n";
        }
        else {
            print "\@property (weak, nonatomic) IBOutlet ".getOutletTypeFor($element->{type})." *".getOutletNameForElement($element).";\n";
        }
    }
    
}



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
    print "NSString *const ".getKeyConstantForElement($element)." = @\"$element->{name}Key\";\n";
}

print "\n";

# interface section

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
print "\n";
print "- (void)viewDidLoad\n";
print "{\n";
print "\t [super viewDidLoad];\n";

foreach $element (@elements){
    if ($element->{type} eq "StringListElement"){
        print "\t self.".getOutletNameForElement($element, "ADAPTER")." = [[BBStringArrayTableAdapter alloc] init];\n";
        print "\t self.".getOutletNameForElement($element, "TABLE").".dataSource = self.".getOutletNameForElement($element, "ADAPTER").";\n";
        print "\t self.".getOutletNameForElement($element, "TABLE").".delegate = self.".getOutletNameForElement($element, "ADAPTER").";\n\n";
    }
}

print "\t [self validateSection:_section];\n";
print "\t NSArray *elements = [_section allElements];\n\n";
print "\t for (FormElement *element in elements) {\n";
foreach $element (@elements) {
    switch ($element->{type}) {
        case "BooleanFormElement" {
            print "\t\t if ([element.key isEqualToString:".getKeyConstantForElement($element)."]){\n";
            print"\t\t\t [self.".getOutletNameForElement($element)." [((BooleanFormElement*)element).value boolValue]];\n";
            print "\t\t }\n";
        }
        case "StringListElement" {
            print "\t\t if ([element.key isEqualToString:".getKeyConstantForElement($element)."]){\n";
            print "\t\t\t self.".getOutletNameForElement($element,"ADAPTER").".items = [[NSMutableArray alloc] initWithArray:((StringListElement*)element).value];\n";
            print "\t\t\t [self.".getOutletNameForElement($element,"TABLE")." reloadData];\n";
            print "\t\t }\n";
        }
    }
}
print "\t }\n";
print "}\n";
print "\n";

# validateSection

print "-(void)validateSection:(FormSection*)section\n";
print "{\n";
print "\t if (_section) {\n";
print "\t\t int count;\n";
print "\t\t NSString *errMsg;\n";
print "\t\t \n";
print "\t\t count = [_section.groups count]\n";
print "\t\t errMsg =[NSString stringWithFormat:\@\"Invalid number of groups '%d'. Expected '1'.\", count];\n";
print "\t\t NSAssert(count, errMsg);\n";
print "\t\t \n";
print "\t\t FormGroup *group;\n";
print "\t\t \n";
foreach $group (@groups){
    print "\t\t group = [_section.groups objectAtIndex:0];\n";

    if ( ref $group->{Element} eq 'ARRAY'){
        @elems = @{$group->{Element}};
    } else {
        @elems = ($group->{Element});
    }
    
    foreach $element (@elems){
        print "\t\t NSAssert([group getElementForKey:".getKeyConstantForElement($element)."]!= nil, \@\"".$element->{name}." is nil\");\n";
    }
    print "\t\t \n";
}
print "\t }\n";
print "}\n";
print "\n";

# form accept function

print "- (IBAction)accept:(id)sender {\n";
print "\t if ( !self.section ){\n";
print "\t\t self.section = (FormSection*)[BBUtil newCoreDataObjectForEntityName:\@\"FormSection\"];\n";
print "\t\t self.section.title = SECTION_TITLE;\n";
print "\t }\n";
print "\t \n";
print "\t FormGroup *group;\n";
print "\t \n";
foreach my $i (0 .. $#groups){
    print "\t group = [self.section.groups objectAtIndex:$i];\n";
    print "\t if ( !group ){\n";
    print "\t\t group =(FormGroup*)[BBUtil newCoreDataObjectForEntityName:\@\"FormGroup\"];\n";
    print "\t\t [self.section addGroupsObject:group];\n";
    print "\t }\n";
    
    if ( ref @groups[$i]->{Element} eq 'ARRAY'){
        @elems = @{@groups[$i]->{Element}};
    } else {
        @elems = (@groups[$i]->{Element});
    }
    
    foreach $element (@elems){
#        print "Group: \n".Dumper($group);
#        print "Element: \n".Dumper($element);
#        print "\n\@elems: \n".Dumper(@elems);
        my $type = $element->{type};
        my $name = "\l$element->{name}";
        my $key = getKeyConstantForElement($element);
        print "\t $type *$name = ($type*)[group getElementForKey:$key];\n";
        print "\t if (!$name) {\n";
        print "\t\t $name = ($type*)[BBUtil newCoreDataObjectForEntityName:\@\"$type\"];\n";
        print "\t\t $name.key = $key;\n";
        print "\t\t [group addElementsObject:$name];\n";
        print "\t }\n\n";
        switch ($element->{type}){
            
            case "BooleanFormElement" {
                print "\t $name.value = [NSNumber numberWithBool:self.".getOutletNameForElement($element).".isSelected];\n";
            }
            case "StringListElement" {
                my $arrayName = $name."StringArray";
                print "\t NSMutableArray *$arrayName = [[NSMutableArray alloc] init];\n";
                print "\t for (int i = 0; i < [self.".getOutletNameForElement($element,"TABLE")." numberOfRowsInSection:0]; i++){\n";
                print "\t\t UITableViewCell *cell = [self.".getOutletNameForElement($element,"TABLE")." cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];\n";
                print "\t\t [$arrayName addObject:cell.textLabel.text];\n";
                print "\t }\n";
                print "\t stringListElement.value = $arrayName;\n";
            }
            else {
                die "Unhandled element type '".$element->{type}."'";
            }
        }
        print "\t \n";
        
    }
}
print "\t [self.delegate sectionCreated:self.section];\n";
print "\t [self dismissViewControllerAnimated:YES completion:nil];\n";
print "}\n\n";


# table add button handlers

foreach $element (@elements){
    if ($element->{type} eq "StringListElement"){
        print "- (IBAction)add$element->{name}:(id)sender {\n";
        print "\t [self.".getOutletNameForElement($element,"ADAPTER").".items addObject:self.".getOutletNameForElement($element,"TEXT_FIELD").".text];\n";
        print "\t [self.".getOutletNameForElement($element,"TABLE")." reloadData];\n";
        print "\t self.".getOutletNameForElement($element,"TEXT_FIELD").".text = \@\"\";\n";
        print "\t [self.".getOutletNameForElement($element,"TEXT_FIELD")." resignFirstResponder];\n";
        print "}\n\n";
    }
}



print "- (BOOL)disablesAutomaticKeyboardDismissal {\n";
print "\t return NO;\n";
print "}\n\n";


print "\- (IBAction)dismiss:(id)sender {n";
print "\t [self dismissViewControllerAnimated:YES completion:nil];\n";
print "}\n\n";



