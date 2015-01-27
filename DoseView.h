//
//  DoseView.h
//  iCare
//
//  Created by Billy Bray on 10/6/14.
//  Copyright (c) 2014 Spartan Systems Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Agent.h"

@interface DoseView : UIView

@property (weak, nonatomic) IBOutlet UIView *lineView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *lineWidthContraint;

@property (weak, nonatomic) IBOutlet UITapGestureRecognizer *tapGesture;
@property Agent *agent;
@property (weak, nonatomic) IBOutlet UILabel *dose;
@end
