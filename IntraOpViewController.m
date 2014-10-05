//
//  IntraOpViewController.m
//  iCare
//
//  Created by Billy Bray on 10/2/14.
//  Copyright (c) 2014 Spartan Systems Inc. All rights reserved.
//

#import "IntraOpViewController.h"
#import "AddGasViewController.h"

@interface IntraOpViewController ()

@end

@implementation IntraOpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)addGass:(id)sender {
    AddGasViewController* vc = [[AddGasViewController alloc] init];
    vc.modalPresentationStyle = UIModalPresentationFormSheet;
    [self.navigationController presentViewController:vc animated:YES completion:nil];
}



@end
