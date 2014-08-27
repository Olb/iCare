//
//  BBPatient.h
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

@interface BBPatient : NSObject
@property (nonatomic, strong) NSDate *birthdate;
@property (nonatomic) NSInteger height;
@property (nonatomic) NSInteger weight;
@property (nonatomic, strong) BBPreOpEval *preOp;
@property (nonatomic, strong) BBAnesthesiaRecord *anesthesiaRecord;
@property (nonatomic, strong) BBIntraOp *intraOp;
@property (nonatomic, strong) BBPostOp *postOp;
@end
