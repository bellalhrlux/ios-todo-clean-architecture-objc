//
//  TodoListViewController.h
//  IOS-Todo-Clean-Arch-ObjC
//
#import <UIKit/UIKit.h>
#import "TodoUseCases.h"

@interface TodoListViewController : UIViewController

@property (nonatomic, strong) TodoUseCases *todoUseCases;

@end
