//
//  AddTodoViewController.h
//  IOS-Todo-Clean-Arch-ObjC
//


#import <UIKit/UIKit.h>
#import "TodoUseCases.h"

@interface AddTodoViewController : UIViewController

@property (nonatomic, strong) TodoUseCases *todoUseCases;
@property (nonatomic, copy) void (^onTodoAdded)(void);

@end
