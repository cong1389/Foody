Type.registerNamespace('AjaxDataControls');

$ADC.GridViewImageColumn = function()
{
    /// <summary>
    /// Represents a column that is displayed as an image in a GridView control.
    /// </summary>
    
    this._alternateText = '';
    this._dataAlternateTextField = '';
    this._dataImageUrlField = '';
    this._dataImageUrlFormatString = '';
    this._dataAlternateTextFormatString = '';
    this._nullDisplayText = '';
    this._nullImageUrl = '';

    $ADC.GridViewImageColumn.initializeBase(this);
}

$ADC.GridViewImageColumn.prototype =
{
    get_alternateText : function()
    {
        /// <value type="String">
        /// Use this property to specify the alternate text for the images displayed in an GridViewImageColumn object. The alternate text is displayed when an image cannot be loaded or is unavailable. Browsers that support the ToolTips feature also display this text as a ToolTip.
        /// </value>
        if (arguments.length !== 0) throw Error.parameterCount();

        return this._alternateText;
    },

    set_alternateText : function(value)
    {
        var e = Function._validateParams(arguments, [{name: 'value', type: String}]);
        if (e) throw e;

        if (this._alternateText != value)
        {
            this._alternateText = value;
            this.raisePropertyChanged('alternateText');
        }
    },

    get_dataAlternateTextField : function()
    {
        /// <value type="String">
        /// Use this property to specify the name of the field from the data source that contains the values to bind to the <b>AlternateText</b> property of each image in an GridViewImageColumn object. This enables you to have different alternate text for each image displayed. The alternate text is displayed when an image cannot be loaded or is unavailable. Browsers that support the ToolTips feature also display this text as a ToolTip.
        /// </value>
        if (arguments.length !== 0) throw Error.parameterCount();

        return this._dataAlternateTextField;
    },

    set_dataAlternateTextField : function(value)
    {
        var e = Function._validateParams(arguments, [{name: 'value', type: String}]);
        if (e) throw e;

        if (this._dataAlternateTextField != value)
        {
            this._dataAlternateTextField = value;
            this.raisePropertyChanged('dataAlternateTextField');
        }
    },

    get_dataAlternateTextFormatString : function()
    {
        /// <value type="String">
        /// Use this property to specify a custom format for the alternate text values of the images displayed in an GridViewImageColumn object.
        /// </value>
        if (arguments.length !== 0) throw Error.parameterCount();

        return this._dataAlternateTextFormatString;
    },

    set_dataAlternateTextFormatString : function(value)
    {
        var e = Function._validateParams(arguments, [{name: 'value', type: String}]);
        if (e) throw e;

        if (this._dataAlternateTextFormatString != value)
        {
            this._dataAlternateTextFormatString = value;
            this.raisePropertyChanged('dataAlternateTextFormatString');
        }
    },

    get_dataImageUrlField : function()
    {
        /// <value type="String">
        /// Use this property to specify the name of the field to bind to the <b>ImageUrl</b> property of each image in an GridViewImageColumn object. The specified field must contain the URLs for the images to display in the GridViewImageColumn object. You can optionally format the URL values by setting the DataImageUrlFormatString property.
        /// </value>
        if (arguments.length !== 0) throw Error.parameterCount();

        return this._dataImageUrlField;
    },

    set_dataImageUrlField : function(value)
    {
        var e = Function._validateParams(arguments, [{name: 'value', type: String}]);
        if (e) throw e;

        if (this._dataImageUrlField != value)
        {
            this._dataImageUrlField = value;
            this.raisePropertyChanged('dataImageUrlField');
        }
    },

    get_dataImageUrlFormatString : function()
    {
        /// <value type="String">
        /// Use this property to specify a custom format for the URLs of the images displayed in an GridViewImageColumn object. This is useful when you need to generate a URL, such as when the GridViewImageColumn object simply contains the file name. If the DataImageUrlFormatString property is not set, the URL values do not get any special formatting.
        /// </value>
        if (arguments.length !== 0) throw Error.parameterCount();

        return this._dataImageUrlFormatString;
    },

    set_dataImageUrlFormatString : function(value)
    {
        var e = Function._validateParams(arguments, [{name: 'value', type: String}]);
        if (e) throw e;

        if (this._dataImageUrlFormatString != value)
        {
            this._dataImageUrlFormatString = value;
            this.raisePropertyChanged('dataImageUrlFormatString');
        }
    },

    get_nullDisplayText : function()
    {
        /// <value type="String">
        /// Use this property to specify the text to display in the image's place. The text usually indicates that the normal image is not available or cannot be found.
        /// </value>
        if (arguments.length !== 0) throw Error.parameterCount();

        return this._nullDisplayText;
    },

    set_nullDisplayText : function(value)
    {
        var e = Function._validateParams(arguments, [{name: 'value', type: String}]);
        if (e) throw e;

        if (this._nullDisplayText != value)
        {
            this._nullDisplayText = value;
            this.raisePropertyChanged('nullDisplayText');
        }
    },

    get_nullImageUrl : function()
    {
        /// <value type="String">
        /// Use this property to specify the URL to an alternate image to display. The alternate image is usually an image that indicates that the normal image is not available or cannot be found.
        /// </value>
        if (arguments.length !== 0) throw Error.parameterCount();

        return this._nullImageUrl;
    },

    set_nullImageUrl : function(value)
    {
        var e = Function._validateParams(arguments, [{name: 'value', type: String}]);
        if (e) throw e;

        if (this._nullImageUrl != value)
        {
            this._nullImageUrl = value;
            this.raisePropertyChanged('nullImageUrl');
        }
    },

    initialize : function()
    {
        /// <summary>
        /// Initialize the column.
        /// </summary>        
        $ADC.GridViewImageColumn.callBaseMethod(this, 'initialize');
    },

    dispose : function()
    {
        /// <summary>
        /// Dispose the column.
        /// </summary>
        $ADC.GridViewImageColumn.callBaseMethod(this, 'dispose');
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
        var dataField = this.get_dataImageUrlField();

        if (!$ADC.Util.isEmptyString(dataField))
        {
            value = dataRow[dataField];
        }

        if (value != null)
        {
            var dataFormatString = this.get_dataImageUrlFormatString();

            if (!$ADC.Util.isEmptyString(dataFormatString))
            {
                value =  value.format(dataFormatString);
            }
        }
        else
        {
            var nullImageUrl = this.get_nullImageUrl;

            if (!$ADC.Util.isEmptyString(nullImageUrl))
            {
                value = nullImageUrl;
            }
        }

        if (value == null)
        {
            var nullDisplayText = get_nullDisplayText();

            if (!$ADC.Util.isEmptyString(nullDisplayText))
            {
                container.appendChild(document.createTextNode(nullDisplayText));
            }
        }
        else
        {
            var alt = null;
            var alternateTextField = this.get_dataAlternateTextField();

            if (!$ADC.Util.isEmptyString(alternateTextField))
            {
                alt = dataRow[alternateTextField];
            }

            if (alt != null)
            {
                var alternateTextFormatString = this.get_dataAlternateTextFormatString();

                if (!$ADC.Util.isEmptyString(alternateTextFormatString))
                {
                    alt =  alt.format(alternateTextFormatString);
                }
            }
            else
            {
                var alternateText = this.get_alternateText();

                if (!$ADC.Util.isEmptyString(alternateText))
                {
                    alt =  alternateText;
                }
            }

            if (value == null)
            {
                value = '';
            }

            if (alt == null)
            {
                alt = '';
            }

            var img = document.createElement('img');

            img.setAttribute('alt', alt);
            img.setAttribute('src', value);

            container.appendChild(img);

            if (this.get_controlStyle() != null)
            {
                this.get_controlStyle().apply(img);
            }
        }

        if (this.get_itemStyle() != null)
        {
            this.get_itemStyle().apply(container);
        }
    }
}

$ADC.GridViewImageColumn.registerClass('AjaxDataControls.GridViewImageColumn', $ADC.GridViewBaseColumn);

if (typeof(Sys) != 'undefined')
{
    Sys.Application.notifyScriptLoaded();
}