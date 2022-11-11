
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

//===========================================================================
//  main - driver
//===========================================================================

static auto enable_debug_output_files = false;

BOOL cppfront(NSString* input, NSString* output, BOOL pure)
{
    // Will need to convert to project related base.

    std::cout << [input UTF8String] << "...";

    //  Load + lex + parse + sema
    cpp2::cppfront c([input UTF8String]);

    //  Generate Cpp1 (this may catch additional late errors)
    c.lower_to_cpp1();

    //  If there were no errors, say so and generate Cpp1
    if (c.had_no_errors()) {
        if (!c.has_cpp1()) {
            std::cout << " ok (all Cpp2, passes safety checks)\n\n";
        }
        else if (c.has_cpp2()) {
            std::cout << " ok (mixed Cpp1/Cpp2, Cpp2 code passes safety checks)\n\n";
        }
        else {
            std::cout << " ok (all Cpp1)\n\n";
        }
    }
    //  Otherwise, print the errors
    else {
        std::cout << "\n";
        c.print_errors();
        std::cout << "\n";
    }

    //  In any case, emit the debug information (during early development this is
    //  on by default, later we'll flip the switch to turn it on instead of off)
    if (enable_debug_output_files) {
        c.debug_print();
    }

    return c.had_no_errors();
}
