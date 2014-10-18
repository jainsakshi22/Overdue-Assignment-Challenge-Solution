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
    
    BOOL isOverDue = [self isDateGreaterThanDate:[NSDate date] and:taskObject.date];
    
    if (taskObject.isCompleted == YES) cell.backgroundColor = [UIColor greenColor];// If present date <task date and task is completed
    else if (isOverDue == YES) cell.backgroundColor = [UIColor redColor]; // If present date> Task date
    else cell.backgroundColor = [UIColor yellowColor];// If present date < task date and task is not completed
    
    return cell;
}

#pragma mark - UITableViewDelegate method

//Completion of task
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    Task *task = [self.taskObjects objectAtIndex:indexPath.row];
    [self updateCompletionOfTask:task forIndexPath:indexPath];
}

//Deletion of task
-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        [self.taskObjects removeObjectAtIndex:indexPath.row];
        
        NSMutableArray *newTaskDataObjects = [[NSMutableArray alloc] init];
        for (Task *task in self.taskObjects)
        {
            [newTaskDataObjects addObject:[self taskObjectAsAPropertyList:task]];
        }
        [[NSUserDefaults standardUserDefaults] setObject:newTaskDataObjects forKey:TASK_OBJECTS_KEY];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}


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

//To change the color coding
-(BOOL)isDateGreaterThanDate: (NSDate *) date and: (NSDate *)toDate
{
    int dateInterval = [date timeIntervalSince1970];
    int toDateInterval = [toDate timeIntervalSince1970];
    
    if (dateInterval > toDateInterval) return YES;
    else return NO;
}

//To change the completion of task. Used in -(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath method
-(void)updateCompletionOfTask : (Task *)task forIndexPath: (NSIndexPath *)indexPath
{
    NSMutableArray *taskObjectsAsPropertyLists = [[[NSUserDefaults standardUserDefaults] arrayForKey:TASK_OBJECTS_KEY] mutableCopy];
    if (!taskObjectsAsPropertyLists) taskObjectsAsPropertyLists = [[NSMutableArray alloc] init];
    [taskObjectsAsPropertyLists removeObjectAtIndex:indexPath.row];
    
    if (task.isCompleted == YES) task.isCompleted = NO; //change status on tapping, so that color can be changed to Green and Yellow/Red. Yelow or red will be decided on isDareGreaterThanDate method.
    else task.isCompleted = YES;
    
    [taskObjectsAsPropertyLists insertObject: [self taskObjectAsAPropertyList:task] atIndex:indexPath.row]; //Add object as a dictionary. so use taskObjectAsAPropertyList to insert the object
    [[NSUserDefaults standardUserDefaults] setObject:taskObjectsAsPropertyLists forKey:TASK_OBJECTS_KEY];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    [self.tableView reloadData];
    
}




@end
