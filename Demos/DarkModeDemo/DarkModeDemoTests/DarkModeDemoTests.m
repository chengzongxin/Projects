//
//  DarkModeDemoTests.m
//  DarkModeDemoTests
//
//  Created by Joe.cheng on 2021/4/15.
//

#import <XCTest/XCTest.h>
#import "ViewController.h"

@interface DarkModeDemoTests : XCTestCase

@end

@implementation DarkModeDemoTests

- (void)setUp {
    // Put setup code here. This method is called before the invocation of each test method in the class.
    // 准备输入
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
}

- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
    

    // 验证输出
//    XCTAssert(isToday, @"isToday false");
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
        
        NSString *dateString = @"2000-01-01";

        
        // 需要测试的方法
        
        BOOL isToday = YES;
        
        ViewController *vc = ViewController.new;
        NSInteger count = vc.view.subviews.count;
        XCTAssertTrue(count > 3,@"count = %zd",count);
    }];
}

@end
