/**
 * jQuery.contextMenu - Show a custom context when right clicking something
 * Jonas Arnklint, http://github.com/arnklint/jquery-contextMenu
 * Released into the public domain
 * Date: Jan 14, 2011
 * @author Jonas Arnklint
 * @version 1.7
 *
 * License
 *
 * Copyright (c) 2010 Jonas Arnklint, released under the MIT license.
 * 
 * Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
 * 
 * The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
 * 
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 * 
 * 
 *
*/
// Making a local '$' alias of jQuery to support jQuery.noConflict
(function($) {
  jQuery.fn.contextMenu = function ( name, actions, options ) {
    var me = this,
    win = $(window),
    menu = $('<ul id="'+name+'" class="context-menu"></ul>').hide().appendTo('body'),
    activeElement = null, // last clicked element that responds with contextMenu
    hideMenu = function() {
      $('.context-menu:visible').each(function() {
        $(this).trigger("closed");
        $(this).hide();
        $('body').unbind('click', hideMenu);
        menu.unbind('closed');
      });
    },
    default_options = {
      disable_native_context_menu: false, // disables the native contextmenu everywhere you click
      leftClick: false // show menu on left mouse click instead of right
    },
    options = $.extend(default_options, options);

    $(document).bind('contextmenu', function(e) {
      if (options.disable_native_context_menu) {
        e.preventDefault();
      }
      hideMenu();
    });

    $.each(actions, function(me, itemOptions) {
      if (itemOptions.link) {
        var link = itemOptions.link;
      } else {
        var link = '<a href="#">'+me+'</a>';
      }

      var menuItem = $('<li>' + link + '</li>');

      if (itemOptions.klass) {
        menuItem.attr("class", itemOptions.klass);
      }

      menuItem.appendTo(menu).bind('click', function(e) {
        itemOptions.click(activeElement);
        e.preventDefault();
      });
    });

    if (options.leftClick) {
      var mouseEvent = 'click';
    } else {
      var mouseEvent = 'contextmenu';
    }

    var mouseEventFunc = function(e){
      // Hide any existing context menus
      hideMenu();

      activeElement = $(this); // set clicked element

      if (options.showMenu) {
        options.showMenu.call(menu, activeElement);
      }

      // Bind to the closed event if there is a hideMenu handler specified
      if (options.hideMenu) {
        menu.bind("closed", function() {
          options.hideMenu.call(menu, activeElement);
        });
      }

      menu.css({
        visibility: 'hidden',
        position: 'absolute',
        zIndex: 1000
      });

      // include margin so it can be used to offset from page border.
      var mWidth = menu.outerWidth(true),
        mHeight = menu.outerHeight(true),
        xPos = ((e.pageX - win.scrollLeft()) + mWidth < win.width()) ? e.pageX : e.pageX - mWidth,
        yPos = ((e.pageY - win.scrollTop()) + mHeight < win.height()) ? e.pageY : e.pageY - mHeight;

      menu.show(0, function() {
        $('body').bind('click', hideMenu);
      }).css({
        visibility: 'visible',
        top: yPos + 'px',
        left: xPos + 'px',
        zIndex: 1000
      });

      return false;
    }

    if (options.delegateEventTo) {
      return me.on(mouseEvent, options.delegateEventTo, mouseEventFunc)
    } else {
      return me.bind(mouseEvent, mouseEventFunc);
    }
  }
})(jQuery);

