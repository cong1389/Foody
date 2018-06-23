Type.registerNamespace('AjaxDataControls');

// Create an alias for the namespace which will reduce the whole script size.
//Since this is the base file which required by the other
//controls it is the best place to do the aliasing.

var $ADC = AjaxDataControls;

$ADC.FontInfo = function(family, size, weight, style, textDecoration)
{
    /// <summary>
    /// Represents a Server Side FontInfo object.
    /// </summary>
    /// <param name="family" type="String">
    /// The font names.
    /// </param>
    /// <param name="size" type="String">
    /// The font size.
    /// </param>
    /// <param name="weight" type="String">
    /// The font weight.
    /// </param>
    /// <param name="style" type="String">
    /// The font style.
    /// </param>
    /// <param name="textDecoration" type="String">
    /// The text decoration.
    /// </param>

    if (arguments.length !== 5) throw Error.parameterCount();

    this._family = family;
    this._size = size;
    this._weight = weight;
    this._style = style;
    this._textDecoration = textDecoration;
}

$ADC.FontInfo.prototype =
{
    get_family : function()
    {
        /// <value type="String">
        /// The font names.
        /// </value>

        if (arguments.length !== 0) throw Error.parameterCount();

        return this._family;
    },

    set_family : function(value)
    {
        var e = Function._validateParams(arguments, [{name: 'value', type: String}]);
        if (e) throw e;

        if (this._family != value)
        {
            this._family = value;
        }
    },

    get_size : function()
    {
        /// <value type="String">
        /// The font size.
        /// </value>

        if (arguments.length !== 0) throw Error.parameterCount();

        return this._size;
    },

    set_size : function(value)
    {
        var e = Function._validateParams(arguments, [{name: 'value', type: String}]);
        if (e) throw e;

        if (this._size != value)
        {
            this._size = value;
        }
    },

    get_weight : function()
    {
        /// <value type="String">
        /// The font weight.
        /// </value>

        if (arguments.length !== 0) throw Error.parameterCount();

        return this._weight;
    },

    set_weight : function(value)
    {
        var e = Function._validateParams(arguments, [{name: 'value', type: String}]);
        if (e) throw e;

        if (this._weight != value)
        {
            this._weight = value;
        }
    },

    get_style : function()
    {
        /// <value type="String">
        /// The font style.
        /// </value>

        if (arguments.length !== 0) throw Error.parameterCount();

        return this._style;
    },

    set_style : function(value)
    {
        var e = Function._validateParams(arguments, [{name: 'value', type: String}]);
        if (e) throw e;

        if (this._style != value)
        {
            this._style = value;
        }
    },

    get_textDecoration : function()
    {
        /// <value type="String">
        /// The font text decoration.
        /// </value>

        if (arguments.length !== 0) throw Error.parameterCount();

        return this._textDecoration;
    },

    set_textDecoration : function(value)
    {
        var e = Function._validateParams(arguments, [{name: 'value', type: String}]);
        if (e) throw e;

        if (this._textDecoration != value)
        {
            this._textDecoration = value;
        }
    }
}

$ADC.FontInfo.registerClass('AjaxDataControls.FontInfo');


$ADC.Style = function(backColor, borderColor, borderStyle, borderWidth, cssClass, font, foreColor, height, width)
{
    /// <summary>
    /// Represents a Server Side Style object.
    /// </summary>
    /// <param name="backColor" type="String">
    /// The back color.
    /// </param>
    /// <param name="borderColor" type="String">
    /// The border color.
    /// </param>
    /// <param name="borderStyle" type="String">
    /// The border style.
    /// </param>
    /// <param name="borderWidth" type="String">
    /// The border width.
    /// </param>
    /// <param name="cssClass" type="String">
    /// The Css class name.
    /// </param>
    /// <param name="font" type="AjaxDataControls.FontInfo" mayBeNull="true">
    /// The associated font info
    /// </param>
    /// <param name="foreColor" type="String">
    /// The fore color.
    /// </param>
    /// <param name="height" type="String">
    /// The height.
    /// </param>
    /// <param name="width" type="String">
    /// The width.
    /// </param>
    if (arguments.length !== 9) throw Error.parameterCount();

    this._backColor = backColor;
    this._borderColor = borderColor;
    this._borderStyle = borderStyle;
    this._borderWidth = borderWidth;
    this._cssClass = cssClass
    this._font = font;
    this._foreColor  = foreColor;
    this._height = height;
    this._width = width;
}

$ADC.Style.prototype =
{
    get_backColor : function()
    {
        /// <value type="String">
        /// The back color.
        /// </value>

        if (arguments.length !== 0) throw Error.parameterCount();

        return this._backColor;
    },

    set_backColor : function(value)
    {
        var e = Function._validateParams(arguments, [{name: 'value', type: String}]);
        if (e) throw e;

        if (this._backColor != value)
        {
            this._backColor = value;
        }
    },

    get_borderColor : function()
    {
        /// <value type="String">
        /// The border color.
        /// </value>

        if (arguments.length !== 0) throw Error.parameterCount();

        return this._borderColor;
    },

    set_borderColor : function(value)
    {
        var e = Function._validateParams(arguments, [{name: 'value', type: String}]);
        if (e) throw e;

        if (this._borderColor != value)
        {
            this._borderColor = value;
        }
    },

    get_borderStyle : function()
    {
        /// <value type="String">
        /// The border style.
        /// </value>

        if (arguments.length !== 0) throw Error.parameterCount();

        return this._borderStyle;
    },

    set_borderStyle : function(value)
    {
        var e = Function._validateParams(arguments, [{name: 'value', type: String}]);
        if (e) throw e;

        if (this._borderStyle != value)
        {
            this._borderStyle = value;
        }
    },

    get_borderWidth : function()
    {
        /// <value type="String">
        /// The border width.
        /// </value>

        if (arguments.length !== 0) throw Error.parameterCount();

        return this._borderStyle;
    },

    set_borderWidth : function(value)
    {
        var e = Function._validateParams(arguments, [{name: 'value', type: String}]);
        if (e) throw e;

        if (this._borderWidth != value)
        {
            this._borderWidth = value;
        }
    },

    get_cssClass : function()
    {
        /// <value type="String">
        /// The css class name.
        /// </value>

        if (arguments.length !== 0) throw Error.parameterCount();

        return this._cssClass;
    },

    set_cssClass : function(value)
    {
        var e = Function._validateParams(arguments, [{name: 'value', type: String}]);
        if (e) throw e;

        if (this._cssClass != value)
        {
            this._cssClass = value;
        }
    },

    get_font : function()
    {
        /// <value type="AjaxDataControls.FontInfo" mayBeNull="true">
        /// The associated font object.
        /// </value>

        if (arguments.length !== 0) throw Error.parameterCount();

        return this._font;
    },

    set_font : function(value)
    {
        var e = Function._validateParams(arguments, [{name: 'value', type: AjaxDataControls.FontInfo}]);
        if (e) throw e;

        if (this._font != value)
        {
            this._font = value;
        }
    },

    get_foreColor : function()
    {
        /// <value type="String">
        /// The fore color.
        /// </value>

        if (arguments.length !== 0) throw Error.parameterCount();

        return this._foreColor;
    },

    set_foreColor : function(value)
    {
        var e = Function._validateParams(arguments, [{name: 'value', type: String}]);
        if (e) throw e;

        if (this._foreColor != value)
        {
            this._foreColor = value;
        }
    },

    get_height : function()
    {
        /// <value type="String">
        /// The height.
        /// </value>

        if (arguments.length !== 0) throw Error.parameterCount();

        return this._height;
    },

    set_height : function(value)
    {
        var e = Function._validateParams(arguments, [{name: 'value', type: String}]);
        if (e) throw e;

        if (this._height != value)
        {
            this._height = value;
        }
    },

    get_width : function()
    {
        /// <value type="String">
        /// The width.
        /// </value>

        if (arguments.length !== 0) throw Error.parameterCount();

        return this._width;
    },

    set_width : function(value)
    {
        var e = Function._validateParams(arguments, [{name: 'value', type: String}]);
        if (e) throw e;

        if (this._width != value)
        {
            this._width = value;
        }
    },

    apply : function(element)
    {
        /// <summary>
        /// Applies the Style on the specified DOM element.
        /// </summary>
        /// <param name="element" domElement="true">
        /// The DOM object where the style will be applied.
        /// </param>

        var e = Function._validateParams(arguments, [{name: 'element', type: Object}]);
        if (e) throw e;

        if (!$ADC.Util.isEmptyString(this.get_backColor()))
        {
            element.style.backColor = this.get_backColor();
        }

        if (!$ADC.Util.isEmptyString(this.get_borderColor()))
        {
            element.style.borderColor = this.get_borderColor();
        }

        if (!$ADC.Util.isEmptyString(this.get_borderStyle()))
        {
            element.style.borderStyle = this.get_borderStyle();
        }

        if (!$ADC.Util.isEmptyString(this.get_borderWidth()))
        {
            element.style.borderWidth = this.get_borderWidth();
        }

        if (!$ADC.Util.isEmptyString(this.get_cssClass()))
        {
            element.className = this.get_cssClass();
        }

        var font = this.get_font();

        if (font != null)
        {
            if (!$ADC.Util.isEmptyString(font.get_family()))
            {
                element.style.fontFamily = font.get_family();
            }

            if (!$ADC.Util.isEmptyString(font.get_size()))
            {
                element.style.fontSize = font.get_size();
            }

            if (!$ADC.Util.isEmptyString(font.get_weight()))
            {
                element.style.fontWeight = font.get_weight();
            }

            if (!$ADC.Util.isEmptyString(font.get_style()))
            {
                element.style.fontStyle = font.get_style();
            }

            if (!$ADC.Util.isEmptyString(font.get_textDecoration()))
            {
                element.style.textDecoration = font.get_textDecoration();
            }
        }

        if (!$ADC.Util.isEmptyString(this.get_foreColor()))
        {
            element.style.color = this.get_foreColor();
        }

        if (!$ADC.Util.isEmptyString(this.get_height()))
        {
            element.style.height = this.get_height();
        }

        if (!$ADC.Util.isEmptyString(this.get_width()))
        {
            element.style.width = this.get_width();
        }
    }
}

$ADC.Style.registerClass('AjaxDataControls.Style');


$ADC.Style.getStyleValue = function(element, attribute, defaultValue)
{
    /// <summary>
    /// This method is used to compute the value of a style attribute on an
    /// element that is currently being displayed.  This is especially useful for scenarios where
    /// several CSS classes and style attributes are merged, or when you need information about the
    /// size of an element (such as its padding or margins) that is not exposed in any other fashion.
    /// </summary>
    /// <param name="element" domElement="true">
    /// Live DOM element to check style of
    /// </param>
    /// <param name="attribute" type="String">
    /// The style attribute's name is expected to be in a camel-cased form that you would use when
    /// accessing a JavaScript property instead of the hyphenated form you would use in a CSS
    /// stylesheet (i.e. it should be "backgroundColor" and not "background-color").
    /// </param>
    /// <param name="defaultValue" type="Object" mayBeNull="true" optional="true">
    /// In the event of a problem (i.e. a null element or an attribute that cannot be found) we
    /// return this object (or null if none if not specified).
    /// </param>
    /// <returns type="Object">
    /// Current style of the element's attribute
    /// </returns>

    var currentValue = null;

    if (element)
    {
        if (element.currentStyle)
        {
            currentValue = element.currentStyle[attribute];
        }
        else if (document.defaultView && document.defaultView.getComputedStyle)
        {
            var style = document.defaultView.getComputedStyle(element, null);

            if (style)
            {
                currentValue = style[attribute];
            }
        }
        
        if (!currentValue && element.style.getPropertyValue)
        {
            currentValue = element.style.getPropertyValue(attribute);
        }
        else if (!currentValue && element.style.getAttribute)
        {
            currentValue = element.style.getAttribute(attribute);
        }
    }

    if ((!currentValue || currentValue == '' || typeof(currentValue) === 'undefined'))
    {
        if (typeof(defaultValue) != 'undefined')
        {
            currentValue = defaultValue;
        }
        else
        {
            currentValue = null;
        }
    }

    return currentValue;
}

$ADC.Style.getInheritedBackgroundColor = function(element)
{
    /// <summary>
    /// This method provides the ability to get the displayed
    /// background-color of an element.  In most cases calling getCurrentStyle
    /// won't do the job because it will return "transparent" unless the element has been given a
    /// specific background color.  This function will walk up the element's parents until it finds
    /// a non-transparent color.  If we get all the way to the top of the document or have any other
    /// problem finding a color, we will return the default value '#FFFFFF'.  This function is
    /// especially important when we're using opacity in IE (because ClearType will make text look
    /// horrendous if you fade it with a transparent background color).
    /// </summary>
    /// <param name="element" domElement="true">
    /// Live DOM element to get the background color of
    /// </param>
    /// <returns type="String">
    /// Background color of the element
    /// </returns>

    var defaultColor = '#FFFFFF';

    if (!element)
    {
        return defaultColor;
    }

    var background = $ADC.Style.getStyleValue(element, 'backgroundColor');

    try
    {
        while (!background || background == '' || background == 'transparent' || background == 'rgba(0, 0, 0, 0)')
        {
            element = element.parentNode;

            if (!element)
            {
                background = defaultColor;
            }
            else
            {
                background = $ADC.Style.getStyleValue(element, 'backgroundColor');
            }
        }
    }
    catch(ex)
    {
        background = defaultColor;
    }

    return background;
}


$ADC.TableItemStyle = function(backColor, borderColor, borderStyle, borderWidth, cssClass, font, foreColor, height, width, horizontalAlign, verticalAlign, wrap)
{
    /// <summary>
    /// Represents a Server Side TableItemStyle object.
    /// </summary>
    /// <param name="backColor" type="String">
    /// The back color.
    /// </param>
    /// <param name="borderColor" type="String">
    /// The border color.
    /// </param>
    /// <param name="borderStyle" type="String">
    /// The border style.
    /// </param>
    /// <param name="borderWidth" type="String">
    /// The border width.
    /// </param>
    /// <param name="cssClass" type="String">
    /// The Css class name.
    /// </param>
    /// <param name="font" type="AjaxDataControls.FontInfo" mayBeNull="true">
    /// The associated font info.
    /// </param>
    /// <param name="foreColor" type="String">
    /// The fore color.
    /// </param>
    /// <param name="height" type="String">
    /// The height.
    /// </param>
    /// <param name="width" type="String">
    /// The width.
    /// </param>
    /// <param name="horizontalAlign" type="String">
    /// The horizontal alignment.
    /// </param>
    /// <param name="verticalAlign" type="String">
    /// The vertical alignment.
    /// </param>
    /// <param name="wrap" type="Boolean">
    /// The word wrap.
    /// </param>

    if (arguments.length !== 12) throw Error.parameterCount();

    $ADC.TableItemStyle.initializeBase(this,[backColor, borderColor, borderStyle, borderWidth, cssClass, font, foreColor, height, width]);

    this._horizontalAlign = horizontalAlign;
    this._verticalAlign = verticalAlign;
    this._wrap = wrap;
}

$ADC.TableItemStyle.prototype =
{
    get_horizontalAlign : function()
    {
        /// <value type="String">
        /// The horizontal alignment.
        /// </value>

        if (arguments.length !== 0) throw Error.parameterCount();

        return this._horizontalAlign;
    },

    set_horizontalAlign : function(value)
    {
        var e = Function._validateParams(arguments, [{name: 'value', type: String}]);
        if (e) throw e;

        if (this._horizontalAlign != value)
        {
            this._horizontalAlign = value;
        }
    },

    get_verticalAlign : function()
    {
        /// <value type="String">
        /// The vertical alignment.
        /// </value>

        if (arguments.length !== 0) throw Error.parameterCount();

        return this._verticalAlign;
    },

    set_verticalAlign : function(value)
    {
        var e = Function._validateParams(arguments, [{name: 'value', type: String}]);
        if (e) throw e;

        if (this._verticalAlign != value)
        {
            this._verticalAlign = value;
        }
    },

    get_wrap : function()
    {
        /// <value type="Boolean">
        /// The word wrap.
        /// </value>

        if (arguments.length !== 0) throw Error.parameterCount();

        return this._wrap;
    },

    set_wrap : function(value)
    {
        var e = Function._validateParams(arguments, [{name: 'value', type: Boolean}]);
        if (e) throw e;

        if (this._wrap != value)
        {
            this._wrap = value;
        }
    },

    apply : function(element)
    {
        /// <summary>
        /// Applies the Style on the specified DOM element.
        /// </summary>
        /// <param name="element" domElement="true">
        /// The DOM object where the style will be applied.
        /// </param>

        var e = Function._validateParams(arguments, [{name: 'element', type: Object}]);
        if (e) throw e;

        AjaxDataControls.TableItemStyle.callBaseMethod(this, 'apply', [element]);

        if (!$ADC.Util.isEmptyString(this.get_horizontalAlign()))
        {
            element.style.textAlign = this.get_horizontalAlign();
        }

        if (!$ADC.Util.isEmptyString(this.get_verticalAlign()))
        {
            element.style.verticalAlign = this.get_verticalAlign();
        }

        if (this.get_wrap() == false)
        {
            element.style.whiteSpace = 'nowrap';
        }
    }
}

$ADC.TableItemStyle.registerClass('AjaxDataControls.TableItemStyle', AjaxDataControls.Style);


$ADC.Util = function()
{
    /// <summary>
    /// Utility class.
    /// </summary>
}

$ADC.Util.isEmptyString = function(s)
{
    /// <summary>
    /// Checks if the specified string is null, empty or undefined.
    /// </summary>
    /// <param name="s" type="String">
    /// The target string.
    /// </param>
    /// <returns type="Boolean">
    /// Returns true if the string is null, empty or undefined; otherwise false.
    /// </returns>

    if (typeof s != 'string')
    {
        return true;
    }

    return ((s == null) || (s.trim().length < 1));
}

$ADC.Util.clearContent = function(e)
{
    /// <summary>
    /// Clear its content.
    /// </summary>
    /// <param name="e" domElement="true">
    /// The target dom element.
    /// </param>

    if (e.firstChild)
    {
        while(e.firstChild)
        {
            e.removeChild(e.firstChild);
        }
    }
}

$ADC.Util.setText = function(e, t)
{
    /// <summary>
    /// Cross browser version of setting text.
    /// </summary>
    /// <param name="e" domElement="true">
    /// The target dom element.
    /// </param>
    /// <param name="t" type="String">
    /// The text which will be set.
    /// </param>

    if (typeof e.textContent != 'undefined')
    {
        e.textContent = t;
    }
    else if (typeof e.innerText != 'undefined')
    {
        e.innerText = t;
    }
}

$ADC.Util.hasDragNDropSupport = function()
{
    /// <summary>
    /// Checks if the required Drag and Drop scripts of Ajax Framework exists in the page.
    /// </summary>
    /// <returns type="Boolean">
    /// Returns true if the required AJAX Framework script exisits; otherwise false.
    /// </returns>

    var hasSupport =    (
                            (typeof(Sys.Preview) != 'undefined') &&
                            (typeof(Sys.Preview.UI) != 'undefined') &&
                            (typeof(Sys.Preview.UI.DragDropManager) != 'undefined')
                        );
    return hasSupport;
}

$ADC.Util.hasAnimationSupport = function()
{
    /// <summary>
    /// Checks if the required Animation scripts of Ajax Framework exists in the page.
    /// </summary>
    /// <returns type="Boolean">
    /// Returns true if the required AJAX Framework script exisits; otherwise false.
    /// </returns>

    var hasSupport =    (
                            (typeof(Sys.Preview) != 'undefined') &&
                            (typeof(Sys.Preview.UI) != 'undefined') &&
                            (typeof(Sys.Preview.UI.Effects) != 'undefined') &&
                            (typeof(Sys.Preview.UI.Effects.FadeAnimation) != 'undefined')
                        );
    return hasSupport;
}

$ADC.Util.createDataBindAnimation = function(duration, fps, target)
{
    return $create(Sys.Preview.UI.Effects.FadeAnimation, {'duration': duration, 'fps': fps, 'effect': Sys.Preview.UI.Effects.FadeEffect.FadeIn, 'target': target});
}

$ADC.Util.registerClass('AjaxDataControls.Util');

if (typeof(Sys) != 'undefined')
{
    Sys.Application.notifyScriptLoaded();
}