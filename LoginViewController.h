//
//  LoginViewController.h
//  iCare2
//
//  Created by billy bray on 8/29/14.
//  Copyright (c) 2014 Spartan Systems Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BBMainViewController;
@class Practitioner;

@protocol LoginViewControllerDelegate <NSObject>
-(void)setLoggedIn:(BOOL)loggedIn withPractionerID:(Practitioner*)practitioner;
@end

@interface LoginViewController : UIViewController
@property (nonatomic, weak) id <LoginViewControllerDelegate> delegate;
@end
