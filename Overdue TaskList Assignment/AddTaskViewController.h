//
//  AddTaskViewController.h
//  Overdue TaskList Assignment
//
//  Created by Sakshi Jain on 15/10/14.
//
//

#import <UIKit/UIKit.h>
#import "Task.h"

@protocol AddTaskViewControllerDelegate <NSObject>

-(void)didCancel;
-(void)didAddTask : (Task *)task;

@end

@interface AddTaskViewController : UIViewController

@property (weak,nonatomic) id <AddTaskViewControllerDelegate> delegate;

@property (strong, nonatomic) IBOutlet UITextField *textField;
@property (strong, nonatomic) IBOutlet UITextView *textView;
@property (strong, nonatomic) IBOutlet UIDatePicker *datePicker;

- (IBAction)addTaskBarButtonItemPressed:(UIButton *)sender;
- (IBAction)cancelBarButtonItemPressed:(UIButton *)sender;

@end
