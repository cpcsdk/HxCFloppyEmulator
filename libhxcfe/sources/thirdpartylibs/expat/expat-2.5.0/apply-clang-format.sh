#! /usr/bin/env bash
#                          __  __            _
#                       ___\ \/ /_ __   __ _| |_
#                      / _ \\  /| '_ \ / _` | __|
#                     |  __//  \| |_) | (_| | |_
#                      \___/_/\_\ .__/ \__,_|\__|
#                               |_| XML parser
#
# Copyright (c) 2019-2022 Sebastian Pipping <sebastian@pipping.org>
# Copyright (c) 2022      Rosen Penev <rosenp@gmail.com>
# Licensed under the MIT license:
#
# Permission is  hereby granted,  free of charge,  to any  person obtaining
# a  copy  of  this  software   and  associated  documentation  files  (the
# "Software"),  to  deal in  the  Software  without restriction,  including
# without  limitation the  rights  to use,  copy,  modify, merge,  publish,
# distribute, sublicense, and/or sell copies of the Software, and to permit
# persons  to whom  the Software  is  furnished to  do so,  subject to  the
# following conditions:
#
# The above copyright  notice and this permission notice  shall be included
# in all copies or substantial portions of the Software.
#
# THE  SOFTWARE  IS  PROVIDED  "AS  IS",  WITHOUT  WARRANTY  OF  ANY  KIND,
# EXPRESS  OR IMPLIED,  INCLUDING  BUT  NOT LIMITED  TO  THE WARRANTIES  OF
# MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN
# NO EVENT SHALL THE AUTHORS OR  COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM,
# DAMAGES OR  OTHER LIABILITY, WHETHER  IN AN  ACTION OF CONTRACT,  TORT OR
# OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE
# USE OR OTHER DEALINGS IN THE SOFTWARE.

set -e
set -u
set -o pipefail

clang-format --version

clang_format_args=(
    -i
    -style=file
    -verbose
)

if [[ $# -ge 1 ]]; then
    exec clang-format "${clang_format_args[@]}" "$@"
fi

expand --tabs=2 --initial lib/siphash.h | sponge lib/siphash.h

find . \
        -name '*.[ch]' \
        -o -name '*.cpp' \
        -o -name '*.cxx' \
        -o -name '*.h.cmake' \
    | sort \
    | xargs clang-format "${clang_format_args[@]}"

sed \
        -e 's, @$,@,' \
        -e 's,#\( \+\)cmakedefine,#cmakedefine,' \
        -i \
        expat_config.h.cmake
