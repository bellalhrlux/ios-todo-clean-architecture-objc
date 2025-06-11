//
//  TodoRepository.h
//  IOS-Todo-Clean-Arch-ObjC
//
//  Created by Riseup Labs on 11/6/25.
//

#import <Foundation/Foundation.h>
#import "TodoRepositoryProtocol.h"
#import "DatabaseManager.h"

@interface TodoRepository : NSObject <TodoRepositoryProtocol>

- (instancetype)initWithDatabaseManager:(DatabaseManager *)databaseManager;

@end
