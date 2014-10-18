//
//  ViewController.m
//  Overdue TaskList Assignment
//
//  Created by Sakshi Jain on 15/10/14.
//
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

-(NSMutableArray *)taskObjects
{
    if (!_taskObjects)
    {
        _taskObjects = [[NSMutableArray alloc] init];
    }
    return _taskObjects;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    NSArray *tasksAsPropertyLists = [[NSUserDefaults standardUserDefaults] objectForKey:TASK_OBJECTS_KEY];
    
    for (NSDictionary *dictionary in tasksAsPropertyLists)
    {
        Task *taskObject = [self taskObjectForDictionary:dictionary ];
        [self.taskObjects addObject:taskObject];
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)reorderBarButtonItemPressed:(UIBarButtonItem *)sender {
}

- (IBAction)addBarButtonItemPressed:(UIBarButtonItem *)sender
{
    [self performSegueWithIdentifier:@"toAddTaskViewControllerSegue" sender:nil];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.destinationViewController isKindOfClass: [AddTaskViewController class]])
    {
        AddTaskViewController *AddTaskVC = segue.destinationViewController;
        AddTaskVC.delegate = self;
    }
}

#pragma mark - UITableViewDataSource method

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.taskObjects count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdenetifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdenetifier forIndexPath:indexPath];

    //Configure the cell
    Task *taskObject = [self.taskObjects objectAtIndex:indexPath.row];
    cell.textLabel.text = taskObject.title;

    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-mm-dd"];
    NSString *stringFromdate = [formatter stringFromDate:taskObject.date];
    cell.detailTextLabel.text = stringFromdate;
    
    return cell;
}

//#pragma mark - UITableViewDelegate method


#pragma mark - AddTaskViewControllerDelegate methods

-(void)didCancel
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)didAddTask:(Task *)task
{
    [self.taskObjects addObject:task];
    
    NSMutableArray *taskObjectsAsPropertyLists = [[[NSUserDefaults standardUserDefaults] arrayForKey:TASK_OBJECTS_KEY ] mutableCopy];
    if (!taskObjectsAsPropertyLists) taskObjectsAsPropertyLists = [[NSMutableArray alloc] init];
    
    [taskObjectsAsPropertyLists addObject:[self taskObjectAsAPropertyList:task]];
    [[NSUserDefaults standardUserDefaults] setObject:taskObjectsAsPropertyLists forKey:TASK_OBJECTS_KEY];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    [self dismissViewControllerAnimated:YES completion:nil];
    [self.tableView reloadData];
}

#pragma mark - helper methods

//Helper method for -(void)didAddTask:(Task *)task method
-(NSDictionary *)taskObjectAsAPropertyList : (Task *)taskObject
{
    NSDictionary *dictionary = @{TASK_TITLE : taskObject.title, TASK_DESCRIPTION : taskObject.description, TASK_DATE: taskObject.date,TASK_COMPLETION: @(taskObject.isCompleted)};
    
    return dictionary;
}

//Helper method to access User Default in ViewDidLoad method
-(Task * )taskObjectForDictionary : (NSDictionary *)dictionary
{
    Task *taskObject = [[Task alloc] initWithData:dictionary];
    
    return taskObject;
}

@end
