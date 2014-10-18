//
//  Task.m
//  Overdue TaskList Assignment
//
//  Created by Sakshi Jain on 16/10/14.
//
//

#import "Task.h"

@implementation Task

-(id) init
{
    self = [self initWithData:nil];
    return self;
}

-(id) initWithData :(NSDictionary *) data
{
    self = [super init];
    
    if(self)
    {
        self.title = data[TASK_TITLE];
        self.description1 = data[TASK_DESCRIPTION];
        self.date = data[TASK_DATE];
        self.isCompleted = [data[TASK_COMPLETION] boolValue];
    }
    return self;
}

@end
