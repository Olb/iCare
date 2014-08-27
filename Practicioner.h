//
//  Practicioner.h
//  iCare2
//
//  Created by billy bray on 8/27/14.
//  Copyright (c) 2014 Spartan Systems Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Patient;

@interface Practicioner : NSManagedObject

@property (nonatomic, retain) NSString * firstName;
@property (nonatomic, retain) NSString * lastName;
@property (nonatomic, retain) NSString * loginID;
@property (nonatomic, retain) NSString * password;
@property (nonatomic, retain) NSString * passwordSalt;
@property (nonatomic, retain) NSSet *patients;
@end

@interface Practicioner (CoreDataGeneratedAccessors)

- (void)addPatientsObject:(Patient *)value;
- (void)removePatientsObject:(Patient *)value;
- (void)addPatients:(NSSet *)values;
- (void)removePatients:(NSSet *)values;

@end
