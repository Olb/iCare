

#import <UIKit/UIKit.h>
#import "BBFormSectionDelegate.h"
#import "FormSection.h"

@interface Group1ViewController : UIViewController
@property id <BBFormSectionDelegate> delegate;
@property FormSection * section;
+(NSString*) sectionTitle;
@end
