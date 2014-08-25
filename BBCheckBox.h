//
//  BBCheckBox.h
//  iCare
//
//  Created by Billy Bray on 2/5/14.
//  Copyright (c) 2014 Billy Bray. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BBCheckBox : UIButton

@property (nonatomic, retain) UIImage *notSelectedImage;
@property (nonatomic, retain) UIImage *selectedImage;
@property (nonatomic, copy) NSString *notSelectedImageName;
@property (nonatomic, copy) NSString *selectedImageName;
-(IBAction)setNotSelected:(id)sender;
@end
