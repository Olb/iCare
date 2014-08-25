//
//  BBCheckBox.m
//  iCare
//
//  Created by Billy Bray on 2/5/14.
//  Copyright (c) 2014 Billy Bray. All rights reserved.
//

#import "BBCheckBox.h"

@implementation BBCheckBox

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

-(IBAction)setNotSelected:(id)sender {
    [self setSelected:false];
}

- (void) setSelected: (BOOL) newValue;
{
	if (newValue != self.isSelected)
	{
		[super setSelected: newValue];
		if (newValue)
			[self setImage: _selectedImage forState: UIControlStateNormal];
        else
			[self setImage: _notSelectedImage forState: UIControlStateNormal];
	}
}

-(void) setNotSelectedImage: (UIImage*) newImage;
{
    _notSelectedImage = newImage;
    if (!self.isSelected)
    {
        [self setImage: _notSelectedImage forState: UIControlStateNormal];
    }
}

- (void) setSelectedImageName: (NSString *) newValue;
{
    _selectedImageName = [newValue copy];
    self.selectedImage = [UIImage imageNamed: _selectedImageName];
}

//------------------------------------------------------------------------------------------------------

- (void) setNotSelectedImageName: (NSString *) newValue;
{
    _notSelectedImageName = [newValue copy];
    self.notSelectedImage = [UIImage imageNamed: _notSelectedImageName];
}

-(void) setSelectedImage: (UIImage*) newImage;
{
    _selectedImage = newImage;
    if (self.isSelected)
    {
        //UIButtons don't use their "selected" state, so set the non-selected state.
        [self setImage: _selectedImage forState: UIControlStateNormal];
    }
}

- (void)endTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event
{
    [super endTrackingWithTouch:touch withEvent:event];
    if (CGRectContainsPoint(self.bounds,[touch locationInView: self]))
    {
        self.selected = !self.selected;
        [self sendActionsForControlEvents:UIControlEventValueChanged];
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/



@end
