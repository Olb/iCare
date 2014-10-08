//
//  BBData.h
//  iCare2
//
//  Created by billy bray on 8/30/14.
//  Copyright (c) 2014 Spartan Systems Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BBData : NSObject
+(NSArray*)procedures;
+(NSArray*)allergies;
+(NSArray*)medications;
+(NSArray*)gases;
+(NSArray*)intraOpMedications;
+(NSArray*)fluids;
@end
