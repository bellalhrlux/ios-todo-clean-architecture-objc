//
//  IOS_Todo_Clean_Arch_ObjCUITestsLaunchTests.m
//  IOS-Todo-Clean-Arch-ObjCUITests
//
//  Created by Riseup Labs on 20/5/25.
//

#import <XCTest/XCTest.h>

@interface IOS_Todo_Clean_Arch_ObjCUITestsLaunchTests : XCTestCase

@end

@implementation IOS_Todo_Clean_Arch_ObjCUITestsLaunchTests

+ (BOOL)runsForEachTargetApplicationUIConfiguration {
    return YES;
}

- (void)setUp {
    self.continueAfterFailure = NO;
}

- (void)testLaunch {
    XCUIApplication *app = [[XCUIApplication alloc] init];
    [app launch];

    // Insert steps here to perform after app launch but before taking a screenshot,
    // such as logging into a test account or navigating somewhere in the app

    XCTAttachment *attachment = [XCTAttachment attachmentWithScreenshot:XCUIScreen.mainScreen.screenshot];
    attachment.name = @"Launch Screen";
    attachment.lifetime = XCTAttachmentLifetimeKeepAlways;
    [self addAttachment:attachment];
}

@end
