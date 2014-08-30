//
//  BBUtil.h
//  iCare2
//
//  Created by Bogdan Marinescu on 8/30/14.
//  Copyright (c) 2014 Spartan Systems Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BBUtil : NSObject

+(NSString*) sha256:(NSString *)clear;
+(void)showAlertWithMessage:(NSString *)message;
@end
