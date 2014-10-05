//
//  IntraOpViewController.m
//  iCare
//
//  Created by Billy Bray on 10/2/14.
//  Copyright (c) 2014 Spartan Systems Inc. All rights reserved.
//

#import "IntraOpViewController.h"
#import "AddGasViewController.h"
#import "IntraOpGrid.h"
@interface IntraOpViewController () <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *gasTableView;
@property (weak, nonatomic) IBOutlet IntraOpGrid *gridView;


@end

@implementation IntraOpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}


-(void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    self.gridView.backgroundColor = [UIColor clearColor];
    self.gridView.frame = CGRectMake(self.gasTableView.frame.origin.x, 110, self.gasTableView.frame.size.width, 810);
    [self.view setNeedsLayout];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)addGass:(id)sender {
    AddGasViewController* vc = [[AddGasViewController alloc] init];
    vc.modalPresentationStyle = UIModalPresentationFormSheet;
    [self.navigationController presentViewController:vc animated:YES completion:nil];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger result = 0;
    if (tableView == self.gasTableView) {
        ;
    }
    return result;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Agent Cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Agent Cell"];
    }
    if (tableView == self.gasTableView) {
        <#statements#>
    }
    return cell;
}



@end
