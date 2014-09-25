//
//  BBUtil.h
//  iCare2
//
//  Created by Bogdan Marinescu on 8/30/14.
//  Copyright (c) 2014 Spartan Systems Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BBUtil : NSObject

+ (NSString*) sha256:(NSString *)clear;
+ (void)showAlertWithMessage:(NSString *)message;
+ (NSString*) formatTime:(NSDate*)date;
+ (NSString*) formatDate:(NSDate*)date;
+ (id) newCoreDataObjectForEntityName:(NSString*)name;
+(void)saveContext;
+(void)drawRect:(CGRect)rectangle;
+(void)deleteManagedObject:(NSManagedObject*)object;
+(void)refreshManagedObject:(NSManagedObject*)object;
@end
