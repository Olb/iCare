//
//  FormGroup.h
//  iCare2
//
//  Created by Billy Bray on 9/15/14.
//  Copyright (c) 2014 Spartan Systems Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class FormElement, FormSection;

@interface FormGroup : NSManagedObject

@property (nonatomic, retain) NSString * heading;
@property (nonatomic, retain) NSNumber * optional;
@property (nonatomic, retain) NSNumber * selected;
@property (nonatomic, retain) NSOrderedSet *elements;
@property (nonatomic, retain) FormSection *section;
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
- (FormElement*)getElementForKey:(NSString *)key;
@end
