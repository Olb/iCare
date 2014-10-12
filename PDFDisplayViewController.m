//
//  PDFTestViewController.m
//  iCare2
//
//  Created by Billy Bray on 9/26/14.
//  Copyright (c) 2014 Spartan Systems Inc. All rights reserved.
//
#import "Practitioner.h"
#import "PDFDisplayViewController.h"
#import "Form.h"
#import "BBPdfGenerator.h"
#import <MessageUI/MessageUI.h>
#import "Patient.h"
#import "Operation.h"

@interface PDFDisplayViewController () <UIWebViewDelegate, MFMailComposeViewControllerDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end

@implementation PDFDisplayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.webView.delegate = self;
}

-(void)viewDidAppear:(BOOL)animated
{
    NSURL *url;
    [super viewDidAppear:animated];
    if (self.form) {
        self.navigationItem.title = self.form.title;
         url = [NSURL fileURLWithPath:[BBPdfGenerator getPDFFileNameForForm:self.form] isDirectory:NO];
    } else if (self.intraOp) {
        url = [NSURL fileURLWithPath:[BBPdfGenerator getPDFFileNameForIntraOp:self.intraOp] isDirectory:NO];
    }
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:request];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)emailPDF:(id)sender {
    if ([self checkCanSendEmail]) {
        [self displayMailComposerSheet];
    }
}

- (IBAction)cancel:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    NSLog(@"Should start  loading");
    return true;
}
- (void)webViewDidStartLoad:(UIWebView *)webView
{
    NSLog(@"Did start loading");
}
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    NSLog(@"Did finish loading");
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    NSLog(@"Error loading: %@", error);
}

- (BOOL)checkCanSendEmail
{
  
    if ([MFMailComposeViewController canSendMail])
    {
        return YES;
    }
    return NO;
}

- (void)displayMailComposerSheet
{
    MFMailComposeViewController *picker = [[MFMailComposeViewController alloc] init];
    picker.mailComposeDelegate = self;
    
    [picker setSubject:self.form.title];
    
    // Set up recipients
    NSArray *toRecipients = [NSArray arrayWithObject:self.form.operation.patient.practitioner.email];
    [picker setToRecipients:toRecipients];
    
    // Attach an image to the email
    NSData *myData = [NSData dataWithContentsOfFile:[BBPdfGenerator getPDFFileNameForForm:self.form]];
    [picker addAttachmentData:myData mimeType:@"application/pdf" fileName:self.form.title];
    
    // Fill out the email body text
    NSString *emailBody = @"";
    [picker setMessageBody:emailBody isHTML:NO];
    
    picker.modalPresentationStyle = UIModalPresentationFormSheet;
    [self presentViewController:picker animated:YES completion:NULL];
}


- (void)mailComposeController:(MFMailComposeViewController*)controller
          didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error
{
    
    // Notifies users about errors associated with the interface
    switch (result)
    {
        case MFMailComposeResultCancelled:
            NSLog(@"Result: Mail sending canceled");
            break;
        case MFMailComposeResultSaved:
            NSLog(@"Result: Mail saved");
            break;
        case MFMailComposeResultSent:
            NSLog(@"Result: Mail sent");
            break;
        case MFMailComposeResultFailed:
            NSLog(@"Result: Mail sending failed");
            break;
        default:
            NSLog(@"Result: Mail not sent");
            break;
    }
    
    [self dismissViewControllerAnimated:YES completion:NULL];
}

@end
