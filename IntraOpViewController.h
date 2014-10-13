//
//  IntraOpViewController.h
//  iCare
//
//  Created by Billy Bray on 10/2/14.
//  Copyright (c) 2014 Spartan Systems Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IntraOp.h"
#import "Measurement.h"

@class TimeScrollView;
@class Agent;
@class DoseView;

@interface IntraOpViewController : UIViewController
@property (nonatomic) IntraOp *intraOp;
@property (weak, nonatomic) IBOutlet TimeScrollView *timeScrollView;

-(DoseView*)doseViewForAgent:(Agent*)agent forCell:(UITableViewCell*)cell;
-(UILabel*)viewForMeasurement:(Measurement*)measurement forCell:(UITableViewCell*)cell;
-(void)scrollToBeginning;
-(void)pageForTime:(NSDate*)timeToScroll;
-(void)allowInteraction:(BOOL)enable;
-(void)startAnesthesia;
-(void) reloadTables;
@end
