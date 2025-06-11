//
//  TodoRepositoryProtocol.h
//  IOS-Todo-Clean-Arch-ObjC
//
#import <Foundation/Foundation.h>
#import "Todo.h"

@protocol TodoRepositoryProtocol <NSObject>

- (void)createTodo:(Todo *)todo completion:(void(^)(BOOL success, NSError *error))completion;
- (void)getAllTodosWithCompletion:(void(^)(NSArray<Todo *> *todos, NSError *error))completion;
- (void)updateTodo:(Todo *)todo completion:(void(^)(BOOL success, NSError *error))completion;
- (void)deleteTodoWithId:(NSInteger)todoId completion:(void(^)(BOOL success, NSError *error))completion;

@end

