//
//  CreateUserViewController.m
//  iCare2
//
//  Created by billy bray on 8/29/14.
//  Copyright (c) 2014 Spartan Systems Inc. All rights reserved.
//

#import "CreateUserViewController.h"
#import "Practitioner.h"
#import "Practicioner.h"
#import "BPBAppDelegate.h"
#import "BBUtil.h"

@interface CreateUserViewController () <UITextFieldDelegate> {
    NSString *letters;
}
@property (weak, nonatomic) IBOutlet UITextField *firstNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *lastNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *emailTextField;
@property (weak, nonatomic) IBOutlet UITextField *usernameTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordOneTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTwoTextField;

@end

@implementation CreateUserViewController

-(void)viewDidLoad {
    [super viewDidLoad];
    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.frame = self.view.bounds;
    gradient.colors = [NSArray arrayWithObjects:(id)[[UIColor whiteColor] CGColor], (id)[[UIColor colorWithRed:91.0/255.0 green:196.0/255.0 blue:105.0/255.0 alpha:1.0] CGColor], nil];
    [self.view.layer insertSublayer:gradient atIndex:0];
    letters = @"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
}

- (IBAction)dismiss:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (IBAction)create:(id)sender {
    
    if ( [self.firstNameTextField.text length] == 0){
        [BBUtil showAlertWithMessage:@"First name cannot be empty"];
        return;
    }
    
    if ( [self.lastNameTextField.text length] == 0){
        [BBUtil showAlertWithMessage:@"Last name cannot be empty"];
        return;
    }
    
    if ( [self.usernameTextField.text length] == 0){
        [BBUtil showAlertWithMessage:@"Username name cannot be empty"];
        return;
    }
    
    if ( [self.passwordOneTextField.text length] < 8){
        [BBUtil showAlertWithMessage:@"Password must be at least 8 characters long"];
        return;
    }
    
    BPBAppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
    NSManagedObjectContext *context = appDelegate.managedObjectContext;
    
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Practitioner"];
    [request setPredicate:[NSPredicate predicateWithFormat:@"loginID = %@", self.usernameTextField.text]];
    [request setFetchLimit:1];
    
    NSUInteger count = [context countForFetchRequest:request error:nil];
    
    if (count == NSNotFound){
        [BBUtil showAlertWithMessage:@"Internal error"];
        return;
    } else if (count != 0){
        [BBUtil showAlertWithMessage:@"Username already exists"];
        return;
    }
    
    if ( ! [self.passwordOneTextField.text isEqualToString:self.passwordTwoTextField.text] ){
        self.passwordOneTextField.text = @"";
        self.passwordTwoTextField.text = @"";
        [BBUtil showAlertWithMessage:@"Passwords do not match"];
        return;
    }
    
    Practitioner *practitioner =[NSEntityDescription insertNewObjectForEntityForName:@"Practitioner"
                                                              inManagedObjectContext:context];
    practitioner.firstName = self.firstNameTextField.text;
    practitioner.lastName = self.lastNameTextField.text;
    practitioner.loginID = self.usernameTextField.text;
    practitioner.email = self.emailTextField.text;
    practitioner.password = self.passwordOneTextField.text;
    practitioner.passwordSalt = [self randomStringWithLength:24];
    practitioner.password = [BBUtil sha256:[NSString stringWithFormat:@"%@%@",
                                          practitioner.passwordSalt,
                                          self.passwordOneTextField.text]];
    
    NSError *error;
    if (![context save:&error]) {
        NSLog(@"ERROR on context save: %@",[error description]);
        [NSException raise:@"Error on context save" format:@"Message: %@",[error description]];
    }
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(NSString *) randomStringWithLength: (int) len {
    
    NSMutableString *randomString = [NSMutableString stringWithCapacity: len];
    
    for (int i=0; i<len; i++) {
        [randomString appendFormat: @"%C", [letters characterAtIndex: arc4random_uniform([letters length]) % [letters length]]];
    }
    
    return randomString;
}

- (IBAction)dimiss:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(BOOL) textFieldShouldReturn: (UITextField *) textField {
    [textField resignFirstResponder];
    return YES;
}

- (BOOL)disablesAutomaticKeyboardDismissal {
    return NO;
}

@end
