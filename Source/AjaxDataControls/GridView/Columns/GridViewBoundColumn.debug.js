Type.registerNamespace('AjaxDataControls');

$ADC.GridViewBoundColumn = function()
{
    /// <summary>
    /// Represents a column that is displayed as text in a GridView control.
    /// </summary>
    
    this._applyFormatInEditMode = false;
    this._dataField = '';
    this._dataFormatString = '';
    this._nullDisplayText = '';
    this._readOnly = false;

    $ADC.GridViewBoundColumn.initializeBase(this);
}

$ADC.GridViewBoundColumn.prototype =
{
    get_applyFormatInEditMode : function()
    {
        /// <value type="Boolean">
        /// Whether the formatting string specified by the DataFormatString property is applied to field values when the GridView control that contains the GridViewBoundColumn object is in edit mode.
        /// </value>
        if (arguments.length !== 0) throw Error.parameterCount();

        return this._applyFormatInEditMode;
    },

    set_applyFormatInEditMode : function(value)
    {
        var e = Function._validateParams(arguments, [{name: 'value', type: Boolean}]);
        if (e) throw e;

        if (this._applyFormatInEditMode != value)
        {
            this._applyFormatInEditMode = value;
            this.raisePropertyChanged('applyFormatInEditMode');
        }
    },

    get_dataField : function()
    {
        /// <value type="String">
        /// Use this property to specify the name of the data field to bind with this column.
        /// </value>
        if (arguments.length !== 0) throw Error.parameterCount();

        return this._dataField;
    },

    set_dataField : function(value)
    {
        var e = Function._validateParams(arguments, [{name: 'value', type: String}]);
        if (e) throw e;

        if (this._dataField != value)
        {
            this._dataField = value;
            this.raisePropertyChanged('dataField');
        }
    },

    get_dataFormatString : function()
    {
        /// <value type="String">
        /// Use the <b>DataFormatString</b> property to specify a custom display format for the values displayed in the GridViewBoundColumn object. If the DataFormatString property is not set, the field's value is displayed without any special formatting.
        /// </value>
        if (arguments.length !== 0) throw Error.parameterCount();

        return this._dataFormatString;
    },

    set_dataFormatString : function(value)
    {
        var e = Function._validateParams(arguments, [{name: 'value', type: String}]);
        if (e) throw e;

        if (this._dataFormatString != value)
        {
            this._dataFormatString = value;
            this.raisePropertyChanged('dataFormatString');
        }
    },

    get_nullDisplayText : function()
    {
        /// <value type="String">
        /// Use this property to specify a custom caption to display for fields that have a null value. If this property is not set, null field values are displayed as empty strings ("").
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

    get_readOnly : function()
    {
        /// <value type="Boolean">
        /// Whether the value of the field can be modified in edit mode.
        /// </value>
        if (arguments.length !== 0) throw Error.parameterCount();

        return this._readOnly;
    },

    set_readOnly : function(value)
    {
        var e = Function._validateParams(arguments, [{name: 'value', type: Boolean}]);
        if (e) throw e;

        if (this._readOnly != value)
        {
            this._readOnly = value;
            this.raisePropertyChanged('readOnly');
        }
    },

    initialize : function()
    {
        /// <summary>
        /// Initialize the column.
        /// </summary>
        $ADC.GridViewBoundColumn.callBaseMethod(this, 'initialize');
    },

    dispose : function()
    {
        /// <summary>
        /// Dispose the column.
        /// </summary>
        $ADC.GridViewBoundColumn.callBaseMethod(this, 'dispose');
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
        var dataField = this.get_dataField();
        var dataFormatString = this.get_dataFormatString();

        if (!$ADC.Util.isEmptyString(dataField))
        {
            value = dataRow[dataField];
        }

        if ((row.get_rowType() == $ADC.GridViewRowType.EditRow) && (this.get_readOnly() == false))
        {
            if (this.get_applyFormatInEditMode() == true)
            {
                if (!$ADC.Util.isEmptyString(dataFormatString))
                {
                    value = value.localeFormat(dataFormatString);
                }
            }

            if (value == null)
            {
                value = '';
            }

            var textbox = document.createElement('input');

            textbox.setAttribute('type', 'text');
            textbox.setAttribute('value', value);

            container.appendChild(textbox);

            if (this.get_controlStyle() != null)
            {
                this.get_controlStyle().apply(textbox);
            }
        }
        else
        {
            if (value == null)
            {
                var nullDisplayText = this.get_nullDisplayText();

                if (!$ADC.Util.isEmptyString(nullDisplayText))
                {
                    value = nullDisplayText;
                }
            }
            else
            {
                if (!$ADC.Util.isEmptyString(dataFormatString))
                {
                    value = value.localeFormat(dataFormatString);
                }
            }

            if (value == null)
            {
                value = '';
            }

            container.appendChild(document.createTextNode(value));
        }

        if (this.get_itemStyle() != null)
        {
            this.get_itemStyle().apply(container);
        }
    }
}

$ADC.GridViewBoundColumn.registerClass('AjaxDataControls.GridViewBoundColumn', $ADC.GridViewBaseColumn);

if (typeof(Sys) != 'undefined')
{
    Sys.Application.notifyScriptLoaded();
}