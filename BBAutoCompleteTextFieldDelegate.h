//
//  BBAutoCompleteTextFieldDelegate.h
//  iCare2
//
//  Created by Bogdan Marinescu on 9/8/14.
//  Copyright (c) 2014 Spartan Systems Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BBAutoCompleteTextFieldDelegate : NSObject <UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource>

@property UITextField *autoCompleteTextField;
- (id)initWithData:(NSArray*)array;
-(void) setTableViewFrame:(CGRect)rect;

@end
