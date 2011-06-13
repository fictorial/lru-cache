# LRU Cache based on doubly-linked list.
# Head:Tail::Oldest:Newest

class Entry
  constructor: (@k, @v) ->
    @p = @n = undefined

class LRUCache
  constructor: (@limit = Infinity) ->
    @m = {}
    @h = @t = undefined
    @n = 0

  put: (k, v) ->
    e = new Entry k,v
    @m[k] = e
    if @t
      @t.n = e
      e.p = @t
    else
      @h = e
    @t = e
    @purge() if ++@n > @limit
    @

  purge: ->
    e = @h
    if e
      if @h.n?
        @h = @h.n
        @h.p = undefined
      else
        @h = undefined
      e.n = e.p = undefined
      delete @m[e.k]
    e

  get: (k) ->
    e = @m[k]
    return undefined unless e?
    return e.v if e is @t
    if e.n
      if e is @h
        @h = e.n
      e.n.p = e.p
    if e.p
      e.p.n = e.n
    e.n = undefined
    e.p = @t
    @t.n = e if @t
    @t = e
    e.v

  remove: (k) ->
    e = @m[k]
    return undefined unless e?
    delete @m[e.k]
    if e.n? and e.p? # middle
      e.p.n = e.n
      e.n.p = e.p
    else if e.n?     # head
      e.n.p = undefined
      @h = e.n
    else if e.p?     # tail
      e.p.n = undefined
      @t = e.p
    e.v

  has: (k) -> @m[k]?

  dump: ->
    s = '[ '
    n = @h
    while n?
      s += n.k + " "
      n = n.n
    s += ']'
    s

exports.LRUCache = LRUCache
