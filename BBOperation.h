//
//  BBOperation.h
//  iCare2
//
//  Created by billy bray on 8/27/14.
//  Copyright (c) 2014 Spartan Systems Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@class BBPreOpEval;
@class BBAnesthesiaRecord;
@class BBIntraOp;
@class BBPostOp;

@interface BBOperation : NSObject
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSDate *preOpDate;
@property (nonatomic, strong) BBPreOpEval *preOp;
@property (nonatomic, strong) BBAnesthesiaRecord *anesthesiaRecord;
@property (nonatomic, strong) BBIntraOp *intraOp;
@property (nonatomic, strong) BBPostOp *postOp;
@end
