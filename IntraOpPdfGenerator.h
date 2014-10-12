//
//  IntraOpPdfGenerator.h
//  iCare
//
//  Created by Billy Bray on 10/11/14.
//  Copyright (c) 2014 Spartan Systems Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IntraOp.h"
@interface IntraOpPdfGenerator : NSObject
-(void)generateIntraOpPDF;
-(instancetype)initWithIntraOp:(IntraOp*)intraOp;
@end
