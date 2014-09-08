//
//  BBTableWithFilter.h
//  iCare2
//
//  Created by Bogdan Marinescu on 9/4/14.
//  Copyright (c) 2014 Spartan Systems Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BBTableWithFilter : NSObject
@property (nonatomic,retain) NSMutableArray* dataSet;

-(void)initWithData:(NSArray*)data;
@end
