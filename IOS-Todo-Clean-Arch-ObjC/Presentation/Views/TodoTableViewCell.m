//
//  TodoTableViewCell.m
//  IOS-Todo-Clean-Arch-ObjC
//
#import "TodoTableViewCell.h"

@interface TodoTableViewCell()
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *descriptionLabel;
@property (nonatomic, strong) UIButton *completionButton;
@property (nonatomic, strong) Todo *todo;
@end

@implementation TodoTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupViews];
    }
    return self;
}

- (void)setupViews {
    // Title Label
    self.titleLabel = [[UILabel alloc] init];
    self.titleLabel.font = [UIFont boldSystemFontOfSize:16];
    self.titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [self.contentView addSubview:self.titleLabel];
    
    // Description Label
    self.descriptionLabel = [[UILabel alloc] init];
    self.descriptionLabel.font = [UIFont systemFontOfSize:14];
    self.descriptionLabel.textColor = [UIColor whiteColor];
    self.descriptionLabel.numberOfLines = 0;
    self.descriptionLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [self.contentView addSubview:self.descriptionLabel];
    
    // Completion Button
    self.completionButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.completionButton setTitle:@"☐" forState:UIControlStateNormal];
    self.completionButton.titleLabel.font = [UIFont systemFontOfSize:20];
    [self.completionButton addTarget:self action:@selector(completionButtonTapped) forControlEvents:UIControlEventTouchUpInside];
    self.completionButton.translatesAutoresizingMaskIntoConstraints = NO;
    [self.contentView addSubview:self.completionButton];
    
    // Constraints
    [NSLayoutConstraint activateConstraints:@[
        [self.completionButton.leadingAnchor constraintEqualToAnchor:self.contentView.leadingAnchor constant:16],
        [self.completionButton.centerYAnchor constraintEqualToAnchor:self.contentView.centerYAnchor],
        [self.completionButton.widthAnchor constraintEqualToConstant:30],
        [self.completionButton.heightAnchor constraintEqualToConstant:30],
        
        [self.titleLabel.leadingAnchor constraintEqualToAnchor:self.completionButton.trailingAnchor constant:12],
        [self.titleLabel.trailingAnchor constraintEqualToAnchor:self.contentView.trailingAnchor constant:-16],
        [self.titleLabel.topAnchor constraintEqualToAnchor:self.contentView.topAnchor constant:8],
        
        [self.descriptionLabel.leadingAnchor constraintEqualToAnchor:self.titleLabel.leadingAnchor],
        [self.descriptionLabel.trailingAnchor constraintEqualToAnchor:self.titleLabel.trailingAnchor],
        [self.descriptionLabel.topAnchor constraintEqualToAnchor:self.titleLabel.bottomAnchor constant:4],
        [self.descriptionLabel.bottomAnchor constraintEqualToAnchor:self.contentView.bottomAnchor constant:-8]
    ]];
}

- (void)configureWithTodo:(Todo *)todo {
    self.todo = todo;
    self.titleLabel.text = todo.title;
    self.descriptionLabel.text = todo.todoDescription;
    
    if (todo.isCompleted) {
        [self.completionButton setTitle:@"☑" forState:UIControlStateNormal];
        self.titleLabel.textColor = [UIColor grayColor];
        self.descriptionLabel.textColor = [UIColor lightGrayColor];
    } else {
        [self.completionButton setTitle:@"☐" forState:UIControlStateNormal];
        self.titleLabel.textColor = [UIColor whiteColor];
        self.descriptionLabel.textColor = [UIColor grayColor];
    }
}

- (void)completionButtonTapped {
    if (self.delegate && [self.delegate respondsToSelector:@selector(didToggleCompletionForTodo:)]) {
        [self.delegate didToggleCompletionForTodo:self.todo];
    }
}

@end
