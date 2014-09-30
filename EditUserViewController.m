//
//  EditUserViewController.m
//  iCare2
//
//  Created by Billy Bray on 9/29/14.
//  Copyright (c) 2014 Spartan Systems Inc. All rights reserved.
//

#import "EditUserViewController.h"
#import "BBUtil.h"
#import "BPBAppDelegate.h"
#import "Practitioner.h"

@interface EditUserViewController () {
    NSString *letters;
}
@property (weak, nonatomic) IBOutlet UITextField *firstNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *lastNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *emailTextField;
@property (weak, nonatomic) IBOutlet UITextField *userNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordOneTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTwoTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordChallengeTextField;
@property (weak, nonatomic) IBOutlet UIView *changePasswordView;
@property (weak, nonatomic) IBOutlet UIView *passwordChallengeView;
@property (weak, nonatomic) IBOutlet UIButton *changePasswordButton;

@end

@implementation EditUserViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    CAGradientLayer *gradient = [CAGradientLayer layer];
//    gradient.frame = self.view.bounds;
//    gradient.colors = [NSArray arrayWithObjects:(id)[[UIColor whiteColor] CGColor], (id)[[UIColor colorWithRed:91.0/255.0 green:196.0/255.0 blue:105.0/255.0 alpha:1.0] CGColor], nil];
//    [self.view.layer insertSublayer:gradient atIndex:0];
    
    letters = @"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
    self.passwordChallengeView.hidden = YES;
    self.passwordChallengeView.alpha = 0.0;
    self.changePasswordView.hidden = YES;
    self.changePasswordView.alpha = 0.0;
    self.firstNameTextField.text = self.practitioner.firstName;
    self.lastNameTextField.text = self.practitioner.lastName;
    self.emailTextField.text = self.practitioner.email;
    self.userNameTextField.text = self.practitioner.loginID;
}

- (IBAction)acceptPasswordChallenge:(id)sender {
    if ([self isLoginValid]) {
        [self cancelPasswordChallenge:nil];
        self.changePasswordView.hidden = NO;
        self.changePasswordButton.hidden = YES;
        [UIView animateWithDuration:0.5 animations:^{
            self.changePasswordView.alpha = 1.0;
        }];
    } else {
        self.passwordChallengeTextField.text = @"";
        [BBUtil showAlertWithMessage:@"The password is incorrect."];
    }
}
- (IBAction)acceptNewPassword:(id)sender {
    BPBAppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
    NSManagedObjectContext *context = appDelegate.managedObjectContext;
    self.practitioner.password = self.passwordOneTextField.text;
    NSLog(@"New password: %@", self.practitioner.password);
    self.practitioner.passwordSalt = [self randomStringWithLength:24];
    self.practitioner.password = [BBUtil sha256:[NSString stringWithFormat:@"%@%@",
                                            self.practitioner.passwordSalt,
                                            self.passwordOneTextField.text]];
   
    NSError *error = nil;
    if (![context save:&error]) {
        [self showAlertWithMessage:@"Error saving username"];
    }
    [self cancelNewPassword:nil];
}

-(NSString *) randomStringWithLength: (int) len {
    
    NSMutableString *randomString = [NSMutableString stringWithCapacity: len];
    
    for (int i=0; i<len; i++) {
        [randomString appendFormat: @"%C", [letters characterAtIndex: arc4random_uniform([letters length]) % [letters length]]];
    }
    
    return randomString;
}

- (IBAction)cancelNewPassword:(id)sender {
    self.passwordOneTextField.text = @"";
    self.passwordTwoTextField.text = @"";
    [UIView animateWithDuration:0.5 animations:^{
        self.changePasswordView.alpha = 0.0;
    }];
    self.passwordChallengeView.hidden = YES;
    self.changePasswordButton.hidden = NO;
}
- (IBAction)changeUserPasswordButton:(id)sender {
    self.changePasswordButton.hidden = YES;
    self.passwordChallengeView.hidden = NO;
    [UIView animateWithDuration:0.5 animations:^{
        self.passwordChallengeView.alpha = 1.0;
    }];
}

- (IBAction)cancelPasswordChallenge:(id)sender {
    self.passwordChallengeTextField.text = @"";
    [UIView animateWithDuration:0.5 animations:^{
        self.passwordChallengeView.alpha = 0.0;
    }];
    self.passwordChallengeView.hidden = YES;
    self.changePasswordButton.hidden = NO;
}

- (bool)isLoginValid
{
    if ( [self.passwordChallengeTextField.text length] == 0){
        return false;
    }
    BPBAppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
    NSManagedObjectContext *context = appDelegate.managedObjectContext;
    
    
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Practitioner"];
    [request setPredicate:[NSPredicate predicateWithFormat:@"loginID = %@", self.practitioner.loginID]];
    [request setFetchLimit:1];
    
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Practitioner"
                                              inManagedObjectContext:context];
    if (entity == nil) {
        [NSException raise:@"Entity is nil" format:@""];
    }
    [request setEntity:entity];
    NSError *requestError = nil;
    NSArray *persons = [context executeFetchRequest:request
                                              error:&requestError];
    
    if ( requestError ){
        [NSException raise:@"Core Data ERROR " format:@"%@",[requestError description]];
    }
    
    if ( [persons count] == 0 ){
        return false;
    }
    
    self.practitioner = [persons firstObject];
    NSString *password = [BBUtil sha256:[NSString stringWithFormat:@"%@%@",
                                         self.practitioner.passwordSalt,
                                         self.passwordChallengeTextField.text]];
    
    if ( ! [password isEqualToString:self.practitioner.password] ){
        return false;
    }
    
    
    return true;
}
- (IBAction)saveEditUser:(id)sender {
    BPBAppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
    NSManagedObjectContext *context = appDelegate.managedObjectContext;
    
    self.practitioner.loginID = self.userNameTextField.text;
    self.practitioner.email = self.emailTextField.text;
    self.practitioner.firstName = self.firstNameTextField.text;
    self.practitioner.lastName = self.lastNameTextField.text;
    
    NSError *error = nil;
    if (![context save:&error]) {
        [self showAlertWithMessage:@"Error saving new user details"];
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)showAlertWithMessage:(NSString *)message {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"iCare"
                                                    message:message
                                                   delegate:self
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    [alert show];
}
- (IBAction)cancelEditUser:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}


@end
