

#import <UIKit/UIKit.h>
#import "BBFormSectionDelegate.h"
#import "FormSection.h"

@interface RespiratoryViewController : UIViewController
@property id <BBFormSectionDelegate> delegate;
@property FormSection * section;
+(NSString*) sectionTitle;
@end
