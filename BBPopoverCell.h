//
//  BBPopoverCell.h
//  iCare
//
//  Created by Billy Bray on 2/7/14.
//  Copyright (c) 2014 Billy Bray. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BBCheckBox.h"

@interface BBPopoverCell : UITableViewCell

@property (nonatomic, strong) IBOutlet UILabel *cellItemLabel;
@property BOOL isChecked;
//- (IBAction)checkedBox:(id)sender;

@end
