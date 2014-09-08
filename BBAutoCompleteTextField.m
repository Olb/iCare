//
//  BBAutoCompleteTextField.m
//  iCare2
//
//  Created by Bogdan Marinescu on 9/8/14.
//  Copyright (c) 2014 Spartan Systems Inc. All rights reserved.
//

#import "BBAutoCompleteTextField.h"
#import "BBAutoCompleteTextFieldDelegate.h"

const int PADDING = 10;
const int HEIGHT = 200;

@interface BBAutoCompleteTextField ()
@property BBAutoCompleteTextFieldDelegate* autocompleteDelegate;
@end

@implementation BBAutoCompleteTextField

-(void) setAutoCompleteData:(NSArray *)data
{
    self.autocompleteDelegate = [[BBAutoCompleteTextFieldDelegate alloc] initWithData:data];
    
    CGRect rect = CGRectMake(self.frame.origin.x, self.frame.origin.y + self.frame.size.height + PADDING, self.frame.size.width, HEIGHT);
    
    [self.autocompleteDelegate setTableViewFrame:rect];
    self.delegate = self.autocompleteDelegate;
}

@end
