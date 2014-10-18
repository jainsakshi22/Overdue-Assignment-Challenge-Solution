//
//  ViewController.h
//  Overdue TaskList Assignment
//
//  Created by Sakshi Jain on 15/10/14.
//
//

#import <UIKit/UIKit.h>
#import "AddTaskViewController.h"
#import "DetailTaskViewController.h"

@interface ViewController : UIViewController <AddTaskViewControllerDelegate,UITableViewDataSource,UITableViewDelegate>

@property (strong,nonatomic) NSMutableArray *taskObjects;

@property (strong, nonatomic) IBOutlet UITableView *tableView;

- (IBAction)reorderBarButtonItemPressed:(UIBarButtonItem *)sender;
- (IBAction)addBarButtonItemPressed:(UIBarButtonItem *)sender;

@end

