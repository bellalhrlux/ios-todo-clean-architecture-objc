//
//  AddTodoViewController.m
//  IOS-Todo-Clean-Arch-ObjC
//
#import "AddTodoViewController.h"
#import "Todo.h"

@interface AddTodoViewController () <UITextFieldDelegate, UITextViewDelegate>

@property (nonatomic, strong) UITextField *titleTextField;
@property (nonatomic, strong) UITextView *descriptionTextView;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIView *contentView;

@end

@implementation AddTodoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Add Todo";
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setupNavigationBar];
    [self setupViews];
    [self setupKeyboardNotifications];
}

- (void)setupNavigationBar {
    UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel
                                                                                  target:self
                                                                                  action:@selector(cancelButtonTapped)];
    self.navigationItem.leftBarButtonItem = cancelButton;
    
    UIBarButtonItem *saveButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave
                                                                                target:self
                                                                                action:@selector(saveButtonTapped)];
    self.navigationItem.rightBarButtonItem = saveButton;
}

- (void)setupViews {
    // Scroll View
    self.scrollView = [[UIScrollView alloc] init];
    self.scrollView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:self.scrollView];
    
    // Content View
    self.contentView = [[UIView alloc] init];
    self.contentView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.scrollView addSubview:self.contentView];
    
    // Title TextField
    self.titleTextField = [[UITextField alloc] init];
    self.titleTextField.placeholder = @"Enter todo title";
    self.titleTextField.borderStyle = UITextBorderStyleRoundedRect;
    self.titleTextField.delegate = self;
    self.titleTextField.translatesAutoresizingMaskIntoConstraints = NO;
    [self.contentView addSubview:self.titleTextField];
    
    // Description TextView
    self.descriptionTextView = [[UITextView alloc] init];
    self.descriptionTextView.font = [UIFont systemFontOfSize:16];
    self.descriptionTextView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.descriptionTextView.layer.borderWidth = 1.0;
    self.descriptionTextView.layer.cornerRadius = 8.0;
    self.descriptionTextView.delegate = self;
    self.descriptionTextView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.contentView addSubview:self.descriptionTextView];
    
    // Constraints
    [NSLayoutConstraint activateConstraints:@[
        [self.scrollView.topAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.topAnchor],
        [self.scrollView.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor],
        [self.scrollView.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor],
        [self.scrollView.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor],
        
        [self.contentView.topAnchor constraintEqualToAnchor:self.scrollView.topAnchor],
        [self.contentView.leadingAnchor constraintEqualToAnchor:self.scrollView.leadingAnchor],
        [self.contentView.trailingAnchor constraintEqualToAnchor:self.scrollView.trailingAnchor],
        [self.contentView.bottomAnchor constraintEqualToAnchor:self.scrollView.bottomAnchor],
        [self.contentView.widthAnchor constraintEqualToAnchor:self.scrollView.widthAnchor],
        
        [self.titleTextField.topAnchor constraintEqualToAnchor:self.contentView.topAnchor constant:20],
        [self.titleTextField.leadingAnchor constraintEqualToAnchor:self.contentView.leadingAnchor constant:16],
        [self.titleTextField.trailingAnchor constraintEqualToAnchor:self.contentView.trailingAnchor constant:-16],
        [self.titleTextField.heightAnchor constraintEqualToConstant:44],
        
        [self.descriptionTextView.topAnchor constraintEqualToAnchor:self.titleTextField.bottomAnchor constant:20],
        [self.descriptionTextView.leadingAnchor constraintEqualToAnchor:self.contentView.leadingAnchor constant:16],
        [self.descriptionTextView.trailingAnchor constraintEqualToAnchor:self.contentView.trailingAnchor constant:-16],
        [self.descriptionTextView.heightAnchor constraintEqualToConstant:120],
        [self.descriptionTextView.bottomAnchor constraintEqualToAnchor:self.contentView.bottomAnchor constant:-20]
    ]];
}

- (void)setupKeyboardNotifications {
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
}

- (void)keyboardWillShow:(NSNotification *)notification {
    CGRect keyboardFrame = [[[notification userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGFloat keyboardHeight = keyboardFrame.size.height;
    
    UIEdgeInsets contentInsets = UIEdgeInsetsMake(0.0, 0.0, keyboardHeight, 0.0);
    self.scrollView.contentInset = contentInsets;
    self.scrollView.scrollIndicatorInsets = contentInsets;
}

- (void)keyboardWillHide:(NSNotification *)notification {
    self.scrollView.contentInset = UIEdgeInsetsZero;
    self.scrollView.scrollIndicatorInsets = UIEdgeInsetsZero;
}

- (void)cancelButtonTapped {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)saveButtonTapped {
    NSString *title = [self.titleTextField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSString *description = [self.descriptionTextView.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    if (title.length == 0) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Error"
                                                                       message:@"Please enter a title for your todo"
                                                                preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
        [alert addAction:okAction];
        [self presentViewController:alert animated:YES completion:nil];
        return;
    }
    
    Todo *todo = [[Todo alloc] initWithId:0
                                    title:title
                              description:description.length > 0 ? description : @""
                              isCompleted:NO
                              createdDate:[NSDate date]];
    
    [self.todoUseCases createTodo:todo completion:^(BOOL success, NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if (success) {
                if (self.onTodoAdded) {
                    self.onTodoAdded();
                }
                [self dismissViewControllerAnimated:YES completion:nil];
            } else {
                UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Error"
                                                                               message:@"Failed to save todo. Please try again."
                                                                        preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
                [alert addAction:okAction];
                [self presentViewController:alert animated:YES completion:nil];
            }
        });
    }];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end

