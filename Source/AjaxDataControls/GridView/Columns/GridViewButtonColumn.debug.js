Type.registerNamespace('AjaxDataControls');

$ADC.GridViewButtonColumn = function()
{
    /// <summary>
    /// Specifies the different types of buttons that can be rendered in a GridView control.
    /// </summary>
    
    this._buttonType = $ADC.GridViewColumnButtonType.Link;
    this._commandName = '';
    this._dataTextField = '';
    this._dataTextFormatString = '';
    this._imageUrl = '';
    this._text = '';

    this._buttons = new Array();
    this._clickHandlers = new Array();

    $ADC.GridViewButtonColumn.initializeBase(this);
    $ADC.GridViewButtonColumn.callBaseMethod(this, 'set_allowDragAndDrop', [false]);
}

$ADC.GridViewButtonColumn.prototype =
{
   get_buttonType : function()
    {
        /// <value type="AjaxDataControls.GridViewColumnButtonType">
        /// Use this property to specify which type of button is displayed in a GridViewCommandColumn.
        /// </value>
        if (arguments.length !== 0) throw Error.parameterCount();

        return this._buttonType;
    },

    set_buttonType : function(value)
    {
        var e = Function._validateParams(arguments, [{name: 'value', type: $ADC.GridViewColumnButtonType}]);
        if (e) throw e;

        if (this._buttonType != value)
        {
            this._buttonType = value;
            this.raisePropertyChanged('buttonType');
        }
    },

    get_commandName : function()
    {
        /// <value type="String">
        /// Use this property to specify the action to perform when a button in a GridViewButtonColumn object is clicked.
        /// </value>
        if (arguments.length !== 0) throw Error.parameterCount();

        return this._commandName;
    },

    set_commandName : function(value)
    {
        var e = Function._validateParams(arguments, [{name: 'value', type: String}]);
        if (e) throw e;

        if (this._commandName != value)
        {
            this._commandName = value;
            this.raisePropertyChanged('commandName');
        }
    },

    get_dataTextField : function()
    {
        /// <value type="String">
        /// Use this property to specify the name of the field to bind to the GridViewButtonColumn object. The values of the field are then displayed as the text for the buttons in the GridViewButtonColumn object. Optionally, you can format the displayed text by setting the DataTextFormatString property. Instead of using the DataTextField property to bind a GridViewButtonColumn object to a field from a data source, you can use the Text property to display static text for the text of the buttons in the GridViewButtonColumn object. When the Text property is used, each button shares the same caption.
        /// </value>
        if (arguments.length !== 0) throw Error.parameterCount();

        return this._dataTextField;
    },

    set_dataTextField : function(value)
    {
        var e = Function._validateParams(arguments, [{name: 'value', type: String}]);
        if (e) throw e;

        if (this._dataTextField != value)
        {
            this._dataTextField = value;
            this.raisePropertyChanged('dataTextField');
        }
    },

    get_dataTextFormatString : function()
    {
        /// <value type="String">
        /// Use this property to specify a custom display format for the values that are displayed in the GridViewButtonColumn object. If the <b>DataTextFormatString</b> property is not set, the value for the field is displayed without any special formatting.
        /// </value>
        if (arguments.length !== 0) throw Error.parameterCount();

        return this._dataTextFormatString;
    },

    set_dataTextFormatString : function(value)
    {
        var e = Function._validateParams(arguments, [{name: 'value', type: String}]);
        if (e) throw e;

        if (this._dataTextFormatString != value)
        {
            this._dataTextFormatString = value;
            this.raisePropertyChanged('dataTextFormatString');
        }
    },

    get_imageUrl : function()
    {
        /// <value type="String">
        /// Use this property to specify the image to display for each button. This image can be in any file format (.jpg, .gif, .bmp, and so on), as long as the client browser supports that format.
        /// </value>
        if (arguments.length !== 0) throw Error.parameterCount();

        return this._imageUrl;
    },

    set_imageUrl : function(value)
    {
        var e = Function._validateParams(arguments, [{name: 'value', type: String}]);
        if (e) throw e;

        if (this._imageUrl != value)
        {
            this._imageUrl = value;
            this.raisePropertyChanged('imageUrl');
        }
    },

    get_text : function()
    {
        /// <value type="String">
        /// Use this property to specify the static caption that is displayed for each button in the GridViewButtonColumn object.
        /// </value>
        if (arguments.length !== 0) throw Error.parameterCount();

        return this._text;
    },

    set_text : function(value)
    {
        var e = Function._validateParams(arguments, [{name: 'value', type: String}]);
        if (e) throw e;

        if (this._text != value)
        {
            this._text = value;
            this.raisePropertyChanged('text');
        }
    },

    initialize : function()
    {
        /// <summary>
        /// Initialize the column.
        /// </summary>
        $ADC.GridViewButtonColumn.callBaseMethod(this, 'initialize');
    },

    dispose : function()
    {
        /// <summary>
        /// Dispose the column.
        /// </summary>
        $ADC.GridViewButtonColumn.callBaseMethod(this, 'dispose');

        delete this._buttons;
        delete this._clickHandlers;
    },

    renderData : function(dataRow, row, container)
    {
        /// <summary>
        /// This method is used to render the data cell. You do not have to call this method in your code.
        /// </summary>
        /// <param name="dataRow" type="Object">
        /// The item of the GridView dataSource.
        /// </param>
        /// <param name="row" type="AjaxDataControls.GridViewRow">
        /// The GridViewRow which is passed to render the column data cell.
        /// </param>
        /// <param name="container" domElement="true">
        /// The container cell(td) to render the data of this column.
        /// </param>
        var e = Function._validateParams(arguments, [{name: 'dataRow', type: Object}, {name: 'row', type: $ADC.GridViewRow}, {name: 'container', type: Object}]);
        if (e) throw e;

        var value = null;
        var dataField = this.get_dataTextField();
        var dataFormatString = this.get_dataTextFormatString();

        if (!$ADC.Util.isEmptyString(dataField))
        {
            value = dataRow[dataField];
        }

        if (value == null)
        {
            var text = this.get_text();

            if (!$ADC.Util.isEmptyString(text))
            {
                value = text;
            }
            else
            {
                value = '';
            }
        }
        else
        {
            if (!$ADC.Util.isEmptyString(dataFormatString))
            {
                value = value.localeFormat(dataFormatString);
            }
        }

        var button;
        var buttonType = this.get_buttonType();

        if (buttonType == $ADC.GridViewColumnButtonType.Link)
        {
            button = document.createElement('a');
            button.appendChild(document.createTextNode(value));
            button.setAttribute('href', 'javascript:void(0)');
        }
        else if (buttonType == $ADC.GridViewColumnButtonType.Image)
        {
            button = document.createElement('img');
            button.setAttribute('alt', value);

            var imageUrl = this.get_imageUrl();

            if (!$ADC.Util.isEmptyString(imageUrl))
            {
                button.setAttribute('src', imageUrl);
            }

            button.style.cursor = 'pointer';
        }
        else
        {
            button = document.createElement('input');
            button.setAttribute('type', 'button');
            button.setAttribute('value', value);
        }

        var commandName = this.get_commandName();

        if (!$ADC.Util.isEmptyString(commandName))
        {
            button.commandName = commandName;
            button.commandArgument = row.get_rowIndex();
        }

        container.appendChild(button);
        var owner = this.get_owner();

        var clickHandler = Function.createCallback(owner._raiseCommand, {sender:owner, row:row});
        $addHandler(button, 'click', clickHandler);

        Array.add(this._buttons, button);
        Array.add(this._clickHandlers, clickHandler);

        if (this.get_controlStyle() != null)
        {
            this.get_controlStyle().apply(button);
        }

        if (this.get_itemStyle() != null)
        {
            this.get_itemStyle().apply(container);
        }
    },

    releaseResource : function()
    {
        /// <summary>
        /// Releases all resources which are associated with this column.
        /// </summary>
        $ADC.GridViewButtonColumn.callBaseMethod(this, 'releaseResource');

        if ((this._buttons.length > 0) && (this._clickHandlers.length > 0))
        {
            for(var i = this._buttons.length - 1; i > -1; i--)
            {
                $removeHandler(this._buttons[i], 'click', this._clickHandlers[i]);
                delete this._buttons[i];
                delete this._clickHandlers[i];
            }
        }

        Array.clear(this._buttons);
        Array.clear(this._clickHandlers);
    }
}

$ADC.GridViewButtonColumn.registerClass('AjaxDataControls.GridViewButtonColumn', $ADC.GridViewBaseColumn);

if (typeof(Sys) != 'undefined')
{
    Sys.Application.notifyScriptLoaded();
}