

#import <UIKit/UIKit.h>
#import "BBFormSectionDelegate.h"
#import "FormSection.h"

@interface MedicationsSupplementsViewController : UIViewController
@property id <BBFormSectionDelegate> delegate;
@property FormSection * section;

+(NSString*) sectionTitle;
@end
