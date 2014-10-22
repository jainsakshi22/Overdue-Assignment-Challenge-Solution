//
//  EditTaskViewController.h
//  Overdue TaskList Assignment
//
//  Created by Sakshi Jain on 15/10/14.
//
//

#import <UIKit/UIKit.h>
#import "DetailTaskViewController.h"
#import "Task.h"

@protocol EditViewControllerDelegate <NSObject>

//@required
-(void)didUpdateTask : (Task *)task;

@end

@interface EditTaskViewController : UIViewController

@property(strong,nonatomic) Task *task;
@property (weak,nonatomic) id <EditViewControllerDelegate> delegate;

@property (strong, nonatomic) IBOutlet UITextField *textField;
@property (strong, nonatomic) IBOutlet UITextView *textView;
@property (strong, nonatomic) IBOutlet UIDatePicker *datePicker;

- (IBAction)actionBarButtonItemPressed:(UIBarButtonItem *)sender;

@end
