# LRU Cache

A least-recently-used in-memory cache.

Adding more than a configurable maximum number of items to a LRUCache
object causes the least-recently-used item to be purged.

## Usage

    LRUCache = (require 'lru-cache').LRUCache
    max_item_count = 3
    c = new LRUCache max_item_count
    c.set 'A', 1
    c.set 'B', 2
    c.set 'C', 3
    c.set 'D', 4  # A purged; least to most used: BCD
    c.get 'B'     # least to most used: CDB
    c.set 'E', 5  # C purged; least to most used: DBE
    c.remove 'B'  # least to most used: D used now is E

## Tests

Run unit tests with: `nodeunit ./lru-cache.coffee`

## Notes

Operations set, get, and remove run in O(N).

## Author

Brian Hammond <brian@fictorial.com> (http://fictorial.com)

## License

Copyright (c) 2011 Fictorial LLC.

Permission is hereby granted, free of charge, to any person obtaining a copy of
this software and associated documentation files (the "Software"), to deal in
the Software without restriction, including without limitation the rights to
use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies
of the Software, and to permit persons to whom the Software is furnished to do
so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.

