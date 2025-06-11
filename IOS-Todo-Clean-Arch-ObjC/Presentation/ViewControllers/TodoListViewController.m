//
//  TodoListViewController.m
//  IOS-Todo-Clean-Arch-ObjC
//
#import "TodoListViewController.h"
#import "TodoTableViewCell.h"
#import "AddTodoViewController.h"
#import "Todo.h"

@interface TodoListViewController () <UITableViewDataSource, UITableViewDelegate, TodoTableViewCellDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray<Todo *> *todos;
@property (nonatomic, strong) UIBarButtonItem *addButton;

@end

@implementation TodoListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Todo List";
    self.view.backgroundColor = [UIColor blackColor];
    self.todos = [[NSMutableArray alloc] init];
    
    [self setupNavigationBar];
    [self setupTableView];
    [self loadTodos];
}

- (void)setupNavigationBar {
    self.addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
                                                                   target:self
                                                                   action:@selector(addButtonTapped)];
    self.navigationItem.rightBarButtonItem = self.addButton;
}

- (void)setupTableView {
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self.tableView registerClass:[TodoTableViewCell class] forCellReuseIdentifier:@"TodoCell"];
    [self.view addSubview:self.tableView];
    
    [NSLayoutConstraint activateConstraints:@[
        [self.tableView.topAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.topAnchor],
        [self.tableView.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor],
        [self.tableView.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor],
        [self.tableView.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor]
    ]];
}

- (void)loadTodos {
    [self.todoUseCases getAllTodosWithCompletion:^(NSArray<Todo *> *todos, NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if (error) {
                NSLog(@"Error loading todos: %@", error.localizedDescription);
            } else {
                [self.todos removeAllObjects];
                [self.todos addObjectsFromArray:todos];
                [self.tableView reloadData];
            }
        });
    }];
}

- (void)addButtonTapped {
    AddTodoViewController *addTodoVC = [[AddTodoViewController alloc] init];
    addTodoVC.todoUseCases = self.todoUseCases;
    
    __weak typeof(self) weakSelf = self;
    addTodoVC.onTodoAdded = ^{
        [weakSelf loadTodos];
    };
    
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:addTodoVC];
    [self presentViewController:navController animated:YES completion:nil];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.todos.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TodoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TodoCell" forIndexPath:indexPath];
    cell.delegate = self;
    [cell configureWithTodo:self.todos[indexPath.row]];
    return cell;
}

#pragma mark - UITableViewDelegate

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        Todo *todo = self.todos[indexPath.row];
        [self.todoUseCases deleteTodoWithId:todo.todoId completion:^(BOOL success, NSError *error) {
            dispatch_async(dispatch_get_main_queue(), ^{
                if (success) {
                    [self.todos removeObjectAtIndex:indexPath.row];
                    [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
                } else {
                    NSLog(@"Error deleting todo: %@", error.localizedDescription);
                }
            });
        }];
    }
}

#pragma mark - TodoTableViewCellDelegate

- (void)didToggleCompletionForTodo:(Todo *)todo {
    [self.todoUseCases toggleTodoCompletion:todo completion:^(BOOL success, NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if (success) {
                [self.tableView reloadData];
            } else {
                NSLog(@"Error toggling todo completion: %@", error.localizedDescription);
            }
        });
    }];
}

@end
