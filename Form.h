//
//  Form.h
//  iCare2
//
//  Created by Bogdan Marinescu on 9/12/14.
//  Copyright (c) 2014 Spartan Systems Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class FormSection, Operation;

@interface Form : NSManagedObject

@property (nonatomic, retain) NSOrderedSet *sections;
@property (nonatomic, retain) Operation *operation;
@end

@interface Form (CoreDataGeneratedAccessors)

- (void)insertObject:(FormSection *)value inSectionsAtIndex:(NSUInteger)idx;
- (void)removeObjectFromSectionsAtIndex:(NSUInteger)idx;
- (void)insertSections:(NSArray *)value atIndexes:(NSIndexSet *)indexes;
- (void)removeSectionsAtIndexes:(NSIndexSet *)indexes;
- (void)replaceObjectInSectionsAtIndex:(NSUInteger)idx withObject:(FormSection *)value;
- (void)replaceSectionsAtIndexes:(NSIndexSet *)indexes withSections:(NSArray *)values;
- (void)addSectionsObject:(FormSection *)value;
- (void)removeSectionsObject:(FormSection *)value;
- (void)addSections:(NSOrderedSet *)values;
- (void)removeSections:(NSOrderedSet *)values;
@end
