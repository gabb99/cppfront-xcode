//
//  regression_tests.mm
//  regression-tests
//
//  Created by Gabriel Beauchemin on 11/11/22.
//

#import <XCTest/XCTest.h>
#import "cppfront.h"

@interface regression_tests : XCTestCase {

    NSString* resourcePath;
    NSArray* cpp2Array;
}

@end

@implementation regression_tests

- (void)setUp {
    // Put setup code here. This method is called before the invocation of each test method in the class.
    resourcePath = [NSBundle bundleForClass:[self class]].resourcePath;
    
    cpp2Array = [[NSBundle bundleForClass:[self class]] pathsForResourcesOfType:@"cpp2"
                                                                    inDirectory:@"regression-tests"];

}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
}

- (void)testMixed {

  [cpp2Array enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
      NSString *filename = [(NSString *)obj lastPathComponent];
      if ([filename hasPrefix:@"mixed-"]) {
          NSString* result = [NSString stringWithFormat:@"%@%@%@%@", resourcePath, @"/regression-tests/test-results/", [filename stringByDeletingPathExtension], @".cpp"];
          cppfront((NSString *)obj, result, FALSE);
      }
  }];
}

- (void)testPure {

    [cpp2Array enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
      NSString *filename = [(NSString *)obj lastPathComponent];
      if ([filename hasPrefix:@"pure2-"]) {
          NSString* result = [NSString stringWithFormat:@"%@%@%@%@", resourcePath, @"/regression-tests/test-results/", [filename stringByDeletingPathExtension], @".cpp"];
          cppfront((NSString *)obj, result, TRUE);
      }
  }];
}

@end
