//
//  TodoRepository.m
//  IOS-Todo-Clean-Arch-ObjC
//
#import "TodoRepository.h"
#import "Todo.h"

@interface TodoRepository()
@property (nonatomic, strong) DatabaseManager *databaseManager;
@end

@implementation TodoRepository

- (instancetype)initWithDatabaseManager:(DatabaseManager *)databaseManager {
    self = [super init];
    if (self) {
        _databaseManager = databaseManager;
    }
    return self;
}

- (void)createTodo:(Todo *)todo completion:(void(^)(BOOL success, NSError *error))completion {
    const char *sql = "INSERT INTO todos (title, description, is_completed, created_date) VALUES (?, ?, ?, ?);";
    sqlite3_stmt *statement;
    
    if (sqlite3_prepare_v2([self.databaseManager database], sql, -1, &statement, NULL) == SQLITE_OK) {
        sqlite3_bind_text(statement, 1, [todo.title UTF8String], -1, SQLITE_TRANSIENT);
        sqlite3_bind_text(statement, 2, [todo.todoDescription UTF8String], -1, SQLITE_TRANSIENT);
        sqlite3_bind_int(statement, 3, todo.isCompleted ? 1 : 0);
        sqlite3_bind_double(statement, 4, [todo.createdDate timeIntervalSince1970]);
        
        if (sqlite3_step(statement) == SQLITE_DONE) {
            completion(YES, nil);
        } else {
            NSError *error = [NSError errorWithDomain:@"DatabaseError" code:1 userInfo:@{NSLocalizedDescriptionKey: @"Failed to insert todo"}];
            completion(NO, error);
        }
    } else {
        NSError *error = [NSError errorWithDomain:@"DatabaseError" code:2 userInfo:@{NSLocalizedDescriptionKey: @"Failed to prepare statement"}];
        completion(NO, error);
    }
    
    sqlite3_finalize(statement);
}

- (void)getAllTodosWithCompletion:(void(^)(NSArray<Todo *> *todos, NSError *error))completion {
    NSMutableArray *todos = [[NSMutableArray alloc] init];
    const char *sql = "SELECT id, title, description, is_completed, created_date FROM todos ORDER BY created_date DESC;";
    sqlite3_stmt *statement;
    
    if (sqlite3_prepare_v2([self.databaseManager database], sql, -1, &statement, NULL) == SQLITE_OK) {
        while (sqlite3_step(statement) == SQLITE_ROW) {
            NSInteger todoId = sqlite3_column_int(statement, 0);
            NSString *title = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 1)];
            NSString *description = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 2)];
            BOOL isCompleted = sqlite3_column_int(statement, 3) == 1;
            NSTimeInterval timestamp = sqlite3_column_double(statement, 4);
            NSDate *createdDate = [NSDate dateWithTimeIntervalSince1970:timestamp];
            
            Todo *todo = [[Todo alloc] initWithId:todoId
                                            title:title
                                      description:description
                                      isCompleted:isCompleted
                                      createdDate:createdDate];
            [todos addObject:todo];
        }
        completion([todos copy], nil);
    } else {
        NSError *error = [NSError errorWithDomain:@"DatabaseError" code:3 userInfo:@{NSLocalizedDescriptionKey: @"Failed to fetch todos"}];
        completion(nil, error);
    }
    
    sqlite3_finalize(statement);
}

- (void)updateTodo:(Todo *)todo completion:(void(^)(BOOL success, NSError *error))completion {
    const char *sql = "UPDATE todos SET title = ?, description = ?, is_completed = ? WHERE id = ?;";
    sqlite3_stmt *statement;
    
    if (sqlite3_prepare_v2([self.databaseManager database], sql, -1, &statement, NULL) == SQLITE_OK) {
        sqlite3_bind_text(statement, 1, [todo.title UTF8String], -1, SQLITE_TRANSIENT);
        sqlite3_bind_text(statement, 2, [todo.todoDescription UTF8String], -1, SQLITE_TRANSIENT);
        sqlite3_bind_int(statement, 3, todo.isCompleted ? 1 : 0);
        sqlite3_bind_int(statement, 4, (int)todo.todoId);
        
        if (sqlite3_step(statement) == SQLITE_DONE) {
            completion(YES, nil);
        } else {
            NSError *error = [NSError errorWithDomain:@"DatabaseError" code:4 userInfo:@{NSLocalizedDescriptionKey: @"Failed to update todo"}];
            completion(NO, error);
        }
    } else {
        NSError *error = [NSError errorWithDomain:@"DatabaseError" code:5 userInfo:@{NSLocalizedDescriptionKey: @"Failed to prepare update statement"}];
        completion(NO, error);
    }
    
    sqlite3_finalize(statement);
}

- (void)deleteTodoWithId:(NSInteger)todoId completion:(void(^)(BOOL success, NSError *error))completion {
    const char *sql = "DELETE FROM todos WHERE id = ?;";
    sqlite3_stmt *statement;
    
    if (sqlite3_prepare_v2([self.databaseManager database], sql, -1, &statement, NULL) == SQLITE_OK) {
        sqlite3_bind_int(statement, 1, (int)todoId);
        
        if (sqlite3_step(statement) == SQLITE_DONE) {
            completion(YES, nil);
        } else {
            NSError *error = [NSError errorWithDomain:@"DatabaseError" code:6 userInfo:@{NSLocalizedDescriptionKey: @"Failed to delete todo"}];
            completion(NO, error);
        }
    } else {
        NSError *error = [NSError errorWithDomain:@"DatabaseError" code:7 userInfo:@{NSLocalizedDescriptionKey: @"Failed to prepare delete statement"}];
        completion(NO, error);
    }
    
    sqlite3_finalize(statement);
}

@end
