//
//  passthrough_tests.mm
//  passthrough-tests
//
//  Created by Gabriel Beauchemin on 11/11/22.
//

#import <XCTest/XCTest.h>
#import "cppfront.h"

@interface passthrough_tests : XCTestCase

@end

@implementation passthrough_tests

- (void)setUp {
    // Put setup code here. This method is called before the invocation of each test method in the class.
/*
    g++-10 all-std.cxx -std=c++2a -E > gcc-10-libstdc++-e.cpp2

    clang++-12 all-std.cxx -std=c++2a -E > clang-12-libstdc++-e.cpp2

    cl all-std.cxx -std:c++latest /E > msvc-msstl-e.cpp2
*/
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
}

- (void)test_mvsc {
//    cppfront msvc-msstl-e.cpp2
//    diff -s -Z msvc-msstl-e.cpp2 msvc-msstl-e.cpp

  NSString* input = [[NSBundle bundleForClass:[self class]] pathForResource:@"msvc-msstl-e"
                                                                     ofType:@"cpp2"
                                                                inDirectory:@"passthrough-tests"];

  NSString* output = [[NSBundle bundleForClass:[self class]] pathForResource:@"msvc-msstl-e"
                                                                      ofType:@"cpp"
                                                                 inDirectory:@"passthrough-tests"];

  cppfront(input, output, FALSE);
}

- (void)test_gcc10 {
//    cppfront gcc-10-libstdc++-e.cpp2
//    diff -s -Z gcc-10-libstdc++-e.cpp2 gcc-10-libstdc++-e.cpp

  NSString* input = [[NSBundle bundleForClass:[self class]] pathForResource:@"gcc-10-libstdc++-e"
                                                                     ofType:@"cpp2"
                                                                inDirectory:@"passthrough-tests"];

  NSString* output = [[NSBundle bundleForClass:[self class]] pathForResource:@"gcc-10-libstdc++-e"
                                                                      ofType:@"cpp"
                                                                 inDirectory:@"passthrough-tests"];
  
  cppfront(input, output, FALSE);
}

- (void)test_clang12 {
//    cppfront clang-12-libstdc++-e.cpp2
//    diff -s -Z clang-12-libstdc++-e.cpp2 clang-12-libstdc++-e.cpp

  NSString* input = [[NSBundle bundleForClass:[self class]] pathForResource:@"clang-12-libstdc++-e"
                                                                     ofType:@"cpp2"
                                                                inDirectory:@"passthrough-tests"];

  NSString* output = [[NSBundle bundleForClass:[self class]] pathForResource:@"clang-12-libstdc++-e"
                                                                      ofType:@"cpp"
                                                                 inDirectory:@"passthrough-tests"];

  cppfront(input, output, FALSE);
}

@end
