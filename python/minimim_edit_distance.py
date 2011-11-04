"""
Minimum Edit Distance, , a.k.a. Levenshtein distance between two
strings.  

Adapted from an example in Java by Adnan Aziz.

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

def med(s1, s2):
    """Compute minimum edit distance between `s1` and `s2`.

    In other words, how many single-character insertions, deletions, or
    substitutions does it take to get from one string to the other?
    Dynamic programming solution.  See `Levenshtein Distance
    <https://en.wikipedia.org/wiki/Levenshtein_distance>`_.
    """
    def d(s1, s2):
        if cache[len(s1)][len(s2)] != -1:
            return cache[len(s1)][len(s2)]

        # Both strings are empty or 1 is
        # d('', '') == 0 
        # d(s, '') == d('', s) == len(s)
        if s1=='' or s2=='':
            result = max(len(s1), len(s2))
        # Last characters don't match
        elif s1[-1] == s2[-1]:
            result = min( d(s1[0:-1], s2[0:-1]),# match characters
                          d(s1, s2[0:-1]) + 1 ) # insert s2[-1]
        # Last characters match
        else:
            result = min( d(s1[0:-1], s2) + 2,  # delete last and insert
                          d(s1, s2[0:-1]) + 1 ) # just insert s2[-1]

        cache[len(s1)][len(s2)] = result
        return result

    cache = []
    for i in range(len(s1)+1):
        cache.append([-1] * (len(s2)+1))

    return d(s1, s2)


def test_med(s1, s2, expected):
    success = 'PASSED' if (med(s1, s2) == expected) else 'FAILED'
    print success + ": med('" + s1 + "', '" + s2 + "')"


def run_tests():
    test_med("abc", "abc", 0)
    test_med("abc", "bcd", 2)
    test_med("abcdefg", "abcdefg", 0)
    test_med("abcdefg", "", 7)
    test_med("abcdefg", "ABCDEFG", 14)
    test_med("abcdefg", "abcdefgABCDEFG", 7)
    test_med("", "", 0)
    test_med("a", "A", 2)
    test_med("a", "ab", 1)
    test_med("abc", "c", 2)
