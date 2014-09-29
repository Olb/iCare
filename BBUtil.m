//
//  BBUtil.m
//  iCare2
//
//  Created by Bogdan Marinescu on 8/30/14.
//  Copyright (c) 2014 Spartan Systems Inc. All rights reserved.
//

#import "BBUtil.h"
#import <CommonCrypto/CommonHMAC.h>
#import "BPBAppDelegate.h"
#import "Form.h"
#import "Operation.h"

@implementation BBUtil

+(NSString*) sha256:(NSString *)clear{
    const char *s=[clear cStringUsingEncoding:NSASCIIStringEncoding];
    NSData *keyData=[NSData dataWithBytes:s length:strlen(s)];
    
    uint8_t digest[CC_SHA256_DIGEST_LENGTH]={0};
    CC_SHA256(keyData.bytes, keyData.length, digest);
    NSData *out=[NSData dataWithBytes:digest length:CC_SHA256_DIGEST_LENGTH];
    NSString *hash=[out description];
    hash = [hash stringByReplacingOccurrencesOfString:@" " withString:@""];
    hash = [hash stringByReplacingOccurrencesOfString:@"<" withString:@""];
    hash = [hash stringByReplacingOccurrencesOfString:@">" withString:@""];
    return hash;
}

+ (void)showAlertWithMessage:(NSString *)message {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"iCare"
                                                    message:message
                                                   delegate:self
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    [alert show];
}

+ (NSString*) formatDate:(NSDate*)date
{
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    [format setDateFormat:@"yyyy/MM/dd"];
    
    return [format stringFromDate:date];
}

+ (NSString*) formatTime:(NSDate*)date
{
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    [format setDateFormat:@"HH:mm"];
    
    return [format stringFromDate:date];
}

+(id) newCoreDataObjectForEntityName:(NSString*)name{
    BPBAppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
    NSManagedObjectContext *context = appDelegate.managedObjectContext;
    
    return [NSEntityDescription insertNewObjectForEntityForName:name
                                         inManagedObjectContext:context];
}

+(void)saveContext
{
    BPBAppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
    NSManagedObjectContext *context = appDelegate.managedObjectContext;
    NSError *error = nil;
    if (![context save:&error]) {
        NSAssert(error == nil, @"Could not save context");
    }
}

+(void)deleteManagedObject:(NSManagedObject*)object
{
    BPBAppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
    NSManagedObjectContext *context = appDelegate.managedObjectContext;
    [context deleteObject:object];
}

+(void)refreshManagedObject:(NSManagedObject*)object
{
    BPBAppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
    NSManagedObjectContext *context = appDelegate.managedObjectContext;
    [context refreshObject:object mergeChanges:YES];
}

+(void)drawRect:(CGRect)rectangle withRed:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, 2.0);
    CGContextSetRGBStrokeColor(context, red, green, blue, 1.0);
    CGContextStrokeRect(context, rectangle);
    CGContextSetRGBStrokeColor(context, 0.0, 0.0, 0.0, 1.0);
}

+(void)drawRect:(CGRect)rectangle
{
    [BBUtil drawRect:rectangle withRed:0.0 green:0.0 blue:0.0];
}

+(void)drawLineFromPoint:(CGPoint)startPoint toPoint:(CGPoint)endPoint
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, 1.0);
    CGColorRef colorRef = [[UIColor colorWithRed:155.0/255.0 green:126.0/255.0 blue:21.0/255.0 alpha:1.0] CGColor];
    CGContextSetStrokeColorWithColor(context, colorRef);
    CGContextBeginPath(context);
    CGContextMoveToPoint(context, startPoint.x, startPoint.y);
    CGContextAddLineToPoint(context, endPoint.x, endPoint.y);
    CGContextStrokePath(context);
}

@end
