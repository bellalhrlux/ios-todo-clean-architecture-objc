//
//  Todo.m
//  IOS-Todo-Clean-Arch-ObjC
//

#import "Todo.h"

@implementation Todo

- (instancetype)initWithId:(NSInteger)todoId
                     title:(NSString *)title
               description:(NSString *)description
               isCompleted:(BOOL)isCompleted
               createdDate:(NSDate *)createdDate {
    self = [super init];
    if (self) {
        _todoId = todoId;
        _title = title;
        _todoDescription = description;
        _isCompleted = isCompleted;
        _createdDate = createdDate;
    }
    return self;
}

@end
