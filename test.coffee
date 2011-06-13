#!/usr/bin/env nodeunit

LRUCache = (require 'lru-cache').LRUCache

exports.test_one_entry = (t) ->
  c = new LRUCache 3
  t.ok not c.has 'a'
  c.put 'a', 1
  t.ok (c.has 'a'), 'key should be cached'
  t.equal (c.get 'a'), 1, 'value should be set'
  t.done()

exports.test_two_entries = (t) ->
  c = new LRUCache 3
  c.put 'a', 1
  c.put 'b', 2
  t.ok (c.has 'a'), 'first entry should be present'
  t.ok (c.has 'b'), 'second entry should be present'
  t.equal (c.get 'a'), 1, 'first entry value should not have changed'
  t.equal (c.get 'b'), 2, 'second entry value should not have changed'
  t.done()

exports.test_purge_with_limit_one = (t) ->
  c = new LRUCache 1
  c.put 'a', 1
  c.put 'b', 2
  t.ok (not c.has 'a'), 'first entry should have been purged'
  t.ok (c.has 'b'), 'second entry should be present'
  t.equal (c.get 'a'), undefined, 'first entry value should have been purged'
  t.equal (c.get 'b'), 2, 'second entry value should not have changed'
  t.done()

exports.test_purge_with_limit_two = (t) ->
  c = new LRUCache 2
  c.put 'a', 1
  c.put 'b', 2
  c.put 'c', 3
  t.ok (not c.has 'a'), 'first entry should have been purged'
  t.ok (c.has 'b'), 'second entry should be present'
  t.ok (c.has 'c'), 'third entry should be present'
  t.equal (c.get 'a'), undefined, 'first entry value should have been purged'
  t.equal (c.get 'b'), 2, 'second entry value should not have changed'
  t.equal (c.get 'c'), 3, 'third entry value should have been set'
  t.done()

exports.test_remove_with_one_entry = (t) ->
  c = new LRUCache 2
  c.put 'a', 1
  c.remove 'a'
  t.ok (not c.has 'a'), 'first entry should have been removed'
  t.equal (c.get 'a'), undefined, 'first entry value should have been removed'
  t.done()

exports.test_remove_first_of_two_entries = (t) ->
  c = new LRUCache 2
  c.put 'a', 1
  c.put 'b', 2
  c.remove 'a'
  t.ok (not c.has 'a'), 'first entry should have been removed'
  t.equal (c.get 'a'), undefined, 'first entry value should have been removed'
  t.ok (c.has 'b'), 'second entry should be present'
  t.equal (c.get 'b'), 2, 'second entry value should have been set'
  t.done()

exports.test_remove_second_of_two_entries = (t) ->
  c = new LRUCache 2
  c.put 'a', 1
  c.put 'b', 2
  c.remove 'b'
  t.ok (not c.has 'b'), 'second entry should have been removed'
  t.equal (c.get 'b'), undefined, 'second entry value should have been removed'
  t.ok (c.has 'a'), 'first entry should be present'
  t.equal (c.get 'a'), 1, 'first entry value should have been set'
  t.done()

exports.test_remove_second_of_three_entries = (t) ->
  c = new LRUCache 3
  c.put 'a', 1
  c.put 'b', 2
  c.put 'c', 3
  c.remove 'b'
  t.ok (not c.has 'b'), 'second entry should have been removed'
  t.equal (c.get 'b'), undefined, 'second entry value should have been removed'
  t.ok (c.has 'a'), 'first entry should be present'
  t.equal (c.get 'a'), 1, 'first entry value should have been set'
  t.ok (c.has 'c'), 'third entry should be present'
  t.equal (c.get 'c'), 3, 'third entry value should have been set'
  t.done()

exports.test_remove_nonexistent_key = (t) ->
  c = new LRUCache 3
  c.put 'a', 1
  c.put 'b', 2
  t.doesNotThrow -> c.remove 'c'
  t.ok (c.has 'a'), 'first entry should be present'
  t.equal (c.get 'a'), 1, 'first entry value should have been set'
  t.ok (c.has 'b'), 'second entry should be present'
  t.equal (c.get 'b'), 2, 'second entry value should have been set'
  t.done()

exports.test_dump_format = (t) ->
  c = new LRUCache 3
  c.put 'a', 1
  c.put 'b', 2
  c.put 'c', 3
  t.equal c.dump(), '[ a b c ]'
  t.done()
