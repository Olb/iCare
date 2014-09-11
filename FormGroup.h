//
//  FormGroup.h
//  iCare2
//
//  Created by Bogdan Marinescu on 9/12/14.
//  Copyright (c) 2014 Spartan Systems Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class FormElement, FormSection;

@interface FormGroup : NSManagedObject

@property (nonatomic, retain) NSString * heading;
@property (nonatomic, retain) FormSection *section;
@property (nonatomic, retain) NSOrderedSet *elements;
@end

@interface FormGroup (CoreDataGeneratedAccessors)

- (void)insertObject:(FormElement *)value inElementsAtIndex:(NSUInteger)idx;
- (void)removeObjectFromElementsAtIndex:(NSUInteger)idx;
- (void)insertElements:(NSArray *)value atIndexes:(NSIndexSet *)indexes;
- (void)removeElementsAtIndexes:(NSIndexSet *)indexes;
- (void)replaceObjectInElementsAtIndex:(NSUInteger)idx withObject:(FormElement *)value;
- (void)replaceElementsAtIndexes:(NSIndexSet *)indexes withElements:(NSArray *)values;
- (void)addElementsObject:(FormElement *)value;
- (void)removeElementsObject:(FormElement *)value;
- (void)addElements:(NSOrderedSet *)values;
- (void)removeElements:(NSOrderedSet *)values;
@end
