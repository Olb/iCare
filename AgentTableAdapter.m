//
//  SubstanceTableAdapter.m
//  iCare
//
//  Created by Billy Bray on 10/5/14.
//  Copyright (c) 2014 Spartan Systems Inc. All rights reserved.
//

#import "AgentTableAdapter.h"
#import "IntraOp.h"
#import "Agent.h"
#import "DoseView.h"
#import "GridConstants.h"

@interface AgentTableAdapter ()

@property NSMutableArray *agentsArray;
@property NSString *agentType;

@end

@implementation AgentTableAdapter

-(id)initWithType:(NSString*)agentType
{
    if (self = [super init]) {
        _agentsArray = [[NSMutableArray alloc] init];
        _agentType = agentType;
    }
    return self;
}

-(void)loadData
{
    [self.agentsArray removeAllObjects];
    for (Agent *agent in _intraOp.agent) {
        if ([agent.type isEqualToString:_agentType]) {
            BOOL alreadyAdded = false;
            for (NSMutableSet *set in _agentsArray) {
                for (Agent *a in set) {
                    if ([agent.name isEqualToString:a.name]) {
                        [set addObject:agent];
                        alreadyAdded = true;
                    }
                    break;
                }
            }
            if (!alreadyAdded){
                NSMutableSet *agentSet = [[NSMutableSet alloc] init];
                [agentSet addObject:agent];
                [_agentsArray addObject:agentSet];
            }
        }
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    [self loadData];
    return self.agentsArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Agent Cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Agent Cell"];
    }
    
    cell.textLabel.text = ((Agent*)[(NSSet*)[self.agentsArray objectAtIndex:indexPath.row] anyObject]).name;
    [cell.contentView.subviews makeObjectsPerformSelector: @selector(removeFromSuperview)];

    for (Agent *agent in [self.agentsArray objectAtIndex:indexPath.row]) {
        [cell.contentView addSubview:[self.controller doseViewForAgent:agent]];
    }
    
    UIView* bg = [[UIView alloc] initWithFrame:CGRectMake(0, 0, FIRST_COLUMN_X_COORD, cell.frame.size.height)];
    bg.backgroundColor = [UIColor whiteColor];
    [cell.contentView addSubview:bg];
    
    
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

@end
