#import "BBPreopActionsViewController.h"
#import "BBUtil.h"
#import "FormSection.h"
#import "FormElement.h"
#import "FormGroup.h"
#import "BBCheckBox.h"
#import "BooleanFormElement.h"
#import "StringListElement.h"
#import "StringArrayTableAdapter.h"

NSString *const SECTION_TITLE = @"PreopActionsSectionKey";
NSString *const CHECK_CONSENTS_KEY = @"CheckConsentsKey";
NSString *const START_IV_KEY = @"StartIvKey";
NSString *const OTHER_ACTIONS_KEY = @"OtherActionsKey";

@interface BBPreopActionsViewController () <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet BBCheckBox *checkConsentsBBCheckBox;
@property (weak, nonatomic) IBOutlet BBCheckBox *startIvBBCheckBox;
@property (weak, nonatomic) IBOutlet UITextField *otherActionsTextField;
@property (weak, nonatomic) IBOutlet UITableView *otherActionsTable;
@property (strong, nonatomic) StringArrayTableAdapter *otherActionsTableAdapter;
@end

@implementation BBPreopActionsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.otherActionsTableAdapter = [[StringArrayTableAdapter alloc] init];
    self.otherActionsTable.dataSource = self.otherActionsTableAdapter;
    self.otherActionsTable.delegate = self.otherActionsTableAdapter;
    
    if (_section) {
        [self validateSection:_section];
        NSArray *elements = [_section allElements];
        
        for (FormElement *element in elements) {
            if ([element.key isEqualToString:CHECK_CONSENTS_KEY]){
                [self.checkConsentsBBCheckBox setSelected:[((BooleanFormElement*)element).value boolValue]];
            }
            if ([element.key isEqualToString:START_IV_KEY]){
                [self.startIvBBCheckBox setSelected:[((BooleanFormElement*)element).value boolValue]];
            }
            if ([element.key isEqualToString:OTHER_ACTIONS_KEY]){
                self.otherActionsTableAdapter.items = [[NSMutableArray alloc] initWithArray:((StringListElement*)element).value];
                [self.otherActionsTable reloadData];
            }
        }
    }
}

-(void)validateSection:(FormSection*)section
{
    int count;
    NSString *errMsg;
    
    count = [_section.groups count];
    errMsg =[NSString stringWithFormat:@"Invalid number of groups '%d'. Expected '1'.", count];
    NSAssert(count, errMsg);
    
    FormGroup *group;
    
    group = [_section.groups objectAtIndex:0];
    NSAssert([group getElementForKey:CHECK_CONSENTS_KEY]!= nil, @"CheckConsents is nil");
    NSAssert([group getElementForKey:START_IV_KEY]!= nil, @"StartIv is nil");
    NSAssert([group getElementForKey:OTHER_ACTIONS_KEY]!= nil, @"OtherActions is nil");
    
}

- (IBAction)accept:(id)sender {
    if ( !self.section ){
        self.section = (FormSection*)[BBUtil newCoreDataObjectForEntityName:@"FormSection"];
        self.section.title = SECTION_TITLE;
    }
    
    FormGroup *group;
    
    if ([self.section.groups count] > 0) {
        group = [self.section.groups objectAtIndex:0];
    }
    if ( !group ){
        group =(FormGroup*)[BBUtil newCoreDataObjectForEntityName:@"FormGroup"];
        [self.section addGroupsObject:group];
    }
    BooleanFormElement *checkConsents = (BooleanFormElement*)[group getElementForKey:CHECK_CONSENTS_KEY];
    if (!checkConsents) {
        checkConsents = (BooleanFormElement*)[BBUtil newCoreDataObjectForEntityName:@"BooleanFormElement"];
        checkConsents.key = CHECK_CONSENTS_KEY;
        [group addElementsObject:checkConsents];
    }
    
    checkConsents.value = [NSNumber numberWithBool:self.checkConsentsBBCheckBox.isSelected];
    
    BooleanFormElement *startIv = (BooleanFormElement*)[group getElementForKey:START_IV_KEY];
    if (!startIv) {
        startIv = (BooleanFormElement*)[BBUtil newCoreDataObjectForEntityName:@"BooleanFormElement"];
        startIv.key = START_IV_KEY;
        [group addElementsObject:startIv];
    }
    
    startIv.value = [NSNumber numberWithBool:self.startIvBBCheckBox.isSelected];
    
    StringListElement *otherActions = (StringListElement*)[group getElementForKey:OTHER_ACTIONS_KEY];
    if (!otherActions) {
        otherActions = (StringListElement*)[BBUtil newCoreDataObjectForEntityName:@"StringListElement"];
        otherActions.key = OTHER_ACTIONS_KEY;
        [group addElementsObject:otherActions];
    }
    
    NSMutableArray *otherActionsStringArray = [[NSMutableArray alloc] init];
    for (int i = 0; i < [self.otherActionsTable numberOfRowsInSection:0]; i++){
        UITableViewCell *cell = [self.otherActionsTable cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
        [otherActionsStringArray addObject:cell.textLabel.text];
    }
    otherActions.value = otherActionsStringArray;
    
    [self.delegate sectionCreated:self.section];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)addOtherActions:(id)sender {
    [self.otherActionsTableAdapter.items addObject:self.otherActionsTextField.text];
    [self.otherActionsTable reloadData];
    self.otherActionsTextField.text = @"";
    [self.otherActionsTextField resignFirstResponder];
}

- (BOOL)disablesAutomaticKeyboardDismissal {
    return NO;
}

- (IBAction)dismiss:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end