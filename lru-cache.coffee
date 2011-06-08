#!/usr/bin/env nodeunit

class LRUCache
  constructor: (@max_items = Infinity) ->
    [@items, @order] = [{}, []]

  set: (key, value) ->
    @remove key
    @items[key] = value
    @order.push key
    @remove @order.shift() if @order.length > @max_items
    @

  get: (key) ->
    value = @items[key]
    return null unless value?
    @set key, value

  remove: (key) ->
    delete @items[key]
    for item, index in @order when item is key
      @order.splice index, 1
      return true
    false

exports.LRUCache = LRUCache

exports.test_basics = (t) ->
  c = new LRUCache 3
  c.set('A', 1).set('B', 2).set('C', 3)

  t.deepEqual {A:1, B:2, C:3}, c.items
  t.deepEqual ['A', 'B', 'C'], c.order

  c.set 'D', 4
  t.deepEqual {B:2, C:3, D:4}, c.items
  t.deepEqual ['B', 'C', 'D'], c.order

  c.get 'B'
  t.deepEqual {B:2, C:3, D:4}, c.items
  t.deepEqual ['C', 'D', 'B'], c.order

  c.remove 'D'
  t.deepEqual {B:2, C:3}, c.items
  t.deepEqual ['C', 'B'], c.order

  t.done()

