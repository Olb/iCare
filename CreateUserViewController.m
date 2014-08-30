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
#import <CommonCrypto/CommonHMAC.h>

@interface CreateUserViewController () <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *firstNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *lastNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *emailTextField;
@property (weak, nonatomic) IBOutlet UITextField *usernameTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordOneTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTwoTextField;

@end

@implementation CreateUserViewController
- (IBAction)dismiss:(id)sender {
}


- (IBAction)create:(id)sender {
    
    if ( [self.firstNameTextField.text length] == 0){
        [self showAlertWithMessage:@"First name cannot be empty"];
        return;
    }
    
    if ( [self.lastNameTextField.text length] == 0){
        [self showAlertWithMessage:@"Last name cannot be empty"];
        return;
    }
    
    if ( [self.usernameTextField.text length] == 0){
        [self showAlertWithMessage:@"Username name cannot be empty"];
        return;
    }
    
    if ( [self.passwordOneTextField.text length] < 8){
        [self showAlertWithMessage:@"Password must be at least 8 characters long"];
        return;
    }
    
    BPBAppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
    NSManagedObjectContext *context = appDelegate.managedObjectContext;
    
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Practitioner"];
    [request setPredicate:[NSPredicate predicateWithFormat:@"loginID = %@", self.usernameTextField.text]];
    [request setFetchLimit:1];
    
    NSUInteger count = [context countForFetchRequest:request error:nil];
    
    if (count == NSNotFound){
        [self showAlertWithMessage:@"Internal error"];
        return;
    } else if (count != 0){
        [self showAlertWithMessage:@"Username already exists"];
        return;
    }
    
    if ( ! [self.passwordOneTextField.text isEqualToString:self.passwordTwoTextField.text] ){
        self.passwordOneTextField.text = @"";
        self.passwordTwoTextField.text = @"";
        [self showAlertWithMessage:@"Passwords do not match"];
        return;
    }
    
    Practitioner *practitioner =[NSEntityDescription insertNewObjectForEntityForName:@"Practitioner"
                                                              inManagedObjectContext:context];
    practitioner.firstName = self.firstNameTextField.text;
    practitioner.lastName = self.lastNameTextField.text;
    practitioner.loginID = self.usernameTextField.text;
    practitioner.password = self.passwordOneTextField.text;
    practitioner.passw
    ordSalt = [self randomStringWithLength:24];
    practitioner.password = [self sha256:[NSString stringWithFormat:@"%@%@",
                                          practitioner.passwordSalt,
                                          self.passwordOneTextField.text]];
    
    NSError *error;
    if (![context save:&error]) {
        NSLog(@"ERROR on context save: %@",[error description]);
        [NSException raise:@"Error on context save" format:@"Message: %@",[error description]];
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

-(NSString*) sha256:(NSString *)clear{
    const char *s=[clear cStringUsingEncoding:NSASCIIStringEncoding];
    NSData *keyData=[NSData dataWithBytes:s length:strlen(s)];
    
    uint8_t digest[CC_SHA256_DIGEST_LENGTH]={0};
    CC_SHA256(keyData.bytes, keyData.length, digest);
    NSData *out=[NSData dataWithBytes:digest length:CC_SHA256_DIGEST_LENGTH];
    NSString *hash=[out description];
    hash = [hash stringByReplacingOccurrencesOfString:@" " withString:@""];
    hash = [hash stringByReplacingOccurrencesOfString:@"<" withString:@""];
    hash = [hash stringByReplacingOccurrencesOfString:@">" withString:@""];
    return hash;
}

NSString *letters = @"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";

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

@end
