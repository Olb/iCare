

#import <UIKit/UIKit.h>
#import "BBFormSectionDelegate.h"
#import "FormSection.h"

@interface PersonnelViewController : UIViewController
@property id <BBFormSectionDelegate> delegate;
@property FormSection * section;
+(NSString*) sectionTitle;
@end
