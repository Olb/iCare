//
//  PDFTestViewController.m
//  iCare2
//
//  Created by Billy Bray on 9/26/14.
//  Copyright (c) 2014 Spartan Systems Inc. All rights reserved.
//

#import "PDFTestViewController.h"
#import "Form.h"
#import "BBPdfGenerator.h"
@interface PDFTestViewController () <UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end

@implementation PDFTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.webView.delegate = self;
}

-(void)viewDidAppear:(BOOL)animated
{
    NSURL *url = [NSURL fileURLWithPath:[BBPdfGenerator getPDFFileNameForForm:self.form] isDirectory:NO];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:request];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

@end
