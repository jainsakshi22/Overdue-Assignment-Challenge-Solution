//
//  Task.h
//  Overdue TaskList Assignment
//
//  Created by Sakshi Jain on 16/10/14.
//
//

#import <Foundation/Foundation.h>

@interface Task : NSObject

@property (strong,nonatomic) NSString *title;
//@property (strong,nonatomic) NSString *description;
@property (strong,nonatomic) NSString *description1;

@property (strong,nonatomic) NSDate *date;
@property (nonatomic) BOOL isCompleted;

-(id) initWithData :(NSDictionary *) data;

@end
