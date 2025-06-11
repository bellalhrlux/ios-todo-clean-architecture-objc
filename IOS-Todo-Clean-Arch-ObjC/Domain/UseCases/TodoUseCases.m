//
//  TodoUseCases.m
//  IOS-Todo-Clean-Arch-ObjC
//
#import "TodoUseCases.h"

@implementation TodoUseCases

- (instancetype)initWithRepository:(id<TodoRepositoryProtocol>)repository {
    self = [super init];
    if (self) {
        _repository = repository;
    }
    return self;
}

- (void)createTodo:(Todo *)todo completion:(void(^)(BOOL success, NSError *error))completion {
    [self.repository createTodo:todo completion:completion];
}

- (void)getAllTodosWithCompletion:(void(^)(NSArray<Todo *> *todos, NSError *error))completion {
    [self.repository getAllTodosWithCompletion:completion];
}

- (void)toggleTodoCompletion:(Todo *)todo completion:(void(^)(BOOL success, NSError *error))completion {
    todo.isCompleted = !todo.isCompleted;
    [self.repository updateTodo:todo completion:completion];
}

- (void)deleteTodoWithId:(NSInteger)todoId completion:(void(^)(BOOL success, NSError *error))completion {
    [self.repository deleteTodoWithId:todoId completion:completion];
}

@end

