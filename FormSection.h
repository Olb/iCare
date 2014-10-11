//
//  FormSection.h
//  iCare
//
//  Created by Billy Bray on 10/11/14.
//  Copyright (c) 2014 Spartan Systems Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Form, FormElement;

@interface FormSection : NSManagedObject

@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSNumber * complete;
@property (nonatomic, retain) NSOrderedSet *elements;
@property (nonatomic, retain) Form *form;
@end

@interface FormSection (CoreDataGeneratedAccessors)

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
-(FormElement*)getElementForKey:(NSString *)key;

@end
