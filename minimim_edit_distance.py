"""
Minimum Edit Distance, adapted from an example in java by Adnan Aziz.

:author: Robert David Grant <robert.david.grant@gmail.com>

:copyright: 
    Copyright 2011 Robert David Grant

    Licensed under the Apache License, Version 2.0 (the "License"); you
    may not use this file except in compliance with the License.  You
    may obtain a copy of the License at

       http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or
    implied.  See the License for the specific language governing
    permissions and limitations under the License.
"""

class MED:

    def __init__(self):
        self.cache = []

    def init_cache(self, N, M):
        self.cache = []
        for i in range(N):
            self.cache.append([-1] * M)

    def d(self, s1, s2):

        if self.cache[len(s1)][len(s2)] != -1:
            return self.cache[len(s1)][len(s2)]

        # Both strings are empty or 1 is
        # d('', '') == 0 
        # d(s, '') == d('', s) == len(s)
        if s1=='' or s2=='':
            result = max(len(s1), len(s2))
        # Last characters don't match
        elif s1[-1] == s2[-1]:
            result = min( self.d(s1[0:-1], s2[0:-1]),# match characters
                          self.d(s1, s2[0:-1]) + 1 ) # insert s2[-1]
        # Last characters match
        else:
            result = min( self.d(s1[0:-1], s2) + 2,  # delete last and insert
                          self.d(s1, s2[0:-1]) + 1 ) # just insert s2[-1]

        self.cache[len(s1)][len(s2)] = result
        return result

    def test(self, s1, s2, expected):
        self.init_cache(len(s1) + 1, len(s2) + 1)
        success = 'PASSED' if (self.d(s1, s2) == expected) else 'FAILED'
        print success + ": d('" + s1 + "', '" + s2 + "')"


if __name__ == '__main__':
    m = MED()
    m.test("abc", "abc", 0)
    m.test("abc", "bcd", 2)
    m.test("abcdefg", "abcdefg", 0)
    m.test("abcdefg", "", 7)
    m.test("abcdefg", "ABCDEFG", 14)
    m.test("abcdefg", "abcdefgABCDEFG", 7)
    m.test("", "", 0)
    m.test("a", "A", 2)
    m.test("a", "ab", 1)
    m.test("abc", "c", 2)
