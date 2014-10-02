#!/usr/bin/perl 
use Cwd qw();
use XML::Simple;
use Data::Dumper;
use Switch;

sub getOutletNameForElement {
    local $element;
    $element = $_[0];
    
    return "\l$element->{name}".getOutletTypeForElement($element,$_[1]);
}

sub camelCaseToUppercase{
    local $res;
    $res = $_[0];
    $res =~ s/((?<=[a-z])[A-Z][a-z]+)/_\U$1/g;
    $res =~ s/(\b[A-Z][a-z]+)/\U$1/g;
    return $res;
}

sub getKeyConstantForElement{
    local $element;
    $element = $_[0];
    
    return camelCaseToUppercase($element->{name})."_KEY";
}

sub getOutletTypeForElement{
    local $element;
    $element = $_[0];
    
    switch ($element->{type}){
        case "BooleanFormElement" { return "BBCheckBox"}
        case "StringListElement" {
            switch ($_[1]){
                case "TEXT_FIELD" { return "TextField"}
                case "TABLE" { return "Table"}
                case "ADAPTER" { return "TableAdapter"}
                else { die "Unknown StringListElement outlet type: '$_[1]'"}
            }
        }
        case "AntibioticFormElement" {
            switch($_[1]){
                case "NAME" { return "UITextField" }
                case "DOSE" { return "UITextField" }
                case "DOSE_UNIT" { return "UITextField" }
                case "START_TIME" { return "UITextField" }
                else {die "Unknown AntibioticFormElement outlet type: '$_[1]'";}
            }
        }
        case "MedicationFormElement" {
            switch($_[1]){
                case "DOSE" { return "UITextField" }
                case "CHECKBOX" { return "BBCheckBox" }
                else {die "Unknown MedicationFormElement outlet type: '$_[1]'";}
            }
        }
        case "ElementListFormElement"{
            switch ($element->{listOf}) {
                case "AntibioticFormElement" {
                    switch($_[1]){
                        case "NAME" { return "NameTextField" }
                        case "DOSE" { return "DoseTextField" }
                        case "DOSE_UNIT" { return "DoseUnitButton" }
                        case "START_TIME" { return "StartTimeTextField" }
                    }
                }
                case "MedicationFormElement" {
                    switch($_[1]){
                        case "NAME" { return "NameTextField" }
                        case "DOSE" { return "DoseTextField" }
                        case "DOSE_UNIT" { return "DoseUnitButton" }
                    }
                }
                else {
                    die "Unhandled ElementListFormElement type'".$element->{listOf}."'";
                }
            }
            switch($_[1]){
                case "TABLE" { return "Table" }
                case "ADAPTER" { return "TableAdapter" }
                else {die "Unknown ElementListFormElement outlet type: '$_[1]'";}
            }
        }
        case "TextElement" { return "UITextField" }
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
            print "\@property (strong, nonatomic) StringArrayTableAdapter *".getOutletNameForElement($element,"ADAPTER").";\n";
        }
        case "ElementListFormElement" {
            print "\@property (weak, nonatomic) IBOutlet UITableView *".getOutletNameForElement($element,"TABLE").";\n";
            print "\@property (strong, nonatomic) FormElementTableAdapter *".getOutletNameForElement($element,"ADAPTER").";\n";
            switch ( $element->{listOf} ){
                case "AntibioticFormElement" {
                    print "\@property (weak, nonatomic) IBOutlet UITextField *".getOutletNameForElement($element,"NAME").";\n";
                    print "\@property (weak, nonatomic) IBOutlet UITextField *".getOutletNameForElement($element,"DOSE").";\n";
                    print "\@property (weak, nonatomic) IBOutlet UIButton *".getOutletNameForElement($element,"DOSE_UNIT").";\n";
                    print "\@property (weak, nonatomic) IBOutlet UITextField *".getOutletNameForElement($element,"START_TIME").";\n";
                }
                case "MedicationFormElement" {
                    print "\@property (weak, nonatomic) IBOutlet UITextField *".getOutletNameForElement($element,"NAME").";\n";
                    print "\@property (weak, nonatomic) IBOutlet UITextField *".getOutletNameForElement($element,"DOSE").";\n";
                    print "\@property (weak, nonatomic) IBOutlet UIButton *".getOutletNameForElement($element,"DOSE_UNIT").";\n";
                }
            }
        }
        case "AntibioticFormElement" {
            print "\@property (weak, nonatomic) IBOutlet UITextField *".getOutletNameForElement($element,"NAME").";\n";
            print "\@property (weak, nonatomic) IBOutlet UITextField *".getOutletNameForElement($element,"DOSE").";\n";
            print "\@property (weak, nonatomic) IBOutlet UIButton *".getOutletNameForElement($element,"DOSE_UNIT").";\n";
            print "\@property (weak, nonatomic) IBOutlet UITextField *".getOutletNameForElement($element,"START_TIME").";\n";
        }
        case "MedicationFormElement" {
            print "\@property (weak, nonatomic) IBOutlet BBCheckBox *".getOutletNameForElement($element,"CHECKBOX").";\n";
            print "\@property (weak, nonatomic) IBOutlet UITextField *".getOutletNameForElement($element,"DOSE").";\n";
        }
        else {
            print "\@property (weak, nonatomic) IBOutlet ".getOutletTypeForElement($element)." *".getOutletNameForElement($element).";\n";
        }
    }
    
}


print "\n";

$xml = new XML::Simple (KeyAttr=>[]);

$section = $xml->XMLin($ARGV[0]);
$section_title = camelCaseToUppercase($section->{name})."_SECTION_TITLE";#BETA_BLOCKER_SECTION_TITLE
$asd = $section->{name};

if (not (exists $section->{Data})) {
    die "No data element on section ".$asd."\n";
} else {
    print STDERR "Generating code for section '".$asd."'\n";
}

if (ref $section->{Data}->{Element} eq "ARRAY"){
    @elements = @{$section->{Data}->{Element}};
} else {
    @elements = ($section->{Data}->{Element});
}

if (ref $section->{Validation}->{Rule} eq "ARRAY"){
    @rules = @{$section->{Validation}->{Rule}};
} else {
    @rules = ($section->{Validation}->{Rule});
}

if (ref $section->{Validation}->{RadioButtons} eq "ARRAY"){
    @radioButtons = @{$section->{Validation}->{RadioButtons}};
} else {
    @radioButtons = ($section->{Validation}->{RadioButtons});
}

sub getDataElementForName{
    my $name = $_[0];
    
    foreach my $elem (@elements){
        if ( $name eq $elem->{name}){
            return $elem;
        }
    }
    
    die "Can't find element with name: '".$name."'";
}

# include section

$viewControllerName = $section->{name}."ViewController";
print "#import \"".$viewControllerName.".h\"\n";
print "#import \"BBUtil.h\"\n";
print "#import \"FormSection.h\"\n";
print "#import \"FormElement.h\"\n";
print "#import \"BBCheckBox.h\"\n";
print "#import \"BooleanFormElement.h\"\n";
print "#import \"StringListElement.h\"\n";
print "#import \"TextElement.h\"\n";
print "#import \"StringArrayTableAdapter.h\"\n\n";
print "#import \"ElementListFormElement.h\"\n\n";
print "#import \"FormElementTableAdapter.h\"\n\n";
print "#import \"FormElementTableCellFactory.h\"\n\n";
print "#import \"AntibioticFormElement.h\"\n\n";
print "#import \"MedicationFormElement.h\"\n\n";
print "\n";

# interface section

print "\@interface ".$viewControllerName." () <UITextFieldDelegate>\n";
foreach my $element (@elements){
    printPropertiesForElement($element);
}

print "\@end\n\n";

# IMPLEMENTATION

print "\@implementation $viewControllerName\n";

# const section

print "NSString *const $section_title = @\"$section->{name}SectionKey\";\n";

foreach $element (@elements){
    print "static NSString *const ".getKeyConstantForElement($element)." = @\"$element->{name}Key\";\n";
}

# viewDidLoad

print "\n";
print "- (void)viewDidLoad\n";
print "{\n";
print "\t [super viewDidLoad];\n";

$radioGroup = 0;
foreach $button (@radioButtons) {
    my @elems;
    $radioGroup++;
    if (ref $button->{Element} eq "ARRAY"){
        @elems = @{$button->{Element}};
    } else {
        @elems = ($button->{Element});
    }
    
    foreach $elem (@elems) {
        if ( ! defined $elem ){
            print STDERR "Undefind element in radiogroup\n";
            next;
        }
        print STDERR Dumper($elem);
        my $dataElement = getDataElementForName($elem->{name});
        print "\t [self.".getOutletNameForElement($dataElement)." addTarget:self action:\@selector(radioGroup".$radioGroup.":) forControlEvents:UIControlEventTouchUpInside];\n";
    }
}

foreach $element (@elements){
    if ($element->{type} eq "StringListElement"){
        print "\t self.".getOutletNameForElement($element, "ADAPTER")." = [[StringArrayTableAdapter alloc] init];\n";
        print "\t self.".getOutletNameForElement($element, "TABLE").".dataSource = self.".getOutletNameForElement($element, "ADAPTER").";\n";
        print "\t self.".getOutletNameForElement($element, "TABLE").".delegate = self.".getOutletNameForElement($element, "ADAPTER").";\n\n";
    } elsif ( $element->{type} eq "ElementListFormElement" ) {
        print "\t self.".getOutletNameForElement($element, "ADAPTER")." = [[FormElementTableAdapter alloc] init];\n";
        print "\t self.".getOutletNameForElement($element, "TABLE").".dataSource = self.".getOutletNameForElement($element, "ADAPTER").";\n";
        print "\t self.".getOutletNameForElement($element, "TABLE").".delegate = self.".getOutletNameForElement($element, "ADAPTER").";\n\n";
    }
}
print "\t if (_section) {\n";
print "\t\t [self validateSection:_section];\n";
print "\t\t NSArray *elements = [_section.elements array];\n\n";
print "\t\t for (FormElement *element in elements) {\n";
foreach $element (@elements) {
    switch ($element->{type}) {
        case "BooleanFormElement" {
            print "\t\t\t if ([element.key isEqualToString:".getKeyConstantForElement($element)."]){\n";
            print"\t\t\t\t [self.".getOutletNameForElement($element)." setSelected:[((BooleanFormElement*)element).value boolValue]];\n";
            print "\t\t\t }\n";
        }
        case "StringListElement" {
            print "\t\t\t if ([element.key isEqualToString:".getKeyConstantForElement($element)."]){\n";
            print "\t\t\t\t self.".getOutletNameForElement($element,"ADAPTER").".items = [[NSMutableArray alloc] initWithArray:((StringListElement*)element).value];\n";
            print "\t\t\t\t [self.".getOutletNameForElement($element,"TABLE")." reloadData];\n";
            print "\t\t\t }\n";
        }
        case "TextElement" {
            print "\t\t\t if ([element.key isEqualToString:".getKeyConstantForElement($element)."]){\n";
            print "\t\t\t\t [self.".getOutletNameForElement($element)." setText:((TextElement*)element).value];\n";
            print "\t\t\t }\n";
        }
        case "ElementListFormElement" {
            print "\t\t\t if ([element.key isEqualToString:".getKeyConstantForElement($element)."]){\n";
            print "\t\t\t\t self.".getOutletNameForElement($element,"ADAPTER").".items = [[((ElementListFormElement*)element).elements allObjects] mutableCopy];\n";
            print "\t\t\t\t [self.".getOutletNameForElement($element,"TABLE")." reloadData];\n";
            print "\t\t\t }\n";
        }
        case "MedicationFormElement" {
            print "\t\t\t if ([element.key isEqualToString:".getKeyConstantForElement($element)."]){\n";
            print"\t\t\t\t [self.".getOutletNameForElement($element, "CHECKBOX")." setSelected:[((MedicationFormElement*)element).selected boolValue]];\n";
            print "\t\t\t\t [self.".getOutletNameForElement($element, "DOSE")." setText:((MedicationFormElement*)element).dose];\n";
            print "\t\t\t }\n";
        }
    }
}

print "\t\t }\n";
print "\t }\n";
print "}\n";
print "\n";

sub getCodeForCondition {
    my $elem = $_[0];
    if ( ! defined $elem ){
        die "elem is undefined";
    }
    my $elemData = getDataElementForName($elem->{name});
    
    switch ($elemData->{type}){
        case "BooleanFormElement" {
            switch ($elem->{value}){
                case "true"{
                    return "self.".getOutletNameForElement($elemData).".selected";
                }
                case "false"{
                    return "(!self.".getOutletNameForElement($elemData).".selected)";
                }
                else {
                    die "Invalid value: '".$elem->{value}."'";
                }
            }
        }
        case "TextElement" {
            switch ($elem->{value}){
                case "NotEmpty"{
                    return "![self.".getOutletNameForElement($elemData).".text isEqualToString:\@\"\"]";
                }
                else {
                    die "Invalid value: '".$elem->{value}."'";
                }
            }
        }
        else {
            die "Element type '".$elemData->{type}."' is not handled";
        }
    }
}

sub getTextForCondition {
    my $elem = $_[0];
    my $verb = $_[1];
    
    if ( ! defined $elem ){
        die "elem is undefined";
    }
    my $elemData = getDataElementForName($elem->{name});
    
    switch ($elemData->{type}){
        case "BooleanFormElement" {
            switch ($elem->{value}){
                case "true"{
                    return $elem->{name}." ".$verb." selected";
                }
                case "false"{
                    return $elem->{name}." ".$verb." unselected";
                }
                else {
                    die "Invalid value: '".$elem->{value}."'";
                }
            }
        }
        case "TextElement" {
            switch ($elem->{value}){
                case "NotEmpty"{
                    return $elem->{name}." ".$verb." not empty";
                }
                else {
                    die "Invalid value: '".$elem->{value}."'";
                }
            }
        }
        else {
            die "Element type '".$elemData->{type}."' is not handled";
        }
    }
}



# validateSection

print "-(void)validateSection:(FormSection*)section\n";
print "{\n";

foreach $element (@elements){
    print "\t NSAssert([section getElementForKey:".getKeyConstantForElement($element)."]!= nil, \@\"".$element->{name}." is nil\");\n";
}

print "\t \n";
print "}\n";
print "\n";

print "-(BOOL)validateData:(NSString**)errMsg\n";
print "{\n";

foreach $elem (@elements) {
   
    switch ($elem->{type}) {
        case "MedicationFormElement" {
            print "\t if (self.".getOutletNameForElement($elem, "CHECKBOX").".selected && [self.".getOutletNameForElement($elem, "DOSE").".text isEqualToString:\@\"\"]) {\n";
            print "\t\t *errMsg = \@\"".$elem->{name}." must have a dose value\";\n";
            print "\t\t return false;\n";
            print "\t }\n";
        }
    }
}
foreach $rule (@rules) {
    if ( ! defined $rule ){
        print STDERR "Warning: Skipping validation for section ".$section->{name}."\n";
        next;
    }
    my $condition = $rule->{Condition};
    my $operatorText = $condition->{operator};
    my $operator;
    switch ($operatorText){
        case "or"  { $operator = "||"; }
        case "and" { $operator = "&&"; }
        else       {
            $operator = "&&";
            $operatorText = "and";
        }
    }
    my @elems;
    
    if (ref $condition->{Element} eq "ARRAY"){
        @elems = @{$condition->{Element}};
    } else {
        @elems = ($condition->{Element});
    }
    
    if ( scalar @elems == 0 ){
        print STDERR Dumper($rule);
        die "Condition must have at least one element";
    }
    
    my $conditionsCode = getCodeForCondition( @elems[0] );
    my $conditionsText = getTextForCondition( @elems[0], "is");
    
    if ( @elems > 1 ){
        foreach my $i (1 .. $#elems){
            $conditionsCode .= " ".$operator." ".getCodeForCondition( @elems[$i] );
            $conditionsText .= " ".$operatorText." ".getTextForCondition( @elems[$i], "is");
        }
    }
    
    if (ref $rule->{Action} eq "ARRAY"){
        @actions = @{$rule->{Action}};
    } else {
        @actions = ($rule->{Action});
    }
    
    if ( scalar @elems == 0 ){
        die "Action must have at least one element";
    }
    
    print "\t if( ".$conditionsCode." ){ \n";
    foreach $action (@actions) {
        if (ref $action->{Element} eq "ARRAY"){
            @elems = @{$action->{Element}};
        } else {
            @elems = ($action->{Element});
        }
        switch ($action->{type}){
            case "check"{
                my $operatorText = $action->{operator};
                my $operator;
                switch ($operatorText){
                    case "or"  { $operator = "||"; }
                    case "and" { $operator = "&&"; }
                    else       {
                        $operator = "&&";
                        $operatorText = "and";
                    }
                }
                my $checkCode = getCodeForCondition( @elems[0] );
                my $checkText = getTextForCondition( @elems[0], "must be" );
                
                if ( @elems > 1 ){
                    foreach my $i (1 .. $#elems){
                        $checkCode .= " ".$operator." ".getCodeForCondition( @elems[$i] );
                        $checkText .= " ".$operatorText." ".getTextForCondition( @elems[$i], "must be");
                    }
                }
                
                $checkText .= " when ".$conditionsText;
                
                print "\t\t if( !(".$checkCode.") ){ \n";
                print "\t\t\t *errMsg = \@\"".$checkText."\"; \n";
                print "\t\t\t return false; \n";
                print "\t\t }\n";
            }
            else {
                die "Unknown action type '".$rule->{Action}->{type}."'";
            }
        }
    }
    
    print "\t }\n";
}

print "\t return true; \n";
print "}\n";
print "\n";

# form accept function

print "- (IBAction)accept:(id)sender {\n";
print "\t NSString* errMsg;\n";
print "\t if ( ! [self validateData: &errMsg] ){\n";
print "\t\t [BBUtil showAlertWithMessage:errMsg];\n";
print "\t\t return;\n";
print "\t }\n";

print "\t if ( !self.section ){\n";
print "\t\t self.section = (FormSection*)[BBUtil newCoreDataObjectForEntityName:\@\"FormSection\"];\n";
print "\t\t self.section.title = $section_title;\n";
print "\t }\n";
print "\t \n";

foreach $element (@elements){
    my $type = $element->{type};
    my $name = "\l$element->{name}";
    my $key = getKeyConstantForElement($element);
    print "\t $type *$name = ($type*)[_section getElementForKey:$key];\n";
    print "\t if (!$name) {\n";
    print "\t\t $name = ($type*)[BBUtil newCoreDataObjectForEntityName:\@\"$type\"];\n";
    print "\t\t $name.key = $key;\n";
    print "\t\t [_section addElementsObject:$name];\n";
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
            print "\t $name.value = $arrayName;\n";
        }
        case "ElementListFormElement" {
            my $arrayName = $name."ElementListArray";
            print "\t NSMutableSet *$arrayName = [[NSMutableSet alloc] init];\n";
            print "\t for (int i = 0; i < [self.".getOutletNameForElement($element,"TABLE")." numberOfRowsInSection:0]; i++){\n";
            print "\t\t UITableViewCell *cell = [self.".getOutletNameForElement($element,"TABLE")." cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];\n";
            switch ($element->{listOf}){
                case "AntibioticFormElement" {
                    print "\t\t AntibioticFormElement *elementListFormElement = [FormElementTableCellFactory getElementForAntibioticCell:cell withElement:nil];";
                }
                case "MedicationFormElement" {
                    print "\t\t MedicationFormElement *elementListFormElement = [FormElementTableCellFactory getElementForMedicationCell:cell withElement:nil];";
                }
                else {
                    die "Unhandled ElementListFormElement type'".$element->{listOf}."'";
                }
            }
            print "\t\t [$arrayName addObject:elementListFormElement];\n";
            print "\t }\n";
            print "\t for (FormElement *element in $name.elements) {\n";
            print "\t\t [BBUtil deleteManagedObject:element];\n";
            print "\t }\n";
            print "\t [[$name mutableSetValueForKey:\@\"elements\"] removeAllObjects];\n";
            print "\t [$name addElements:$arrayName];\n";
        }
        case "TextElement" {
            print "\t $name.value = self.".getOutletNameForElement($element).".text;\n";
        }
        case "MedicationFormElement" {
            print "\t $name.selected = [NSNumber numberWithBool:self.".getOutletNameForElement($element, "CHECKBOX").".isSelected];\n";
            print "\t $name.dose = self.".getOutletNameForElement($element, "DOSE").".text;\n";
            print "\t $name.name = \@\"".$element->{name}."\";\n";
            print "\t $name.doseUnit = \@\"".$element->{doseUnit}."\";\n";
        }
        else {
            die "Unhandled element type '".$element->{type}."'";
        }
    }
    print "\t \n";
    
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
    if ($element->{type} eq "ElementListFormElement"){
        switch ($element->{listOf}) {
            case "AntibioticFormElement" {
                print "- (IBAction)add$element->{name}:(id)sender {\n";
                print "\t AntibioticFormElement *formElement = (AntibioticFormElement*)[BBUtil newCoreDataObjectForEntityName:\@\"AntibioticFormElement\"];\n";
                print "\t formElement.name = self.".getOutletNameForElement($element,"NAME").".text;\n";
                print "\t formElement.dose = self.".getOutletNameForElement($element,"DOSE").".text;\n";
                print "\t formElement.doseUnit = self.".getOutletNameForElement($element,"DOSE_UNIT").".titleLabel.text;\n";
                print "\t NSDateFormatter *formatter = [[NSDateFormatter alloc] init];\n";
                print "\t [formatter setDateFormat:\@\"HH:mm\"];\n";
                print "\t NSDate *date = [formatter dateFromString:self.".getOutletNameForElement($element,"START_TIME").".text];\n";
                print "\t formElement.startTime = date;\n";
                print "\t [self.".getOutletNameForElement($element,"ADAPTER").".items addObject:formElement];\n";
                print "\t [self.".getOutletNameForElement($element,"TABLE")." reloadData];\n";
                print "\t self.".getOutletNameForElement($element,"NAME").".text = \@\"\";\n";
                print "\t self.".getOutletNameForElement($element,"DOSE").".text = \@\"\";\n";
                print "\t self.".getOutletNameForElement($element,"START_TIME").".text = \@\"\";\n";
                print "\t [self.".getOutletNameForElement($element,"NAME")." resignFirstResponder];\n";
                print "\t [self.".getOutletNameForElement($element,"DOSE")." resignFirstResponder];\n";
                print "\t [self.".getOutletNameForElement($element,"START_TIME")." resignFirstResponder];\n";
                print "}\n\n";
            }
            case "MedicationFormElement" {
                print "- (IBAction)add$element->{name}:(id)sender {\n";
                print "\t MedicationFormElement *formElement = (MedicationFormElement*)[BBUtil newCoreDataObjectForEntityName:\@\"MedicationFormElement\"];\n";
                print "\t formElement.name = self.".getOutletNameForElement($element,"NAME").".text;\n";
                print "\t formElement.dose = self.".getOutletNameForElement($element,"DOSE").".text;\n";
                print "\t formElement.doseUnit = self.".getOutletNameForElement($element,"DOSE_UNIT").".titleLabel.text;\n";
                print "\t [self.".getOutletNameForElement($element,"ADAPTER").".items addObject:formElement];\n";
                print "\t [self.".getOutletNameForElement($element,"TABLE")." reloadData];\n";
                print "\t self.".getOutletNameForElement($element,"NAME").".text = \@\"\";\n";
                print "\t self.".getOutletNameForElement($element,"DOSE").".text = \@\"\";\n";
                print "\t [self.".getOutletNameForElement($element,"NAME")." resignFirstResponder];\n";
                print "\t [self.".getOutletNameForElement($element,"DOSE")." resignFirstResponder];\n";
                print "}\n\n";
            }
            else {
                die "Unhandled ElementListFormElement type.'".$element->{listOf}."'";
            }
        }
    }
}

print "- (BOOL)disablesAutomaticKeyboardDismissal {\n";
print "\t return NO;\n";
print "}\n\n";


print "\- (IBAction)dismiss:(id)sender {\n";
print "\t [BBUtil refreshManagedObject:_section];\n";
print "\t [self dismissViewControllerAnimated:YES completion:nil];\n";
print "}\n\n";

print "+(NSString*)sectionTitle\n";
print "{\n";
print "\t return $section_title;\n";
print "}\n";
$radioGroup = 0;
foreach $button (@radioButtons) {
    my @elems;
    $radioGroup++;
    if (ref $button->{Element} eq "ARRAY"){
        @elems = @{$button->{Element}};
    } else {
        @elems = ($button->{Element});
    }
    print "-(void)radioGroup".$radioGroup.":(BBCheckBox*)sender {\n";
    print "\t BOOL selected = sender.selected;\n";
    foreach $elem (@elems) {
        if ( ! defined $elem ){
            print STDERR "Undefind element in radiogroup\n";
            next;
        }
        my $dataElement = getDataElementForName($elem->{name});
        print "\t self.".getOutletNameForElement($dataElement).".selected = NO;\n";
        
    }
    print "\t sender.selected = selected;\n";

    print "}\n";
}

print "\@end";


