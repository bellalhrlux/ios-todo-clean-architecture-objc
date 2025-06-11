//
//  TodoTableViewCell.h
//  IOS-Todo-Clean-Arch-ObjC
//
#import <UIKit/UIKit.h>
#import "Todo.h"

@protocol TodoTableViewCellDelegate <NSObject>
- (void)didToggleCompletionForTodo:(Todo *)todo;
@end

@interface TodoTableViewCell : UITableViewCell

@property (nonatomic, weak) id<TodoTableViewCellDelegate> delegate;

- (void)configureWithTodo:(Todo *)todo;

@end
