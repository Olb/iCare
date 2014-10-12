//
//  PDFTestViewController.h
//  iCare2
//
//  Created by Billy Bray on 9/26/14.
//  Copyright (c) 2014 Spartan Systems Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Form.h"
#import "IntraOp.h"
@interface PDFDisplayViewController : UIViewController
@property (strong, nonatomic) Form *form;
@property (strong, nonatomic) IntraOp *intraOp;
@end
