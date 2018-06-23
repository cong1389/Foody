Type.registerNamespace('AjaxDataControls');

$ADC.GridViewHyperLinkColumn = function()
{
    /// <summary>
    /// Represents a column that is displayed as a hyperlink in a GridView control.
    /// </summary>
    
    this._dataTextField = '';
    this._dataTextFormatString = '';
    this._dataNavigateUrlFields = '';
    this._dataNavigateUrlFormatString = '';
    this._target = '';
    this._navigateUrl = '';
    this._text = '';

    $ADC.GridViewHyperLinkColumn.initializeBase(this);
}

$ADC.GridViewHyperLinkColumn.prototype =
{
    get_dataTextField : function()
    {
        /// <value type="String">
        /// Use this property to specify the name of the field that contains the text to display for the hyperlink captions in the HyperLinkColumn object. Instead of using this property to bind the hyperlink captions to a field, you can use the <see cref="Text"/> property to set the hyperlink captions to a static value. With this option, each hyperlink shares the same caption.
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
        /// Use this property to specify a custom display format for the captions displayed in the HyperLinkColumn object. If the <b>DataTextFormatString</b> property is not set, the field's value is displayed without any special formatting.
        /// </value>
        if (arguments.length !== 0) throw Error.parameterCount();

        return this._dataFormatString;
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

    get_dataNavigateUrlFields : function()
    {
        /// <value type="String">
        /// Use this property when the data source contains multiple fields that must be combined to create the hyperlinks for the HyperLinkColum object. The fields specified in the <b>DataNavigateUrlFields</b> property are combined with the format string in the DataNavigateUrlFormatString property to construct the hyperlinks in the HyperLinkColum object. Instead of using this property to bind the URLs of the hyperlinks to a field, you can use the NavigateUrl property to set the hyperlinks' URL to a static value. With this option, each hyperlink shares the same URL.
        /// </value>
        if (arguments.length !== 0) throw Error.parameterCount();

        return this._dataNavigateUrlFields;
    },

    set_dataNavigateUrlFields : function(value)
    {
        var e = Function._validateParams(arguments, [{name: 'value', type: String}]);
        if (e) throw e;

        if (this._dataNavigateUrlFields != value)
        {
            this._dataNavigateUrlFields = value;
            this.raisePropertyChanged('dataNavigateUrlFields');
        }
    },

    get_dataNavigateUrlFormatString : function()
    {
        /// <value type="String">
        /// Use this property to specify the format in which the URLs for the hyperlinks in a HyperLinkColumn object are rendered.
        /// </value>
        if (arguments.length !== 0) throw Error.parameterCount();

        return this._dataNavigateUrlFormatString;
    },

    set_dataNavigateUrlFormatString : function(value)
    {
        var e = Function._validateParams(arguments, [{name: 'value', type: String}]);
        if (e) throw e;

        if (this._dataNavigateUrlFormatString != value)
        {
            this._dataNavigateUrlFormatString = value;
            this.raisePropertyChanged('dataNavigateUrlFormatString');
        }
    },

    get_target : function()
    {
        /// <value type="String">
        /// Use this property to specify the window or frame in which to display the Web content linked to a hyperlink when that hyperlink is clicked.
        /// </value>
        if (arguments.length !== 0) throw Error.parameterCount();

        return this._target;
    },

    set_target : function(value)
    {
        var e = Function._validateParams(arguments, [{name: 'value', type: String}]);
        if (e) throw e;

        if (this._target != value)
        {
            this._target = value;
            this.raisePropertyChanged('target');
        }
    },
    
    get_text : function()
    {
        /// <value type="String">
        /// Use this property to specify the caption to display for the hyperlinks in a HyperLinkColumn object. When this property is set, each hyperlink shares the same caption. Instead of using this property to set the hyperlink captions, you can use the DataTextField property to bind the hyperlink captions to a field in a data source. This allows you to display a different caption for each hyperlink.
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

    get_navigateUrl : function()
    {
        /// <value type="String">
        /// Use this property to specify the URL to navigate to when a hyperlink in a HyperLinkColumn object is clicked. When this property is set, each hyperlink shares the same navigation URL. Instead of using this property to set the URL for the hyperlinks, you can use the <see cref="DataNavigateUrlFields"/> property to bind the URLs of the hyperlinks to a field in a data source. This allows you to have a different URL for each hyperlink.
        /// </value>
        if (arguments.length !== 0) throw Error.parameterCount();

        return this._navigateUrl;
    },

    set_navigateUrl : function(value)
    {
        var e = Function._validateParams(arguments, [{name: 'value', type: String}]);
        if (e) throw e;

        if (this._navigateUrl != value)
        {
            this._navigateUrl = value;
            this.raisePropertyChanged('navigateUrl');
        }
    },

    initialize : function()
    {
        /// <summary>
        /// Initialize the column.
        /// </summary>        
        $ADC.GridViewHyperLinkColumn.callBaseMethod(this, 'initialize');
    },

    dispose : function()
    {
        /// <summary>
        /// Dispose the column.
        /// </summary>
        $ADC.GridViewHyperLinkColumn.callBaseMethod(this, 'dispose');
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

        var url = null;
        var dataNavigateUrlFields = this.get_dataNavigateUrlFields();

        if ((dataNavigateUrlFields != null) && (dataNavigateUrlFields.length > 0))
        {
            var fields = dataNavigateUrlFields.split(',');

            if ((fields != null) && (fields.length > 0))
            {
                var values = new Array();
                var field;

                for(var j = 0; j < fields.length; j++)
                {
                    field = fields[j].trim();

                    if (field.length > 0)
                    {
                        Array.add(values, dataRow[field]);
                    }
                }

                if (values.length  > 0)
                {
                    url = String.format(this.get_dataNavigateUrlFormatString(), values);
                }
            }
        }
        else
        {
            var navigateUrl = this.get_navigateUrl();

            if (!$ADC.Util.isEmptyString(navigateUrl))
            {
                url = navigateUrl;
            }
        }

        if (url == null)
        {
            url = '';
        }

        var link = document.createElement('a');
        link.appendChild(document.createTextNode(value));
        link.setAttribute('href', url);

        var target = this.get_target();

        if (!$ADC.Util.isEmptyString(target))
        {
            link.setAttribute('target', target);
        }

        container.appendChild(link);

        if (this.get_controlStyle() != null)
        {
            this.get_controlStyle().apply(link);
        }

        if (this.get_itemStyle() != null)
        {
            this.get_itemStyle().apply(container);
        }
    }
}

$ADC.GridViewHyperLinkColumn.registerClass('AjaxDataControls.GridViewHyperLinkColumn', $ADC.GridViewBaseColumn);

if (typeof(Sys) != 'undefined')
{
    Sys.Application.notifyScriptLoaded();
}