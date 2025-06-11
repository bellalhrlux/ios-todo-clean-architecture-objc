//
//  DatabaseManager.m
//  IOS-Todo-Clean-Arch-ObjC
//
#import "DatabaseManager.h"

@interface DatabaseManager()
@property (nonatomic, assign) sqlite3 *database;
@end

@implementation DatabaseManager

+ (instancetype)sharedInstance {
    static DatabaseManager *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

- (BOOL)openDatabase {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *databasePath = [documentsDirectory stringByAppendingPathComponent:@"TodoApp.db"];
    
    if (sqlite3_open([databasePath UTF8String], &_database) == SQLITE_OK) {
        return [self createTables];
    } else {
        NSLog(@"Unable to open database");
        return NO;
    }
}

- (void)closeDatabase {
    if (_database) {
        sqlite3_close(_database);
        _database = nil;
    }
}

- (BOOL)createTables {
    const char *sql = "CREATE TABLE IF NOT EXISTS todos ("
                      "id INTEGER PRIMARY KEY AUTOINCREMENT, "
                      "title TEXT NOT NULL, "
                      "description TEXT, "
                      "is_completed INTEGER DEFAULT 0, "
                      "created_date REAL);";
    
    char *errorMessage;
    if (sqlite3_exec(_database, sql, NULL, NULL, &errorMessage) != SQLITE_OK) {
        NSLog(@"Error creating table: %s", errorMessage);
        sqlite3_free(errorMessage);
        return NO;
    }
    return YES;
}

- (sqlite3 *)database {
    return _database;
}

@end
