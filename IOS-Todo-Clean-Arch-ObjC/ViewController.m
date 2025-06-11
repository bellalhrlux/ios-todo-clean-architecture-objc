//
//  ViewController.m
//  IOS-Todo-Clean-Arch-ObjC
//
//  Created by Riseup Labs on 20/5/25.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSLog(@"ViewController loaded");
    
    // Set background color
    //self.view.backgroundColor = [UIColor systemBackgroundColor]; // Adaptive color (light/dark mode)
    self.view.backgroundColor = [UIColor whiteColor];
    
    //self.view.tintColor=[UIColor blueColor];
    
    
    // Create and configure the blue button
    UIButton *blueButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [blueButton setTitle:@"Blue Button" forState:UIControlStateNormal];
    [blueButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    blueButton.backgroundColor = [UIColor systemBlueColor];
    blueButton.layer.cornerRadius = 10.0;
    blueButton.titleLabel.font = [UIFont systemFontOfSize:18];
    
    // Set button frame (width: 200, height: 50)
    blueButton.frame = CGRectMake(0, 0, 200, 50);
    
    // Center the button in the view
    blueButton.center = self.view.center;
    
    // Add target action for button tap
    [blueButton addTarget:self action:@selector(blueButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
    
    // Add button to the view
    [self.view addSubview:blueButton];
    
    
}
// Button action method
- (void)blueButtonTapped:(UIButton *)sender {
    NSLog(@"Blue button was tapped!");
    // Add your button action code here
}


@end
