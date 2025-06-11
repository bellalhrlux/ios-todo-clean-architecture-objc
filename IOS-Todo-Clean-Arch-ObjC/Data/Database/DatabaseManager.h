//
//  DatabaseManager.h
//  IOS-Todo-Clean-Arch-ObjC
//
#import <Foundation/Foundation.h>
#import <sqlite3.h>

@interface DatabaseManager : NSObject

+ (instancetype)sharedInstance;
- (BOOL)openDatabase;
- (void)closeDatabase;
- (BOOL)createTables;
- (sqlite3 *)database;

@end
