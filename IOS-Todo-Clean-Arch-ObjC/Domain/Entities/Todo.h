//
//  Todo.h
//  IOS-Todo-Clean-Arch-ObjC
//

#import <Foundation/Foundation.h>

@interface Todo : NSObject

@property (nonatomic, assign) NSInteger todoId;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *todoDescription;
@property (nonatomic, assign) BOOL isCompleted;
@property (nonatomic, strong) NSDate *createdDate;

- (instancetype)initWithId:(NSInteger)todoId
                     title:(NSString *)title
               description:(NSString *)description
               isCompleted:(BOOL)isCompleted
               createdDate:(NSDate *)createdDate;

@end
