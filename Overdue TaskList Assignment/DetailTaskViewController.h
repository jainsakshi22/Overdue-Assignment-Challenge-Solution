//
//  DetailTaskViewController.h
//  Overdue TaskList Assignment
//
//  Created by Sakshi Jain on 15/10/14.
//
//

#import <UIKit/UIKit.h>
#import "Task.h"
#import "EditTaskViewController.h"

@interface DetailTaskViewController : UIViewController //<EditViewControllerDelegate>

@property (strong,nonatomic) Task *task;

@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UILabel *dateLabel;
@property (strong, nonatomic) IBOutlet UILabel *detailLabel;

- (IBAction)editBarButtonItemPressed:(UIBarButtonItem *)sender;


@end
