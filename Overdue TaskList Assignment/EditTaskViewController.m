//
//  EditTaskViewController.m
//  Overdue TaskList Assignment
//
//  Created by Sakshi Jain on 15/10/14.
//
//

#import "EditTaskViewController.h"

@interface EditTaskViewController ()

@end

@implementation EditTaskViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.textField.text = self.task.title;
    self.textView.text = self.task.description1;
    self.datePicker.date = self.task.date;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)actionBarButtonItemPressed:(UIBarButtonItem *)sender
{
    [self updateTask];
    [self.delegate didUpdateTask:[self updateTask]];
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark -helper method

-(Task *)updateTask
{
    self.task.title = self.textField.text;
    self.task.description1 = self.textView.text;
    self.task.date = self.datePicker.date;
    
    return self.task;
}

@end
