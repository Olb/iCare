//
//  IntraOpDetailsViewController.m
//  iCare
//
//  Created by Billy Bray on 10/11/14.
//  Copyright (c) 2014 Spartan Systems Inc. All rights reserved.
//

#import "IntraOpDetailsViewController.h"
#import "BBUtil.h"
#import "Operation.h"

@interface IntraOpDetailsViewController () <UIAlertViewDelegate>
@property (weak, nonatomic) IBOutlet UITextField *provider;
@property (weak, nonatomic) IBOutlet UITextField *location;
@property (weak, nonatomic) IBOutlet UIButton *preOpStart;
@property (weak, nonatomic) IBOutlet UIButton *preOpEndButton;
@property (weak, nonatomic) IBOutlet UIButton *anesthesiaStart;
@property (weak, nonatomic) IBOutlet UIButton *anesthesiaEnd;
@property (weak, nonatomic) IBOutlet UIButton *procedureStart;
@property (weak, nonatomic) IBOutlet UIButton *procedureEnd;
@property (weak, nonatomic) IBOutlet UIButton *outOfRoom;
@property (weak, nonatomic) IBOutlet UIButton *anesthesiaTimeOut;
@property (weak, nonatomic) IBOutlet UIButton *surgicalTimeOut;

@end

@implementation IntraOpDetailsViewController 

- (void)viewDidLoad {
    [super viewDidLoad];
    if (self.intraOp) {
        if (self.intraOp.provider) self.provider.text = self.intraOp.provider;
        if (self.intraOp.orLocation) self.location.text = self.intraOp.orLocation;
        if (self.intraOp.operation.preOpDate)
            [self.preOpStart setTitle:[self stringFromDate:self.intraOp.operation.preOpDate] forState:UIControlStateNormal];
        if (self.intraOp.preOpEnd)
            [self.preOpEndButton setTitle:[self stringFromDate:self.intraOp.preOpEnd] forState:UIControlStateNormal];
        if (self.intraOp.anesthesiaStart)
            [self.anesthesiaStart setTitle:[self stringFromDate:self.intraOp.anesthesiaStart] forState:UIControlStateNormal];
        if (self.intraOp.anesthesiaEnd)
            [self.anesthesiaEnd setTitle:[self stringFromDate:self.intraOp.anesthesiaEnd] forState:UIControlStateNormal];
        if (self.intraOp.procedureStart)
            [self.procedureStart setTitle:[self stringFromDate:self.intraOp.procedureStart] forState:UIControlStateNormal];
        if (self.intraOp.procedureEnd)
            [self.procedureEnd setTitle:[self stringFromDate:self.intraOp.procedureEnd] forState:UIControlStateNormal];
        if (self.intraOp.outOfRoom)
            [self.outOfRoom setTitle:[self stringFromDate:self.intraOp.outOfRoom] forState:UIControlStateNormal];
        if (self.intraOp.anesthesiaTimeOut)
            [self.anesthesiaTimeOut setTitle:[self stringFromDate:self.intraOp.anesthesiaTimeOut] forState:UIControlStateNormal];
        if (self.intraOp.surgicalTimeOut)
            [self.surgicalTimeOut setTitle:[self stringFromDate:self.intraOp.surgicalTimeOut] forState:UIControlStateNormal];
    }
}
- (IBAction)startPreOp:(id)sender {
    [self.preOpStart setTitle:[self stringFromDate:[NSDate date]] forState:UIControlStateNormal];
}

- (IBAction)endPreOp:(id)sender {
    [self.preOpEndButton setTitle:[self stringFromDate:[NSDate date]] forState:UIControlStateNormal];
}
- (IBAction)startAnesthesia:(id)sender {
    if (self.intraOp.anesthesiaEnd) {
        return;
    }
    [self.intraOpViewController startAnesthesia];
    [self.anesthesiaStart setTitle:[self stringFromDate:[NSDate date]] forState:UIControlStateNormal];
    [self.intraOpViewController allowInteraction:YES];
}
- (IBAction)endAnesthesia:(id)sender {
    if (self.intraOp.anesthesiaEnd) {
        return;
    }
    [self confirmEndOperation];
    
}

-(void)confirmEndOperation
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"End PreOp"
                                                    message:@"Are you sure you want to end the PreOp? This action cannot be undone." delegate:self
                                          cancelButtonTitle:nil
                                          otherButtonTitles:@"No",@"Yes", nil];
    [alert show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
        [self.anesthesiaEnd setTitle:[self stringFromDate:[NSDate date]] forState:UIControlStateNormal];
        [self.intraOpViewController allowInteraction:NO];
    }
}

- (IBAction)startProcedure:(id)sender {
    [self.procedureStart setTitle:[self stringFromDate:[NSDate date]] forState:UIControlStateNormal];
}
- (IBAction)endProcedure:(id)sender {
    [self.procedureEnd setTitle:[self stringFromDate:[NSDate date]] forState:UIControlStateNormal];
}
- (IBAction)outOfRoom:(id)sender {
    [self.outOfRoom setTitle:[self stringFromDate:[NSDate date]] forState:UIControlStateNormal];
}
- (IBAction)cancel:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)anesthesiaTimeOut:(id)sender {
    [self.anesthesiaTimeOut setTitle:[self stringFromDate:[NSDate date]] forState:UIControlStateNormal];
}
- (IBAction)surgicalTimeOut:(id)sender {
    [self.surgicalTimeOut setTitle:[self stringFromDate:[NSDate date]] forState:UIControlStateNormal];
}
- (IBAction)save:(id)sender {
    self.intraOp.preOpStart = [self getDateFromString:self.preOpStart.titleLabel.text];
    NSLog(@"PreOpStart: %@", self.intraOp.preOpStart);
    self.intraOp.preOpEnd = [self getDateFromString:self.preOpEndButton.titleLabel.text];
    self.intraOp.anesthesiaStart = [self getDateFromString:self.anesthesiaStart.titleLabel.text];
    self.intraOp.anesthesiaEnd = [self getDateFromString:self.anesthesiaEnd.titleLabel.text];
    self.intraOp.procedureStart = [self getDateFromString:self.procedureStart.titleLabel.text];
    self.intraOp.procedureEnd = [self getDateFromString:self.procedureEnd.titleLabel.text];
    self.intraOp.outOfRoom = [self getDateFromString:self.outOfRoom.titleLabel.text];
    self.intraOp.anesthesiaTimeOut = [self getDateFromString:self.anesthesiaTimeOut.titleLabel.text];
    self.intraOp.surgicalTimeOut = [self getDateFromString:self.surgicalTimeOut.titleLabel.text];
    self.intraOp.orLocation = self.location.text;
    self.intraOp.provider = self.provider.text;
    [BBUtil saveContext];
    [self dismissViewControllerAnimated:YES completion:^{
        [self.intraOpViewController scrollToBeginning];
    }];
}

-(NSString *)stringFromDate:(NSDate*)date
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"HH:mm"];
    return [formatter stringFromDate:date];
}

-(NSDate*)getDateFromString:(NSString*)string
{
    if ([string isEqualToString:@"Set"]) {
        return nil;
    }
    NSDate *date = [NSDate date];
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSInteger units =  NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSWeekdayCalendarUnit | NSHourCalendarUnit |  NSMinuteCalendarUnit;
    NSDateComponents *components = [calendar components:units fromDate:date];
    NSArray *comps = [string componentsSeparatedByString:@":"];
    [components setHour: [(NSString*)[comps objectAtIndex:0] integerValue]];
    [components setMinute: [(NSString*)[comps objectAtIndex:1] integerValue]];
    NSDate *newDate = [calendar dateFromComponents: components];
    NSLog(@"New Date: %@", newDate);
    return newDate;
}

- (IBAction)cancelSetTime:(id)sender {
}
- (IBAction)acceptTimeSet:(id)sender {
}



@end
