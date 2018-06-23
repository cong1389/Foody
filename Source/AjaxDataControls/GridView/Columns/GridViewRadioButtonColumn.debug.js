Type.registerNamespace('AjaxDataControls');

$ADC.GridViewRadioButtonColumn = function()
{
    /// <summary>
    /// Represents a selecting option that is displayed as a radio button in a GridView control.
    /// </summary>
    
    this._groupName = '';
    this._text = '';

    $ADC.GridViewRadioButtonColumn.initializeBase(this);
    $ADC.GridViewRadioButtonColumn.callBaseMethod(this, 'set_allowDragAndDrop', [false]);
}

$ADC.GridViewRadioButtonColumn.prototype =
{
    get_groupName : function()
    {
        /// <value type="String">
        /// Use the GroupName property to specify the group to which radio button belongs to.
        /// </value>
        
        if (arguments.length !== 0) throw Error.parameterCount();

        return this._groupName;
    },

    set_groupName : function(value)
    {
        var e = Function._validateParams(arguments, [{name: 'value', type: String}]);
        if (e) throw e;

        if (this._groupName != value)
        {
            this._groupName = value;
            this.raisePropertyChanged('groupName');
        }
    },

    get_text : function()
    {
        /// <value type="String">
        /// Use the Text property to display a caption next to each radio button in a GridViewRadioButtonColumn. If the Text property is set to an empty string, no caption is displayed.
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

    get_sortField : function()
    {
        /// <value type="String">
        /// The sort field porperty is not supported.
        /// </value>

        if (arguments.length !== 0) throw Error.parameterCount();

        return '';
    },

    set_sortField : function(value)
    {
    },

    initialize : function()
    {
        /// <summary>
        /// Initialize the column.
        /// </summary>
        $ADC.GridViewRadioButtonColumn.callBaseMethod(this, 'initialize');
    },

    dispose : function()
    {
        /// <summary>
        /// Dispose the column.
        /// </summary>
        $ADC.GridViewRadioButtonColumn.callBaseMethod(this, 'dispose');
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

        var groupName = this.get_groupName();

        if ($ADC.Util.isEmptyString(groupName))
        {
            throw Error.invalidOperation('Group name must be set for the column.');
        }

        groupName = this.get_owner().get_id() + groupName;
        var radioButton;

        if (Sys.Browser.agent == Sys.Browser.InternetExplorer)
        {
            radioButton = document.createElement('<input name=\"' + groupName + '\">');
        }
        else
        {
            radioButton = document.createElement('input');
            radioButton.setAttribute('name', groupName);
        }

        radioButton.setAttribute('type', 'radio');

        var text = this.get_text();

        if (!$ADC.Util.isEmptyString(groupName))
        {
            var lbl = document.createElement('label');

            lbl.appendChild(radioButton);
            lbl.appendChild(document.createTextNode(text));

            container.appendChild(lbl);
        }
        else
        {
            container.appendChild(radioButton);
        }

        if (this.get_controlStyle() != null)
        {
            this.get_controlStyle().apply(radioButton);
        }

        if (this.get_itemStyle() != null)
        {
            this.get_itemStyle().apply(container);
        }
    }
}

$ADC.GridViewRadioButtonColumn.registerClass('AjaxDataControls.GridViewRadioButtonColumn', $ADC.GridViewBaseColumn);

if (typeof(Sys) != 'undefined')
{
    Sys.Application.notifyScriptLoaded();
}