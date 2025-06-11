//
//  SceneDelegate.m
//  IOS-Todo-Clean-Arch-ObjC
//
//  Created by Riseup Labs on 20/5/25.
//

#import "SceneDelegate.h"
#import "TodoListViewController.h"
#import "DatabaseManager.h"
#import "TodoRepository.h"
#import "TodoUseCases.h"

@interface SceneDelegate ()

@end

@implementation SceneDelegate


- (void)scene:(UIScene *)scene willConnectToSession:(UISceneSession *)session options:(UISceneConnectionOptions *)connectionOptions {
    // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
    // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
    // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
    
    // Cast to UIWindowScene
    UIWindowScene *windowScene = (UIWindowScene *)scene;
    
    // Initialize Database
    DatabaseManager *databaseManager = [DatabaseManager sharedInstance];
    if (![databaseManager openDatabase]) {
        NSLog(@"Failed to open database");
        return;
    }
    
    // Setup Dependencies
    TodoRepository *todoRepository = [[TodoRepository alloc] initWithDatabaseManager:databaseManager];
    TodoUseCases *todoUseCases = [[TodoUseCases alloc] initWithRepository:todoRepository];
    
    // Setup Main View Controller
    TodoListViewController *todoListVC = [[TodoListViewController alloc] init];
    todoListVC.todoUseCases = todoUseCases;
    
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:todoListVC];
    
    // Setup Window with windowScene
    self.window = [[UIWindow alloc] initWithWindowScene:windowScene];
    self.window.rootViewController = navigationController;
    [self.window makeKeyAndVisible];
}


- (void)sceneDidDisconnect:(UIScene *)scene {
    // Called as the scene is being released by the system.
    // This occurs shortly after the scene enters the background, or when its session is discarded.
    // Release any resources associated with this scene that can be re-created the next time the scene connects.
    // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
}


- (void)sceneDidBecomeActive:(UIScene *)scene {
    // Called when the scene has moved from an inactive state to an active state.
    // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
}


- (void)sceneWillResignActive:(UIScene *)scene {
    // Called when the scene will move from an active state to an inactive state.
    // This may occur due to temporary interruptions (ex. an incoming phone call).
}


- (void)sceneWillEnterForeground:(UIScene *)scene {
    // Called as the scene transitions from the background to the foreground.
    // Use this method to undo the changes made on entering the background.
}


- (void)sceneDidEnterBackground:(UIScene *)scene {
    // Called as the scene transitions from the foreground to the background.
    // Use this method to save data, release shared resources, and store enough scene-specific state information
    // to restore the scene back to its current state.
    [[DatabaseManager sharedInstance] closeDatabase];
}



@end
