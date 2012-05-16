"""
estimate_pi.py: Estimate the value of pi using Monte Carlo.

Inspired by a blog post at http://rebrained.com/.

:author: Robert David Grant <robert.david.grant@gmail.com>

:copyright: 
    Copyright 2012 Robert David Grant

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
from numpy import array
from numpy.random import random_sample


def estimate_pi(r=10.0, n=1e6):
    """
    Compute the value of pi with Monte Carlo.

    Say you have a square with sides of length (2*r).  The area of this
    square is then (2*r)**2, and the area of a circle embedded in it
    with radius r is then pi*r**2.  Then, choosing a point randomly in
    the square has a probability of

        area_of_circle / area_of_square  = pi*r**2 / 4*r**2
            = pi / 4

    of landing in the circle.

    Thus, sampling n points uniformly in the square and determining how
    many are also in the circle centered in the square will converge to
    pi/4 for large n.

    This probability is the same if only a quarter circle is considered.
    """
    coords = array([random_sample(n), random_sample(n)]).T
    distances = (coords[:,0]**2 + coords[:,1]**2)**0.5
    return (distances < 1).mean() * 4
