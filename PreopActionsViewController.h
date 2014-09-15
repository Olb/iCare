//
//  BBPreopActionsViewController.h
//  iCare
//
//  Created by Bogdan Marinescu on 8/26/14.
//  Copyright (c) 2014 Bogdan Marinescu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BBFormSectionDelegate.h"
#import "FormSection.h"

@interface PreopActionsViewController : UIViewController
@property id <BBFormSectionDelegate> delegate;
@property FormSection * section;

+(NSString*) sectionTitle;

@end
