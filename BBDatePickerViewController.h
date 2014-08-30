//
//  BBDatePickerViewController.h
//  iCare
//
//  Created by Billy Bray on 2/7/14.
//  Copyright (c) 2014 Billy Bray. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol BBDatePickerViewControllerDelegate <NSObject>
-(void)didSaveDateValues:(NSDate*)date;
@end
@interface BBDatePickerViewController : UIViewController
@property (nonatomic, strong) id <BBDatePickerViewControllerDelegate> delegate;
@property (nonatomic, strong) UIDatePicker *datePicker;
@property (nonatomic, weak) UIPopoverController *datePopoverController;
@property (nonatomic, strong) NSDate *date;
@property (nonatomic, strong) id type;
@end
