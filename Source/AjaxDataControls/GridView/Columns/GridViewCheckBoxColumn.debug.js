Type.registerNamespace('AjaxDataControls');

$ADC.GridViewCheckBoxColumn = function()
{
    /// <summary>
    /// Represents a selecting option that is displayed as a checkbox in a GridView control.
    /// </summary>

    this._text = '';
    this._dataField = '';
    this._readOnly = false;

    $ADC.GridViewCheckBoxColumn.initializeBase(this);
    $ADC.GridViewCheckBoxColumn.callBaseMethod(this, 'set_allowDragAndDrop', [false]);
}

$ADC.GridViewCheckBoxColumn.prototype =
{
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

    get_text : function()
    {
        /// <value type="String">
        /// Use the Text property to display a caption next to each checkbox in a GridViewCheckBoxColumn. If the Text property is set to an empty string, no caption is displayed.
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
        $ADC.GridViewCheckBoxColumn.callBaseMethod(this, 'initialize');
    },

    dispose : function()
    {
        /// <summary>
        /// Dispose the column.
        /// </summary>
        $ADC.GridViewCheckBoxColumn.callBaseMethod(this, 'dispose');
    },

    renderData : function(dataRow, row, container)
    {
        /// <summary>
        /// This method is used to render the data cell. You do not have to call this method in you code.
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

        if (!$ADC.Util.isEmptyString(dataField))
        {
            value = dataRow[dataField];
        }

        if (value != null)
        {
            var checkbox = document.createElement('input');

            checkbox.setAttribute('type', 'checkbox');

            if ((row.get_rowType() == $ADC.GridViewRowType.EditRow) && (this.get_readOnly() == false))
            {
            }
            else
            {
                checkbox.setAttribute('disabled', 'true');
            }

            var text = this.get_text();

            if (!$ADC.Util.isEmptyString(text))
            {
                var lbl = document.createElement('label');

                lbl.appendChild(checkbox);
                lbl.appendChild(document.createTextNode(text));

                container.appendChild(lbl);
            }
            else
            {
                container.appendChild(checkbox);
            }

            if (value == true)
            {
                checkbox.setAttribute('checked', 'true');
            }

            if (this.get_controlStyle() != null)
            {
                this.get_controlStyle().apply(checkbox);
            }
        }

        if (this.get_itemStyle() != null)
        {
            this.get_itemStyle().apply(container);
        }
    }
}

$ADC.GridViewCheckBoxColumn.registerClass('AjaxDataControls.GridViewCheckBoxColumn', $ADC.GridViewBaseColumn);

if (typeof(Sys) != 'undefined')
{
    Sys.Application.notifyScriptLoaded();
}