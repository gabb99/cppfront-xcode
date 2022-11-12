
//  Copyright (c) Herb Sutter
//  SPDX-License-Identifier: CC-BY-NC-ND-4.0

// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.


//===========================================================================
//  cppfront
//===========================================================================

#include "cppfront.h"
#include "cppfront_impl.h"

#import <XCTest/XCTest.h>

//===========================================================================
//  main - driver
//===========================================================================

void cppfront(NSString* input, NSString* output, BOOL pure)
{
    std::cout << "Processing " << [[input lastPathComponent] UTF8String] << " ...";

    // Make a copy of the output, since it gets over written by lower_to_cpp1()
    NSString* expectedOutput = [NSString stringWithContentsOfFile:output
                                                         encoding:NSUTF8StringEncoding
                                                            error:NULL];

    XCTAssert([expectedOutput length] != 0);

    //  Load + lex + parse + sema
    cpp2::cppfront c([input UTF8String]);

    //  Generate Cpp1 (this may catch additional late errors)
    c.lower_to_cpp1();

    XCTAssert(c.had_no_errors());

    // Read-in the final output, to compare later on
    NSString* outputAsCpp = [NSString stringWithContentsOfFile:output
                                                      encoding:NSUTF8StringEncoding
                                                         error:NULL];

    XCTAssert([outputAsCpp length] != 0);
    XCTAssertEqualObjects(expectedOutput, outputAsCpp);
}
