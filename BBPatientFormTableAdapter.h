//
//  BBPlannedOperationTableAdapter.h
//  iCare2
//
//  Created by Bogdan Marinescu on 8/30/14.
//  Copyright (c) 2014 Spartan Systems Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Operation.h"

@interface BBPatientFormTableAdapter : NSObject <UITableViewDataSource, UITableViewDelegate>

@property Operation *opration;

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
- (UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView;

@end
