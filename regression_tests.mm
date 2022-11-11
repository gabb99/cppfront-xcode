//
//  regression_tests.mm
//  regression-tests
//
//  Created by Gabriel Beauchemin on 11/11/22.
//

#import <XCTest/XCTest.h>
#import "cppfront.h"

@interface regression_tests : XCTestCase

@end

@implementation regression_tests

- (void)setUp {
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
}

- (void)testMixed {
  NSArray* dirs = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:@"regression-tests"
                                                                      error:NULL];

  [dirs enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
      NSString *filename = (NSString *)obj;
      NSString *extension = [[filename pathExtension] lowercaseString];
      if ([extension hasPrefix:@"mixed-"]) {
          NSString* result = [NSString stringWithFormat:@"%@%@%@", @"regression-tests/test-results/", filename, @".cpp"];
          XCTAssert(result);
      }
  }];
}

- (void)testPure {
  NSArray* dirs = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:@"regression-tests"
                                                                      error:NULL];

  [dirs enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
      NSString *filename = (NSString *)obj;
      NSString *extension = [[filename pathExtension] lowercaseString];
      if ([extension hasPrefix:@"pure-"]) {
          NSString* result = [NSString stringWithFormat:@"%@%@%@", @"regression-tests/test-results/", filename, @".cpp"];
          XCTAssert(result);
      }
  }];
}

@end
