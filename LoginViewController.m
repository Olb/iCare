//
//  LoginViewController.m
//  iCare2
//
//  Created by billy bray on 8/29/14.
//  Copyright (c) 2014 Spartan Systems Inc. All rights reserved.
//

#import "LoginViewController.h"
#import "Practitioner.h"
#import "BPBAppDelegate.h"
#import "CreateUserViewController.h"
#import <CommonCrypto/CommonHMAC.h>

@interface LoginViewController ()
@property (weak, nonatomic) IBOutlet UITextField *usernameTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (strong, nonatomic) Practitioner *practitioner;
@end

@implementation LoginViewController

- (IBAction)login:(id)sender
{
    
    if ( [self isLoginValid]){
        //pass Practitioner back to main view controller
    } else {
        [self showAlertWithMessage:@"Invalid username and/or password."];
    }
    
}

- (bool)isLoginValid
{
    if ( [self.usernameTextField.text length] == 0){
        return false;
    }
    if ( [self.passwordTextField.text length] == 0){
        return false;
    }
    BPBAppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
    NSManagedObjectContext *context = appDelegate.managedObjectContext;
    
    
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Practitioner"];
    [request setPredicate:[NSPredicate predicateWithFormat:@"loginID = %@", self.usernameTextField.text]];
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
    
    Practitioner *practitioner = [persons firstObject];
    NSString *password = [self sha256:[NSString stringWithFormat:@"%@%@",
                               practitioner.passwordSalt,
                               self.passwordTextField.text]];
    
    if ( ! [password isEqualToString:practitioner.password] ){
        return false;
    }

    
    return true;
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

- (IBAction)create:(id)sender
{
    CreateUserViewController *createUserViewController = [[CreateUserViewController alloc] initWithNibName:@"CreateUserViewController" bundle:nil];
    [self presentViewController:createUserViewController animated:YES completion:nil];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)showAlertWithMessage:(NSString *)message {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"iCare"
                                                    message:message
                                                   delegate:self
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    [alert show];
}

@end
