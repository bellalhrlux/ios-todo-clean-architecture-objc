//
//  TodoUseCases.h
//  IOS-Todo-Clean-Arch-ObjC
//


#import <Foundation/Foundation.h>
#import "TodoRepositoryProtocol.h"
#import "Todo.h"

@interface TodoUseCases : NSObject

@property (nonatomic, strong) id<TodoRepositoryProtocol> repository;

- (instancetype)initWithRepository:(id<TodoRepositoryProtocol>)repository;
- (void)createTodo:(Todo *)todo completion:(void(^)(BOOL success, NSError *error))completion;
- (void)getAllTodosWithCompletion:(void(^)(NSArray<Todo *> *todos, NSError *error))completion;
- (void)toggleTodoCompletion:(Todo *)todo completion:(void(^)(BOOL success, NSError *error))completion;
- (void)deleteTodoWithId:(NSInteger)todoId completion:(void(^)(BOOL success, NSError *error))completion;

@end
