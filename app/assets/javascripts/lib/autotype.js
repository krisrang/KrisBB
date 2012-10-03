/* Largely based on bootstrap-typeahead.js. Same license applies */

!function($){
  "use strict";

  var Autotype = function (element, options) {
    this.$element = $(element)
    this.options = $.extend({}, $.fn.autotype.defaults, options)
    this.matcher = this.options.matcher || this.matcher
    this.sorter = this.options.sorter || this.sorter
    this.highlighter = this.options.highlighter || this.highlighter
    this.updater = this.options.updater || this.updater
    this.$menu = $(this.options.menu).appendTo('body')
    this.source = this.options.source
    this.shown = false
    this.query = ""
    this.startPosition = null
    this.listen()
  }

  Autotype.prototype = {

    constructor: Autotype

  , select: function () {
      var val = this.$menu.find('.active').attr('data-value')
      this.$element.insertAtCaret(this.updater(val)).change();
      return this.hide()
    }

  , updater: function (item) {
      return item.replace(this.query, "")
    }

  , show: function () {
      var pos = $.extend({}, this.$element.offset(), {
        height: this.$element[0].offsetHeight
      })

      this.$menu.css({
        bottom: pos.height
      , left: pos.left
      })

      this.$menu.show()
      this.shown = true
      return this
    }

  , hide: function () {
      this.$menu.hide()
      this.shown = false
      this.query = ""
      this.startPosition = null
      return this
    }

  , backspace: function (event) {
      this.query = this.query.slice(0,-1)
      var val = this.$element.val()
      var test = val.slice(this.startPosition, this.startPosition+this.query.length)

      if (this.query != test) {
        this.hide()
      }

      this.lookup(event)
    }

  , lookup: function (event, force) {
      var items

      if (event && !~$.inArray(event.keyCode, [37,39,40,38,9,13,27])) {
        var char = String.fromCharCode(event.which)

        if (event.keyCode != 8) {
          if (this.shown) {
            this.query += char
          } else {
            this.query = char
            this.startPosition = this.$element.getCaretPosition()
          }
        }

        if (!this.query || this.query.length < this.options.minLength) {
          return this.shown ? this.hide() : this
        }

        items = $.isFunction(this.source) ? this.source(this.query, $.proxy(this.process, this)) : this.source
        
        return items ? this.process(items) : this
      }
    }

  , process: function (items) {
      var that = this

      items = $.grep(items, function (item) {
        return that.matcher(item)
      })

      items = this.sorter(items)

      if (!items.length) {
        return this.shown ? this.hide() : this
      }

      return this.render(items.slice(0, this.options.items)).show()
    }

  , matcher: function (item) {
      if (this.shown) {
        return ~item.indexOf(this.query)
        // return ~item.toLowerCase().indexOf(this.query.toLowerCase())
      } else {
        return item[0] == this.query[0]
      }
    }

  , sorter: function (items) {
      var beginswith = []
        , caseSensitive = []
        , caseInsensitive = []
        , item

      while (item = items.shift()) {
        if (!item.toLowerCase().indexOf(this.query.toLowerCase())) beginswith.push(item)
        else if (~item.indexOf(this.query)) caseSensitive.push(item)
        else caseInsensitive.push(item)
      }

      return beginswith.concat(caseSensitive, caseInsensitive)
    }

  , highlighter: function (item) {
      var query = this.query.replace(/[\-\[\]{}()*+?.,\\\^$|#\s]/g, '\\$&')
      return item.replace(new RegExp('(' + query + ')', 'ig'), function ($1, match) {
        return '<strong>' + match + '</strong>'
      })
    }

  , render: function (items) {
      var that = this

      items = $(items).map(function (i, item) {
        i = $(that.options.item).attr('data-value', item)
        i.find('a').html(that.highlighter(item))
        return i[0]
      })

      items.first().addClass('active')
      this.$menu.html(items)
      return this
    }

  , next: function (event) {
      var active = this.$menu.find('.active').removeClass('active')
        , next = active.next()
      
      if (!next.length) {
        next = $(this.$menu.find('li')[0])
      }

      next.addClass('active')
    }

  , prev: function (event) {
      var active = this.$menu.find('.active').removeClass('active')
        , prev = active.prev()

      if (!prev.length) {
        prev = this.$menu.find('li').last()
      }

      prev.addClass('active')
    }

  , listen: function () {
      this.$element
        .on('blur',     $.proxy(this.blur, this))
        .on('keypress', $.proxy(this.keypress, this))
        .on('keyup',    $.proxy(this.keyup, this))

      if ($.browser.chrome || $.browser.webkit || $.browser.msie) {
        this.$element.on('keydown', $.proxy(this.keydown, this))
      }

      this.$menu
        .on('click', $.proxy(this.click, this))
        .on('mouseenter', 'li', $.proxy(this.mouseenter, this))
    }

  , move: function (e) {
      if (!this.shown) return

      switch(e.keyCode) {
        case 9: // tab
        case 13: // enter
        case 27: // escape
          e.preventDefault()
          break

        case 38: // up arrow
          e.preventDefault()
          this.prev()
          break

        case 40: // down arrow
          e.preventDefault()
          this.next()
          break
      }

      e.stopPropagation()
    }

  , keydown: function (e) {
      this.suppressKeyPressRepeat = !~$.inArray(e.keyCode, [40,38,9,13,27])
      this.move(e)
    }

  , keypress: function (e) {
      this.lookup(e)
      if (this.suppressKeyPressRepeat) return
      this.move(e)
    }

  , keyup: function (e) {
      switch(e.keyCode) {
        case 40: // down arrow
        case 38: // up arrow
          break

        case 9: // tab
        case 13: // enter
          if (!this.shown) return
          this.select()
          break

        case 27: // escape
          if (!this.shown) return
          this.hide()
          break

        case 8: // backspace
          this.backspace(e)
          break
        default:
          this.lookup()
      }

      e.stopPropagation()
      e.preventDefault()
  }

  , blur: function (e) {
      var that = this
      setTimeout(function () { that.hide() }, 150)
    }

  , click: function (e) {
      e.stopPropagation()
      e.preventDefault()
      this.select()
    }

  , mouseenter: function (e) {
      this.$menu.find('.active').removeClass('active')
      $(e.currentTarget).addClass('active')
    }

  }

  $.fn.autotype = function (option) {
    return this.each(function () {
      var $this = $(this)
        , data = $this.data('autotype')
        , options = typeof option == 'object' && option
      if (!data) $this.data('autotype', (data = new Autotype(this, options)))
      if (typeof option == 'string') data[option]()
    })
  }

  $.fn.autotype.defaults = {
    source: []
  , items: 8
  , menu: '<ul class="autotype dropdown-menu"></ul>'
  , item: '<li><a href="#"></a></li>'
  , minLength: 1
  }

  $.fn.autotype.Constructor = Autotype

  // $(function () {
  //   $('body').on('focus.autotype.data-api', '[data-provide="autotype"]', function (e) {
  //     var $this = $(this)
  //     if ($this.data('autotype')) return
  //     e.preventDefault()
  //     $this.autotype($this.data())
  //   })
  // })

}(window.jQuery);
