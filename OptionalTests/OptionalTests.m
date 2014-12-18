//
//  OptionalTests.m
//  OptionalTests
//
//  Created by ry1a1 on 12/18/14.
//
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>

#import "KASOptional.h"

@interface OptionalTests : XCTestCase
@property (nonatomic) KASOptional *emptyOptional;
@property (nonatomic) KASOptional *optionalWithPointer;
@property (nonatomic) KASOptional *optionalWithValue;
@end

@implementation OptionalTests {
    CGPoint point;
}

- (void)setUp {
    [super setUp];
    point = CGPointMake(0, 0);
    self.optionalWithPointer = [KASOptional instanceWithPointerToCObject:&point];
    self.optionalWithValue = [KASOptional instanceWithValue:@(1)];
    self.emptyOptional = [KASOptional new];
}

- (void)testAccessToOptionalWithPointer {
    XCTAssert(self.optionalWithPointer.hasPointer);
    XCTAssertNoThrow(self.optionalWithPointer.pointer);
    
    XCTAssert(!self.optionalWithPointer.hasValue);
    XCTAssertThrows(self.optionalWithPointer.value);
}

- (void)testAccessToOptionalWithValue {
    XCTAssert(self.optionalWithValue.hasValue);
    XCTAssertNoThrow(self.optionalWithValue.value);
}

- (void)testAccessToEmptyOptional {
    XCTAssert(!self.emptyOptional.hasPointer);
    XCTAssertThrows(self.emptyOptional.pointer);
    XCTAssert(!self.emptyOptional.hasValue);
    XCTAssertThrows(self.emptyOptional.value);
}

@end
