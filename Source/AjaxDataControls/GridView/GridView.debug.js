Type.registerNamespace('AjaxDataControls');

$ADC.GridViewBaseColumn = function()
{
    /// <summary>
    /// The base class which represent a column of GridView Control.
    /// </summary>

    this._columnID = 0;
    this._controlStyle = null;
    this._headerStyle = null;
    this._headerText = '';
    this._sortField = '';
    this._allowDragAndDrop = true;
    this._visible = true;
    this._itemStyle = null;

    this._footerStyle = null;
    this._footerText = '';

    this._headerContainer = null;
    this._footerContainer = null;

    this._sortLink = null;
    this._sortHandler = null;

    this._owner = null;

    this._mouseDownHandler;
    this._visualClue = null;

    $ADC.GridViewBaseColumn.initializeBase(this);
}

$ADC.GridViewBaseColumn.prototype =
{
    get_columnID : function()
    {
        /// <value type="Number" integer="true">
        /// The ID of the column which is used to uniquely identify the column among the other columns in the GridView Control.
        /// </value>

        if (arguments.length !== 0) throw Error.parameterCount();

        return this._columnID;
    },

    set_columnID : function(value)
    {
        var e = Function._validateParams(arguments, [{name: 'value', type: Number}]);
        if (e) throw e;

        if (this._columnID != value)
        {
            this._columnID = value;
            this.raisePropertyChanged('columnID');
        }
    },

    get_controlStyle : function()
    {
        /// <value type="AjaxDataControls.Style" mayBeNull="true">
        /// The style of the controls contained by the column.
        /// </value>

        if (arguments.length !== 0) throw Error.parameterCount();

        return this._controlStyle;
    },

    set_controlStyle : function(value)
    {
        var e = Function._validateParams(arguments, [{name: 'value', type: $ADC.Style}]);
        if (e) throw e;

        if (this._controlStyle != value)
        {
            this._controlStyle = value;
            this.raisePropertyChanged('controlStyle');
        }
    },

    get_headerStyle : function()
    {
        /// <value type="AjaxDataControls.TableItemStyle" mayBeNull="true">
        /// The style applied to header within this colum.
        /// </value>

        if (arguments.length !== 0) throw Error.parameterCount();

        return this._headerStyle;
    },

    set_headerStyle : function(value)
    {
        var e = Function._validateParams(arguments, [{name: 'value', type: $ADC.TableItemStyle}]);
        if (e) throw e;

        if (this._headerStyle != value)
        {
            this._headerStyle = value;
            this.raisePropertyChanged('headerStyle');
        }
    },

    get_headerText : function()
    {
        /// <value type="String">
        /// Use the HeaderText property to identify a field in a data control with a friendly name. The most common application of the HeaderText property is to provide meaningful column names for data-bound fields in a GridView control.
        /// </value>

        if (arguments.length !== 0) throw Error.parameterCount();

        return this._headerText;
    },

    set_headerText : function(value)
    {
        var e = Function._validateParams(arguments, [{name: 'value', type: String}]);
        if (e) throw e;

        if (this._headerText != value)
        {
            this._headerText = value;
            this.raisePropertyChanged('headerText');
        }
    },

    get_sortField : function()
    {
        /// <value type="String">
        /// The sort field in the data source that is used by a data source control to sort data.
        /// </value>

        if (arguments.length !== 0) throw Error.parameterCount();

        return this._sortField;
    },

    set_sortField : function(value)
    {
        var e = Function._validateParams(arguments, [{name: 'value', type: String}]);
        if (e) throw e;

        if (this._sortField != value)
        {
            this._sortField = value;
            this.raisePropertyChanged('sortField');
        }
    },

    get_allowDragAndDrop : function()
    {
        /// <value type="Boolean">
        /// Whether to allow drag and drop of this column.
        /// </value>

        if (arguments.length !== 0) throw Error.parameterCount();

        return this._allowDragAndDrop;
    },

    set_allowDragAndDrop : function(value)
    {
        var e = Function._validateParams(arguments, [{name: 'value', type: Boolean}]);
        if (e) throw e;

        if (this._allowDragAndDrop != value)
        {
            this._allowDragAndDrop = value;
            this.raisePropertyChanged('allowDragAndDrop');
        }
    },

    get_visible : function()
    {
        /// <value type="Boolean">
        /// Whether the column is visible or not.
        /// </value>

        if (arguments.length !== 0) throw Error.parameterCount();

        return this._visible;
    },

    set_visible : function(value)
    {
        var e = Function._validateParams(arguments, [{name: 'value', type: Boolean}]);
        if (e) throw e;

        if (this._visible != value)
        {
            this._visible = value;
            this.raisePropertyChanged('visible');
        }
    },

    get_itemStyle : function()
    {
        /// <value type="AjaxDataControls.TableItemStyle" mayBeNull="true">
        /// The style of any text-based content displayed by the column.
        /// </value>

        if (arguments.length !== 0) throw Error.parameterCount();

        return this._itemStyle;
    },

    set_itemStyle : function(value)
    {
        var e = Function._validateParams(arguments, [{name: 'value', type: $ADC.TableItemStyle}]);
        if (e) throw e;

        if (this._itemStyle != value)
        {
            this._itemStyle = value;
            this.raisePropertyChanged('itemStyle');
        }
    },

    get_footerStyle : function()
    {
        /// <value type="AjaxDataControls.TableItemStyle" mayBeNull="true">
        /// The style applied to footer within this column.
        /// </value>

        if (arguments.length !== 0) throw Error.parameterCount();

        return this._footerStyle;
    },

    set_footerStyle : function(value)
    {
        var e = Function._validateParams(arguments, [{name: 'value', type: $ADC.TableItemStyle}]);
        if (e) throw e;

        if (this._footerStyle != value)
        {
            this._footerStyle = value;
            this.raisePropertyChanged('footerStyle');
        }
    },

    get_footerText : function()
    {
        /// <value type="String">
        /// The text within the footer of this column.
        /// </value>

        if (arguments.length !== 0) throw Error.parameterCount();

        return this._footerText;
    },

    set_footerText : function(value)
    {
        var e = Function._validateParams(arguments, [{name: 'value', type: String}]);
        if (e) throw e;

        if (this._footerText != value)
        {
            this._footerText = value;
            this.raisePropertyChanged('footerText');
        }
    },

    get_owner : function()
    {
        /// <value type="AjaxDataControls.GridView">
        /// The GridView which owns the column.
        /// </value>

        if (arguments.length !== 0) throw Error.parameterCount();

        return this._owner;
    },

    set_owner : function(value)
    {
        var e = Function._validateParams(arguments, [{name: 'value', type: $ADC.GridView}]);
        if (e) throw e;

        if (this._owner != value)
        {
            this._owner = value;
        }
    },

    get_headerContainer : function()
    {
        /// <value domElement="true">
        /// The header container cell(th) of this column.
        /// </value>

        if (arguments.length !== 0) throw Error.parameterCount();

        return this._headerContainer;
    },

    set_headerContainer : function(value)
    {
        var e = Function._validateParams(arguments, [{name: 'value', type: Object}]);
        if (e) throw e;

        if (this._headerContainer != value)
        {
            this._headerContainer = value;

            if (this._isDragAndDropAllowed())
            {
                this._mouseDownHandler = Function.createDelegate(this, this._onMouseDown)
                $addHandler(this._headerContainer, 'mousedown', this._mouseDownHandler);

                Sys.Preview.UI.DragDropManager.registerDropTarget(this);
            }
        }
    },

    get_footerContainer : function()
    {
        /// <value domElement="true">
        /// The footer container cell(td) of this column.
        /// </value>

        if (arguments.length !== 0) throw Error.parameterCount();

        return this._footerContainer;
    },

    set_footerContainer : function(value)
    {
        var e = Function._validateParams(arguments, [{name: 'value', type: Object}]);
        if (e) throw e;

        if (this._footerContainer != value)
        {
            this._footerContainer = value;
        }
    },

    get_dragDataType : function()
    {
        /// <value type="Object" mayBeNull="true">
        /// Implemented interface of IDragSource.
        /// </value>

        var dataType = this._owner.get_id() + '-GridViewColumn';

        return dataType;
    },

    get_dragMode : function()
    {
        /// <value type="Sys.Preview.UI.DragMode">
        /// Implemented interface of IDragSource.
        /// </value>

        return Sys.Preview.UI.DragMode.Move;
    },

    get_dropTargetElement : function()
    {
        /// <value domElement="true">
        /// Implemented interface of IDropTarget. Returns the Drop Target which is the header container of the column.
        /// </value>

        return this._headerContainer;
    },

    initialize : function()
    {
        /// <summary>
        /// Initialize the column.
        /// </summary>

        $ADC.GridViewBaseColumn.callBaseMethod(this, 'initialize');
    },

    dispose : function()
    {
        /// <summary>
        /// Dispose the column.
        /// </summary>

        this.releaseResource();

        delete this._owner;
        delete this._headerContainer;
        delete this._footerContainer;

        delete this._mouseDownHandler;
        delete this._visualClue;

        delete this._sortLink;
        delete this._sortHandler;

        delete this._controlStyle;
        delete this._headerStyle;
        delete this._itemStyle;
        delete this._footerStyle;

        $ADC.GridViewBaseColumn.callBaseMethod(this, 'dispose');
    },

    renderHeader : function(row)
    {
        /// <summary>
        /// Draws the header section in the previously specified header container. You will only override this method if you
        /// want to develop custom colum which requires extra logic. Other than this you do not have to call this method in your code.
        /// </summary>
        /// <param name="row" type="AjaxDataControls.GridViewRow">
        /// The GridViewRow which is passed to render the header that item type is set to <b>AjaxDataControls.GridViewRowType.Header</b>.
        /// </param>

        var e = Function._validateParams(arguments, [{name: 'row', type: $ADC.GridViewRow}]);
        if (e) throw e;

        var owner = this.get_owner();
        var container = this.get_headerContainer();

        if (owner == null)
        {
            throw Error.invalidOperation('Owner must be set before calling this method.');
        }

        if (container == null)
        {
            throw Error.invalidOperation('Header container must be set before calling this method.');
        }

        var headerText = this.get_headerText();

        if (!$ADC.Util.isEmptyString(headerText))
        {
            var sortField = this.get_sortField();

            if (!$ADC.Util.isEmptyString(sortField))
            {
                this._sortLink = document.createElement('a');
                this._sortLink.appendChild(document.createTextNode(headerText));
                this._sortLink.href = 'javascript:void(0)';
                container.appendChild(this._sortLink);

                var sortColumn = owner.get_sortColumn();
                var sortOrder = $ADC.GridViewSortOrder.Ascending;

                if (sortColumn == sortField)
                {
                    var sortImageUrl = '';

                    if (owner.get_sortOrder() == $ADC.GridViewSortOrder.Ascending)
                    {
                        sortOrder = $ADC.GridViewSortOrder.Descending;
                        sortImageUrl = owner.get_sortOrderAscendingImageUrl();
                    }
                    else
                    {
                        sortImageUrl = owner.get_sortOrderDescendingImageUrl();
                    }

                    if (!$ADC.Util.isEmptyString(sortImageUrl))
                    {
                        var img = document.createElement('img');
                        img.setAttribute('src', sortImageUrl);
                        img.setAttribute('alt', '');
                        container.appendChild(img);
                    }
                }

                //Create a callback so that we can pass the sortColumn name and direction
                this._sortHandler = Function.createCallback(owner._raiseSort, {sender:owner, sortColumn:sortField, sortOrder:sortOrder});
                $addHandler(this._sortLink, 'click', this._sortHandler);
            }
            else
            {
                if ($ADC.Util.isEmptyString(headerText))
                {
                    headerText = ' ';
                }

                container.appendChild(document.createTextNode(headerText));
            }
        }
        else
        {
            if ($ADC.Util.isEmptyString(headerText))
            {
                headerText = ' ';
            }

            container.appendChild(document.createTextNode(headerText));
        }

        if (this.get_headerStyle() != null)
        {
            this.get_headerStyle().apply(container);
        }

        if (this._isDragAndDropAllowed())
        {
            container.style.cursor = 'move';
            container.style.zIndex = '9999';
        }
    },

    renderData : function(dataRow, row, container)
    {
        /// <summary>
        /// Abstract method. The Derived column needs to override it. You do not have to call this method in you code.
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

        throw Error.notImplemented();
    },

    renderFooter : function(row)
    {
        /// <summary>
        /// Draws the footer section in the previously specified footer container. You will only override this method if you
        /// want to develop custom colum which requires extra logic. Other than this you do not have to call this method in your code.
        /// </summary>
        /// <param name="row" type="AjaxDataControls.GridViewRow">
        /// The GridViewRow which is passed to render the footer that item type is set to <b>AjaxDataControls.GridViewRowType.Footer</b>.
        /// </param>

        var e = Function._validateParams(arguments, [{name: 'row', type: $ADC.GridViewRow}]);
        if (e) throw e;

        var container = this.get_footerContainer();

        if (container == null)
        {
            throw Error.invalidOperation('Footer container must be set before calling this method.');
        }

        var footerText = this.get_footerText();

        if (!$ADC.Util.isEmptyString(footerText))
        {
            container.appendChild(document.createTextNode(footerText));
        }

        if (this.get_footerStyle() != null)
        {
            this.get_footerStyle().apply(container);
        }
    },

    releaseResource : function()
    {
        /// <summary>
        /// Releases all resources which are associated with this column.
        /// </summary>

        if (this._isDragAndDropAllowed())
        {
            if (this._headerContainer != null)
            {
                $removeHandler(this._headerContainer, 'mousedown', this._mouseDownHandler);
                Sys.Preview.UI.DragDropManager.unregisterDropTarget(this);
            }

            if (this._visualClue != null)
            {
                document.getElementsByTagName('body')[0].removeChild(this._visualClue);
            }
        }

        if ((this._sortLink != null) && (this._sortHandler != null))
        {
            $removeHandler(this._sortLink, 'click', this._sortHandler);
        }
    },

    getDragData : function(context)
    {
        /// <summary>
        /// Implemented interface of IDragSource. Returns itself as the drag data.
        /// </summary>
        /// <param name="context" type="Object">
        /// The drag and drop context.
        /// </param>
        /// <returns type="Object">Returns itself.</returns>

        return this;
    },

    onDragStart : function()
    {
        /// <summary>
        /// Implemented interface of IDragSource. Called when the drag started.
        /// </summary>

        this._owner._raiseColumnDragStart(this);
    },

    onDrag : function()
    {
        /// <summary>
        /// Implemented interface of IDragSource. Called repeatedly when the while dragging. This method is empty or does not do anything.
        /// </summary>
    },

    onDragEnd : function(cancelled)
    {
        /// <summary>
        /// Implemented interface of IDragSource. Called when the drag ends.
        /// </summary>
        /// <param name="cancelled" type="Boolean">
        /// Indicates whether drop was successful.
        /// </param>

        if (this._visualClue != null)
        {
            document.getElementsByTagName('body')[0].removeChild(this._visualClue);
            this._visualClue = null;
        }
    },

    canDrop : function(dragMode, dataType, dragData)
    {
        /// <summary>
        /// Implemented interface of IDropTarget. Ensures that only the columns of the same GridView can be dropped.
        /// </summary>
        /// <param name="dragMode" type="Sys.Preview.UI.DragMode">
        /// The drag mode .
        /// </param>
        /// <param name="dataType" type="Object">
        /// The data type.
        /// </param>
        /// <param name="dragData" type="Object">
        /// The drag data which is the Column itself.
        /// </param>
        /// <returns type="Boolean">Indecates whether it can be dropped on the target.</returns>

        var supportedDataType = this._owner.get_id() + '-GridViewColumn';

        return (dataType == supportedDataType);
    },

    drop : function(dragMode, dataType, draggingColumn)
    {
        /// <summary>
        /// Implemented interface of IDropTarget. Called the when the column is dropped.
        /// </summary>
        /// <param name="dragMode" type="Sys.Preview.UI.DragMode">
        /// The drag mode .
        /// </param>
        /// <param name="dataType" type="Object">
        /// The data type.
        /// </param>
        /// <param name="draggingColumn" type="Object">
        /// The drag data which is the column itself.
        /// </param>

        var columns = this._owner.get_columns();
        var oldIndex = Array.indexOf(columns, draggingColumn);
        var newIndex = Array.indexOf(columns, this);

        var tds;
        var td;
        var maxIndex = 0;

        var trHeader = this._owner._headerRow.get_container();
        maxIndex = trHeader.childNodes.length

        //Now insert the column in proper order

        //First put the header
        tds = trHeader.childNodes;
        td = trHeader.removeChild(tds[oldIndex]);

        if ((newIndex >= maxIndex) || (newIndex + 1 >= maxIndex))
        {
            trHeader.appendChild(td);
        }
        else
        {
            trHeader.insertBefore(td, tds[newIndex]);
        }

        //Now the Datarows
        var length = this._owner._rows.length;
        var tr;

        for (var i = 0; i < length; i++)
        {
            tr = this._owner._rows[i].get_container();
            tds = tr.childNodes;
            td = tr.removeChild(tds[oldIndex]);

            if ((newIndex >= maxIndex) || (newIndex + 1 >= maxIndex))
            {
                tr.appendChild(td);
            }
            else
            {
                tr.insertBefore(td, tds[newIndex]);
            }
        }

        //Now the footer
        var trFooter = this._owner._footerRow.get_container();
        maxIndex = trFooter.childNodes.length

        if (maxIndex > 0)
        {
            tds = trFooter.childNodes;
            td = trFooter.removeChild(tds[oldIndex]);

            if ((newIndex >= maxIndex) || (newIndex + 1 >= maxIndex))
            {
                trFooter.appendChild(td);
            }
            else
            {
                trFooter.insertBefore(td, tds[newIndex]);
            }
        }

        //Now we have to modify the column collection so that
        //it can presist the order in future dataBind method
        var column = columns[oldIndex]; //Get the target column

        if (Array.remove(columns, column)) // Now Remove it from the Old index
        {
            Array.insert(columns, newIndex, column); // And insert it in new index
        }

        this._owner._raiseColumnDropped(draggingColumn, oldIndex, newIndex);
    },

    onDragEnterTarget : function(dragMode, dataType, dragData)
    {
        /// <summary>
        /// Implemented interface of IDropTarget. Called the when the column enters in the drop target. This method is empty or does not do anything.
        /// </summary>
        /// <param name="dragMode" type="Sys.Preview.UI.DragMode">
        /// The drag mode .
        /// </param>
        /// <param name="dataType" type="Object">
        /// The data type.
        /// </param>
        /// <param name="dragData" type="Object">
        /// The drag data which is the column itself.
        /// </param>
    },

    onDragInTarget : function(dragMode, dataType, dragData)
    {
        /// <summary>
        /// Implemented interface of IDropTarget. Called repeatedly the when the column is in the drop target. This method is empty or does not do anything.
        /// </summary>
        /// <param name="dragMode" type="Sys.Preview.UI.DragMode">
        /// The drag mode .
        /// </param>
        /// <param name="dataType" type="Object">
        /// The data type.
        /// </param>
        /// <param name="dragData" type="Object">
        /// The drag data which is the column itself.
        /// </param>
    },

    onDragLeaveTarget : function(dragMode, dataType, dragData)
    {
        /// <summary>
        /// Implemented interface of IDropTarget. Called the when the column leaves the drop target. This method is empty or does not do anything.
        /// </summary>
        /// <param name="dragMode" type="Sys.Preview.UI.DragMode">
        /// The drag mode .
        /// </param>
        /// <param name="dataType" type="Object">
        /// The data type.
        /// </param>
        /// <param name="dragData" type="Object">
        /// The drag data which is the column itself.
        /// </param>
    },

    _onMouseDown : function(e)
    {
        if (e.target == this._headerContainer)
        {
            window._event = e;
            e.preventDefault();

            this._createVisualClue();
            Sys.Preview.UI.DragDropManager.startDragDrop(this, this._visualClue, null);
        }
    },

    _createVisualClue : function()
    {
        var makeSameHeight =    (
                                    (Sys.Browser.agent != Sys.Browser.InternetExplorer) &&
                                    (Sys.Browser.agent != Sys.Browser.Safari)
                                );

        var index = Array.indexOf(this._owner.get_columns(), this);
        this._visualClue = this._owner.get_element().cloneNode(false);

        if (this._visualClue.id)
        {
            this._visualClue.removeAttribute('id');
        }

        document.getElementsByTagName('body')[0].appendChild(this._visualClue);

        var thead = document.createElement('thead');
        this._visualClue.appendChild(thead);

        tr = document.createElement('tr');
        thead.appendChild(tr);
        this._copyAttributes(this._owner._headerRow._container, tr);

        var td = this._headerContainer.cloneNode(true);
        tr.appendChild(td);

        if (makeSameHeight)
        {
            td.style.height = this._headerContainer.clientHeight + 'px';
        }

        var tbody = document.createElement('tbody');
        this._visualClue.appendChild(tbody);
        var length = this._owner._rows.length;

        var trSourceHead;
        var tdSource;

        for (var i = 0; i < length; i++)
        {
            trSourceHead = this._owner._rows[i].get_container();
            tr = document.createElement('tr');
            tbody.appendChild(tr);

            this._copyAttributes(trSourceHead, tr);

            tdSource = trSourceHead.childNodes[index];
            td = tdSource.cloneNode(true);
            tr.appendChild(td);

            if (makeSameHeight)
            {
                td.style.height = tdSource.clientHeight + 'px';
            }
        }

        var tfoot = document.createElement('tfoot');
        this._visualClue.appendChild(tfoot);

        tr = document.createElement('tr');
        tfoot.appendChild(tr);

        var trSourceFoot = this._owner._footerRow._container;
        this._copyAttributes(trSourceFoot, tr);

        if (trSourceFoot.childNodes.length > 0)
        {
            td = trSourceFoot.childNodes[index].cloneNode(true);
            tr.appendChild(td);

            if (makeSameHeight)
            {
                td.style.height = trSourceFoot.childNodes[index].clientHeight + 'px';
            }
        }

        //Create a tranparent effect
        var alphaOpacity = this._owner.get_dragOpacity();
        var opacity = (alphaOpacity / 100);

        this._visualClue.style.filter = 'alpha(opacity=' + alphaOpacity.toString() + ')';
        this._visualClue.style.opacity = opacity.toString(); // IE Only
        this._visualClue.style.mozOpacity = opacity.toString(); //Mozila only

        var location = Sys.UI.DomElement.getLocation(this._headerContainer);

        this._visualClue.style.width = this._headerContainer.clientWidth + 'px';
        Sys.UI.DomElement.setLocation(this._visualClue, location.x, location.y);
    },

    _isDragAndDropAllowed : function()
    {
        var allowed = this.get_allowDragAndDrop();

        if (allowed)
        {
            allowed =   $ADC.Util.hasDragNDropSupport();
        }

        return allowed;
    },

    _copyAttributes : function(sourceNode, targetNode)
    {
        if (Sys.Browser.agent == Sys.Browser.InternetExplorer)
        {
            targetNode.mergeAttributes(sourceNode); //Only IE supports it
        }
        else
        {
            var attributes = sourceNode.attributes;

            if ((attributes != null) && (attributes.length > 0))
            {
                var length  = attributes.length;

                for(var i = 0; i < length; i++)
                {
                    targetNode.setAttribute(attributes[i].nodeName, attributes[i].nodeValue);
                }
            }
        }
    }
}

//We will only allow drag and drop if the Ajax Framework Drag and Drop script is added.
if ($ADC.Util.hasDragNDropSupport())
{
    $ADC.GridViewBaseColumn.registerClass('AjaxDataControls.GridViewBaseColumn', Sys.Component, Sys.Preview.UI.IDragSource, Sys.Preview.UI.IDropTarget);
}
else
{
    $ADC.GridViewBaseColumn.registerClass('AjaxDataControls.GridViewBaseColumn', Sys.Component);
}


$ADC.GridViewColumnButtonType = function()
{
    /// <summary>
    /// Specifies the different types of buttons that can be rendered in a GridView control.
    /// </summary>
    /// <field name="Button" type="Number" integer="true" static="true">A command button.</field>
    /// <field name="Image" type="Number" integer="true" static="true">A button that displays an image.</field>
    /// <field name="Link" type="Number" integer="true" static="true">A hyperlink-style button.</field>

    throw Error.notImplemented();
}

$ADC.GridViewColumnButtonType.prototype =
{
    Button : 0,
    Image : 1,
    Link : 2
}

$ADC.GridViewColumnButtonType.registerEnum('AjaxDataControls.GridViewColumnButtonType');


$ADC.GridViewColumnDragStartEventArgs = function(column)
{
    /// <summary>
    /// Event arguments used for the GridView column drag start event.
    /// </summary>
    /// <param name="column" type="AjaxDataControls.GridViewBaseColumn">
    /// The Column object.
    /// </param>

    var e = Function._validateParams(arguments, [{name: 'column', type: $ADC.GridViewBaseColumn}]);
    if (e) throw e;

    this._column = column;
    $ADC.GridViewColumnDragStartEventArgs.initializeBase(this);
}

$ADC.GridViewColumnDragStartEventArgs.prototype =
{
    get_column : function()
    {
        /// <value type="AjaxDataControls.GridViewBaseColumn">
        /// The associated Column object.
        /// </value>

        if (arguments.length !== 0) throw Error.parameterCount();

        return this._column;
    }
}

$ADC.GridViewColumnDragStartEventArgs.registerClass('AjaxDataControls.GridViewColumnDragStartEventArgs', Sys.EventArgs);


$ADC.GridViewColumnDroppedEventArgs = function(column, oldIndex, newIndex)
{
    /// <summary>
    /// Event arguments used for the GridView column dropped event.
    /// </summary>
    /// <param name="column" type="AjaxDataControls.GridViewBaseColumn">
    /// The Column object which is dropped.
    /// </param>
    /// <param name="oldIndex" type="Number" integer="true">
    /// The old index of the column.
    /// </param>
    /// <param name="newIndex" type="Number" integer="true">
    /// The new index of the column.
    /// </param>

    var e = Function._validateParams(arguments, [{name: 'column', type: $ADC.GridViewBaseColumn}, {name: 'oldIndex', type: Number}, {name: 'newIndex', type: Number}]);
    if (e) throw e;

    this._column = column;
    this._oldIndex = oldIndex;
    this._newIndex = newIndex;

    $ADC.GridViewColumnDroppedEventArgs.initializeBase(this);
}

$ADC.GridViewColumnDroppedEventArgs.prototype =
{
    get_column : function()
    {
        /// <value type="AjaxDataControls.GridViewBaseColumn">
        /// The associated Column object.
        /// </value>

        if (arguments.length !== 0) throw Error.parameterCount();

        return this._column;
    },

    get_oldIndex : function()
    {
        /// <value type="Number" integer="true">
        /// The old index of the colum.
        /// </value>

        if (arguments.length !== 0) throw Error.parameterCount();

        return this._oldIndex;
    },

    get_newIndex : function()
    {
        /// <value type="Number" integer="true">
        /// The new index of the colum.
        /// </value>

        if (arguments.length !== 0) throw Error.parameterCount();

        return this._newIndex;
    }
}

$ADC.GridViewColumnDroppedEventArgs.registerClass('AjaxDataControls.GridViewColumnDroppedEventArgs', Sys.EventArgs);


$ADC.GridViewSortOrder = function()
{
    /// <summary>
    /// Specifies the direction in which to sort the GridView Rows.
    /// </summary>
    /// <field name="None" type="Number" integer="true" static="true">Do not sort</field>
    /// <field name="Ascending" type="Number" integer="true" static="true">Sort from smallest to largest. For example, from A to Z.</field>
    /// <field name="Descending" type="Number" integer="true" static="true">Sort from largest to smallest. For example, from Z to A.</field>

    throw Error.notImplemented();
}

$ADC.GridViewSortOrder.prototype =
{
    None : 0,
    Ascending : 1,
    Descending : 2
}

$ADC.GridViewSortOrder.registerEnum('AjaxDataControls.GridViewSortOrder');


$ADC.GridViewSortCommandEventArgs = function(sortColumn, sortOrder)
{
    /// <summary>
    /// Event arguments used for the GridView sort command event.
    /// </summary>
    /// <param name="sortColumn" type="String">
    /// The name of the sort column that is associated with this column.
    /// </param>
    /// <param name="sortOrder" type="AjaxDataControls.GridViewSortOrder">
    /// The order to sort.
    /// </param>

    var e = Function._validateParams(arguments, [{name: 'sortColumn', type: String}, {name: 'sortOrder', type: $ADC.GridViewSortOrder}]);
    if (e) throw e;

    this._sortColumn = sortColumn;
    this._sortOrder = sortOrder;

    $ADC.GridViewSortCommandEventArgs.initializeBase(this);
}

$ADC.GridViewSortCommandEventArgs.prototype =
{
    get_sortColumn : function()
    {
        /// <value type="String">
        /// The sort column.
        /// </value>

        if (arguments.length !== 0) throw Error.parameterCount();

        return this._sortColumn;
    },

    get_sortOrder : function()
    {
        /// <value type="AjaxDataControls.GridViewSortOrder">
        /// The order to sort.
        /// </value>

        if (arguments.length !== 0) throw Error.parameterCount();

        return this._sortOrder;
    }
}

$ADC.GridViewSortCommandEventArgs.registerClass('AjaxDataControls.GridViewSortCommandEventArgs', Sys.EventArgs);


$ADC.GridViewRowType = function()
{
    /// <summary>
    /// Specifies the type of an row in a GridView control.
    /// </summary>
    /// <field name="NotSet" type="Number" integer="true" static="true">Not set. Used internally.</field>
    /// <field name="Header" type="Number" integer="true" static="true">A header for the GridView control. It is not data-bound.</field>
    /// <field name="Footer" type="Number" integer="true" static="true">A footer for the GridView control. It is not data-bound. </field>
    /// <field name="Row" type="Number" integer="true" static="true">A row in the GridView control. It is data-bound.</field>
    /// <field name="AlternatingRow" type="Number" integer="true" static="true">An alternating row (zero-based even-indexed). It is data-bound.</field>
    /// <field name="SelectedRow" type="Number" integer="true" static="true">A selected row in the GridView control. It is data-bound.</field>
    /// <field name="EditRow" type="Number" integer="true" static="true">A row in a GridView control currently in edit mode. It is data-bound.</field>

    throw Error.notImplemented();
}

$ADC.GridViewRowType.prototype =
{
    NotSet : 0,
    Header : 1,
    Footer : 2,
    Row : 3,
    AlternatingRow : 4,
    SelectedRow : 5,
    EditRow : 6
}

$ADC.GridViewRowType.registerEnum('AjaxDataControls.GridViewRowType');


$ADC.GridViewRow = function(namingContainer, container, rowIndex, rowType, dataItem)
{
    /// <summary>
    /// Represents an individual row in a GridView Control.
    /// </summary>
    /// <param name="namingContainer" type="string">
    /// The naming container, which creates a unique namespace for differentiating between controls with the same Control.ID property value.
    /// </param>
    /// <param name="container" domElement="true">
    /// The container html table row (tr) where the row will be rendered.
    /// </param>
    /// <param name="rowIndex" type="Number" integer="true">
    /// The Index of the item.
    /// </param>
    /// <param name="rowType" type="AjaxDataControls.GridViewRowType">
    /// The Type of the row.
    /// </param>
    /// <param name="dataItem" type="Object" mayBeNull="true">
    /// The associate data with this row of the data source of the GridView that the row belongs.
    /// </param>

    var e = Function._validateParams(arguments, [{name: 'namingContainer', type: String}, {name: 'container', type: Object}, {name: 'rowIndex', type: Number}, {name: 'rowType', type: $ADC.GridViewRowType}, {name: 'dataItem',  mayBeNull:true}]);
    if (e) throw e;

    this._namingContainer = namingContainer;
    this._container = container;
    this._rowIndex = rowIndex;
    this._rowType = rowType;
    this._dataItem = dataItem;
    this._controls = new Array();
}

$ADC.GridViewRow.prototype =
{
    get_container : function()
    {
        /// <value domElement="true">
        /// The container table row (tr).
        /// </value>

        if (arguments.length !== 0) throw Error.parameterCount();

        return this._container;
    },

    get_rowIndex : function()
    {
        /// <value type="Number" integer="true">
        /// The container table row (tr).
        /// The index of the row in the GridView control from the Rows collection of the control.
        /// </value>

        if (arguments.length !== 0) throw Error.parameterCount();

        return this._rowIndex;
    },

    get_rowType : function()
    {
        /// <value type="AjaxDataControls.GridViewRowType">
        /// The Type of the row.
        /// </value>

        if (arguments.length !== 0) throw Error.parameterCount();

        return this._rowType;
    },

    get_dataItem : function()
    {
        /// <value type="Object" mayBeNull="true">
        /// The data of the datasource which is associated with this row.
        /// </value>

        if (arguments.length !== 0) throw Error.parameterCount();

        return this._dataItem;
    },

    get_isDataRowType : function()
    {
        /// <value type="Boolean">
        /// Checks if the row is a data row. Use it when you want to exclude the non data rows like header, footer.
        /// </value>

        if (arguments.length !== 0) throw Error.parameterCount();

        var rowType = this.get_rowType();

        return  (
                    (rowType == $ADC.GridViewRowType.Row) ||
                    (rowType == $ADC.GridViewRowType.AlternatingRow) ||
                    (rowType == $ADC.GridViewRowType.SelectedRow) ||
                    (rowType == $ADC.GridViewRowType.EditRow)
                );
    },

    dispose : function()
    {
        /// <summary>
        /// Dispose the row.
        /// </summary>

        if (arguments.length !== 0) throw Error.parameterCount();

        for(var i = this._controls.length -1; i > -1; i--)
        {
            delete this._controls[i];
        }

        Array.clear(this._controls);
        delete this._controls;

        delete this._container;
    },

    findControl : function (controlId)
    {
        /// <summary>
        /// Finds the specified control from the row control collection.
        /// </summary>
        /// <param name="controlId" type="String">
        /// The control ID without the naming container.
        /// </param>
        /// <returns domElement="true" mayBeNull="true">
        /// Returns the dom element from the control collection.
        /// </returns>

        var e = Function._validateParams(arguments, [{name: "controlId", type: String}]);
        if (e) throw e;

        var targetId = (this._namingContainer + '$' + controlId);
        var index = Array.indexOf(this._controls, targetId);

        if (index > -1)
        {
            return $get(targetId);
        }

        return null;
    },

    _addControl : function(childControl)
    {
        if ((childControl.id != null) && (childControl.id.length > 0))
        {
            var targetId = (this._namingContainer + '$' + childControl.id);

            if (Array.contains(this._controls, targetId))
            {
                throw Error.invalidOperation('Control of the same id already exists.');
            }

            childControl.id = targetId;
            Array.add(this._controls, childControl.id);
        }
    }
}

$ADC.GridViewRow.registerClass('AjaxDataControls.GridViewRow', null, Sys.IDisposable);


$ADC.GridViewRowEventArgs = function(row)
{
    /// <summary>
    /// Event arguments used when the GridView row is created or databound.
    /// </summary>
    /// <param name="item" type="AjaxDataControls.GridViewRow">
    /// The associated GridView row.
    /// </param>

    var e = Function._validateParams(arguments, [{name: 'row', type: $ADC.GridViewRow}]);
    if (e) throw e;

    $ADC.GridViewRowEventArgs.initializeBase(this);
    this._row = row;
}

$ADC.GridViewRowEventArgs.prototype =
{
    get_row : function()
    {
        /// <value type="AjaxDataControls.GridViewRow">
        /// The GridView row associated with this event.
        /// </value>

        if (arguments.length !== 0) throw Error.parameterCount();

        return this._row;
    }
}

$ADC.GridViewRowEventArgs.registerClass('AjaxDataControls.GridViewRowEventArgs', Sys.EventArgs);


$ADC.GridViewCommandEventArgs = function(commandName, commandArgument, commandSource, row)
{
    /// <summary>
    /// Event arguments used for the GridView command event.
    /// </summary>
    /// <param name="commandName" type="String">
    /// The associated command name.
    /// </param>
    /// <param name="commandArgument" type="Object">
    /// The associated command argument.
    /// </param>
    /// <param name="commandSource" domElement="true">
    /// The associated command source, usually the dom button which fires the command event.
    /// </param>
    /// <param name="item" type="AjaxDataControls.GridViewRow">
    /// The associated GridView row.
    /// </param>

    var e = Function._validateParams(arguments, [{name: 'commandName', type: String}, {name: 'commandArgument'}, {name: 'commandSource', type: Object}, {name: 'row', type: $ADC.GridViewRow}]);
    if (e) throw e;

    $ADC.GridViewCommandEventArgs.initializeBase(this);
    this._commandName = commandName;
    this._commandArgument = commandArgument;
    this._commandSource = commandSource;
    this._row = row;
}

$ADC.GridViewCommandEventArgs.prototype =
{
    get_commandName : function()
    {
        /// <value type="String">
        /// The associated command name.
        /// </value>

        if (arguments.length !== 0) throw Error.parameterCount();

        return this._commandName;
    },

    get_commandArgument : function()
    {
        /// <value type="Object">
        /// The associated command argument.
        /// </value>

        if (arguments.length !== 0) throw Error.parameterCount();

        return this._commandArgument;
    },

    get_commandSource : function()
    {
        /// <value domElement="true">
        /// The associated command source, usually the dom button which fires the command event.
        /// </value>

        if (arguments.length !== 0) throw Error.parameterCount();

        return this._commandSource;
    },

    get_row : function()
    {
        /// <value type="AjaxDataControls.GridViewRow">
        /// The associated GridView row.
        /// </value>

        if (arguments.length !== 0) throw Error.parameterCount();

        return this._row;
    }
}

$ADC.GridViewCommandEventArgs.registerClass('AjaxDataControls.GridViewCommandEventArgs', Sys.EventArgs);


$ADC.GridView = function(element)
{
    /// <summary>
    /// Displays the values of a data source in a table where each column represents a column and each row represents a record. The GridView control allows you to select, sort, and edit these items.
    /// </summary>
    /// <param name="element" domElement="true">
    /// The dom element where the GridView will be rendered.
    /// </param>

    this.SelectCommandName = 'select';
    this.EditCommandName = 'edit';
    this.UpdateCommandName = 'update';
    this.CancelCommandName = 'cancel';
    this.DeleteCommandName = 'delete';

    this._showHeader = true;
    this._showFooter = false;

    this._autoGenerateDeleteButton = false;
    this._autoGenerateEditButton = false;
    this._autoGenerateSelectButton = false;

    this._emptyDataTemplate = '';
    this._emptyDataText = '';

    this._sortColumn = '';
    this._sortOrder = $ADC.GridViewSortOrder.Ascending;

    this._sortOrderAscendingImageUrl = '';
    this._sortOrderDescendingImageUrl = '';

    this._headerStyle = null;
    this._rowStyle = null;
    this._alternatingRowStyle = null;
    this._footerStyle = null;
    this._selectedRowStyle = null;
    this._editRowStyle = null;
    this._emptyDataRowStyle = null;

    this._dataKeyName = null;
    this._dataKeys = new Array();

    this._columns = null;
    this._dataSource = null;
    this._hasBinded = false;
    this._rows = new Array();

    this._headerRow = null;
    this._footerRow = null;

    this._selectedIndex = -1;
    this._editIndex = -1;

    this._dragOpacity = 70;

    this._animate = true
    this._animationDuration = 0.2;
    this._animationFps = 20;
    this._animation = null;

    this._profileLoadedHandler = null;
    this._profileSavedHandler = null;

    $ADC.GridView.initializeBase(this, [element]);
}

$ADC.GridView.prototype =
{
    get_border : function()
    {
        /// <value type="Number" integer="true">
        /// The border of the control in pixels.
        /// </value>

        if (arguments.length !== 0) throw Error.parameterCount();

        return this.get_element().border;
    },

    set_border : function(value)
    {
        var e = Function._validateParams(arguments, [{name: 'value', type: Number}]);
        if (e) throw e;

        if (this.get_element().border != value)
        {
            this.get_element().border = value;
            this.raisePropertyChanged('border');
        }
    },

    get_cellPadding : function()
    {
        /// <value type="Number" integer="true">
        /// The amount of space (in pixels) between the contents of a cell and the cell's border.
        /// </value>

        if (arguments.length !== 0) throw Error.parameterCount();

        return this.get_element().cellPadding;
    },

    set_cellPadding : function(value)
    {
        /// <value type="Number" integer="true">
        /// The amount of space (in pixels) between cells.
        /// </value>

        var e = Function._validateParams(arguments, [{name: 'value', type: Number}]);
        if (e) throw e;

        if (this.get_element().cellPadding != value)
        {
            this.get_element().cellPadding = value;
            this.raisePropertyChanged('cellPadding');
        }
    },

    get_cellSpacing : function()
    {
        /// <value type="Number" integer="true">
        /// The amount of space (in pixels) between cells.
        /// </value>

        if (arguments.length !== 0) throw Error.parameterCount();

        return this.get_element().cellSpacing;
    },

    set_cellSpacing : function(value)
    {
        var e = Function._validateParams(arguments, [{name: 'value', type: Number}]);
        if (e) throw e;

        if (this.get_element().cellSpacing != value)
        {
            this.get_element().cellSpacing = value;
            this.raisePropertyChanged('cellSpacing');
        }
    },

    get_cssClass : function()
    {
        /// <value type="String">
        /// The associated css class name for this control.
        /// </value>

        if (arguments.length !== 0) throw Error.parameterCount();

        return this.get_element().className;
    },

    set_cssClass : function(value)
    {
        var e = Function._validateParams(arguments, [{name: 'value', type: String}]);
        if (e) throw e;

        var target = this.get_element();

        if (!Sys.UI.DomElement.containsCssClass(target, value))
        {
            Sys.UI.DomElement.addCssClass(target, value);
            this.raisePropertyChanged('cssClass');
        }
    },

    get_showHeader : function()
    {
        /// <value type="Boolean">
        /// Whether to show the GridView header.
        /// </value>

        if (arguments.length !== 0) throw Error.parameterCount();

        return this._showHeader;
    },

    set_showHeader : function(value)
    {
        var e = Function._validateParams(arguments, [{name: 'value', type: Boolean}]);
        if (e) throw e;

        if (this._showHeader != value)
        {
            this._showHeader = value;
            this.raisePropertyChanged('showHeader');
        }
    },

    get_showFooter : function()
    {
        /// <value type="Boolean">
        /// Whether to show the GridView footer.
        /// </value>

        if (arguments.length !== 0) throw Error.parameterCount();

        return this._showFooter;
    },

    set_showFooter : function(value)
    {
        var e = Function._validateParams(arguments, [{name: 'value', type: Boolean}]);
        if (e) throw e;

        if (this._showFooter != value)
        {
            this._showFooter = value;
            this.raisePropertyChanged('showFooter');
        }
    },

    get_autoGenerateDeleteButton : function()
    {
        /// <value type="Boolean">
        /// Whether the delete button is generated automatically at runtime.
        /// </value>

        if (arguments.length !== 0) throw Error.parameterCount();

        return this._autoGenerateDeleteButton;
    },

    set_autoGenerateDeleteButton : function(value)
    {
        var e = Function._validateParams(arguments, [{name: 'value', type: Boolean}]);
        if (e) throw e;

        if (this._autoGenerateDeleteButton != value)
        {
            this._autoGenerateDeleteButton = value;
            this.raisePropertyChanged('autoGenerateDeleteButton');
        }
    },

    get_autoGenerateEditButton : function()
    {
        /// <value type="Boolean">
        /// Whether the edit button is generated automatically at runtime.
        /// </value>

        if (arguments.length !== 0) throw Error.parameterCount();

        return this._autoGenerateEditButton;
    },

    set_autoGenerateEditButton : function(value)
    {
        var e = Function._validateParams(arguments, [{name: 'value', type: Boolean}]);
        if (e) throw e;

        if (this._autoGenerateEditButton != value)
        {
            this._autoGenerateEditButton = value;
            this.raisePropertyChanged('autoGenerateEditButton');
        }
    },

    get_autoGenerateSelectButton : function()
    {
        /// <value type="Boolean">
        /// Whether the select button is generated automatically at runtime.
        /// </value>

        if (arguments.length !== 0) throw Error.parameterCount();

        return this._autoGenerateSelectButton;
    },

    set_autoGenerateSelectButton : function(value)
    {
        var e = Function._validateParams(arguments, [{name: 'value', type: Boolean}]);
        if (e) throw e;

        if (this._autoGenerateSelectButton != value)
        {
            this._autoGenerateSelectButton = value;
            this.raisePropertyChanged('autoGenerateSelectButton');
        }
    },

    get_sortColumn : function()
    {
        /// <value type="String">
        /// The column used to sort the data source to which the GridView is binding.
        /// </value>

        if (arguments.length !== 0) throw Error.parameterCount();

        return this._sortColumn;
    },

    set_sortColumn : function(value)
    {
        var e = Function._validateParams(arguments, [{name: 'value', type: String}]);
        if (e) throw e;

        if (this._sortColumn != value)
        {
            this._sortColumn = value;
            this.raisePropertyChanged('sortColumn');
        }
    },

    get_sortOrder : function()
    {
        /// <value type="AjaxDataControls.GridViewSortOrder">
        /// The order in which to sort the column.
        /// </value>

        if (arguments.length !== 0) throw Error.parameterCount();

        return this._sortOrder;
    },

    set_sortOrder : function(value)
    {
        var e = Function._validateParams(arguments, [{name: 'value', type: $ADC.GridViewSortOrder}]);
        if (e) throw e;

        if (this._sortOrder != value)
        {
            this._sortOrder = value;
            this.raisePropertyChanged('sortOrder');
        }
    },

    get_sortOrderAscendingImageUrl : function()
    {
        /// <value type="String">
        /// The image that will be shown to indicate the ascending order.
        /// </value>

        if (arguments.length !== 0) throw Error.parameterCount();

        return this._sortOrderAscendingImageUrl;
    },

    set_sortOrderAscendingImageUrl : function(value)
    {
        var e = Function._validateParams(arguments, [{name: 'value', type: String}]);
        if (e) throw e;

        if (this._sortOrderAscendingImageUrl != value)
        {
            this._sortOrderAscendingImageUrl = value;
            this.raisePropertyChanged('sortOrderAscendingImageUrl');
        }
    },

    get_sortOrderDescendingImageUrl : function()
    {
        /// <value type="String">
        /// The image that will be shown to indicate the descending order.
        /// </value>

        if (arguments.length !== 0) throw Error.parameterCount();

        return this._sortOrderDescendingImageUrl;
    },

    set_sortOrderDescendingImageUrl : function(value)
    {
        var e = Function._validateParams(arguments, [{name: 'value', type: String}]);
        if (e) throw e;

        if (this._sortOrderDescendingImageUrl != value)
        {
            this._sortOrderDescendingImageUrl = value;
            this.raisePropertyChanged('sortOrderDescendingImageUrl');
        }
    },

    get_headerStyle : function()
    {
        /// <value type="AjaxDataControls.TableItemStyle">
        /// The the style of the header row in a GridView control.
        /// </value>

        if (arguments.length !== 0) throw Error.parameterCount();

        return this._headerStyle;
    },

    set_headerStyle : function(value)
    {
        var e = Function._validateParams(arguments, [{name: 'value', type: $ADC.TableItemStyle}]);
        if (e) throw e;

        if (this._headerStyle != value)
        {
            this._headerStyle = value;
            this.raisePropertyChanged('headerStyle');
        }
    },

    get_rowStyle : function()
    {
        /// <value type="AjaxDataControls.TableItemStyle">
        /// The style to set the appearance of the data rows in a GridView control. 
        /// </value>

        if (arguments.length !== 0) throw Error.parameterCount();

        return this._rowStyle;
    },

    set_rowStyle : function(value)
    {
        var e = Function._validateParams(arguments, [{name: 'value', type: $ADC.TableItemStyle}]);
        if (e) throw e;

        if (this._rowStyle != value)
        {
            this._rowStyle = value;
            this.raisePropertyChanged('rowStyle');
        }
    },

    get_alternatingRowStyle : function()
    {
        /// <value type="AjaxDataControls.TableItemStyle">
        /// The style to set the appearance of the alternating data rows in a GridView control. 
        /// </value>

        if (arguments.length !== 0) throw Error.parameterCount();

        return this._alternatingRowStyle;
    },

    set_alternatingRowStyle : function(value)
    {
        var e = Function._validateParams(arguments, [{name: 'value', type: $ADC.TableItemStyle}]);
        if (e) throw e;

        if (this._alternatingRowStyle != value)
        {
            this._alternatingRowStyle = value;
            this.raisePropertyChanged('alternatingRowStyle');
        }
    },

    get_footerStyle : function()
    {
        /// <value type="AjaxDataControls.TableItemStyle">
        /// The the style of the footer row in a GridView control.
        /// </value>

        if (arguments.length !== 0) throw Error.parameterCount();

        return this._footerStyle;
    },

    set_footerStyle : function(value)
    {
        var e = Function._validateParams(arguments, [{name: 'value', type: $ADC.TableItemStyle}]);
        if (e) throw e;

        if (this._footerStyle != value)
        {
            this._footerStyle = value;
            this.raisePropertyChanged('footerStyle');
        }
    },

    get_selectedRowStyle : function()
    {
        /// <value type="AjaxDataControls.TableItemStyle">
        /// The the style of the selected row in a GridView control.
        /// </value>

        if (arguments.length !== 0) throw Error.parameterCount();

        return this._selectedRowStyle;
    },

    set_selectedRowStyle : function(value)
    {
        var e = Function._validateParams(arguments, [{name: 'value', type: $ADC.TableItemStyle}]);
        if (e) throw e;

        if (this._selectedRowStyle != value)
        {
            this._selectedRowStyle = value;
            this.raisePropertyChanged('selectedRowStyle');
        }
    },

    get_editRowStyle : function()
    {
        /// <value type="AjaxDataControls.TableItemStyle">
        /// The the style of the edit row in a GridView control.
        /// </value>

        if (arguments.length !== 0) throw Error.parameterCount();

        return this._editRowStyle;
    },

    set_editRowStyle : function(value)
    {
        var e = Function._validateParams(arguments, [{name: 'value', type: $ADC.TableItemStyle}]);
        if (e) throw e;

        if (this._editRowStyle != value)
        {
            this._editRowStyle = value;
            this.raisePropertyChanged('editRowStyle');
        }
    },

    get_emptyDataRowStyle : function()
    {
        /// <value type="AjaxDataControls.TableItemStyle">
        /// The the style of the empty row in a GridView control.
        /// </value>

        if (arguments.length !== 0) throw Error.parameterCount();

        return this._emptyDataRowStyle;
    },

    set_emptyDataRowStyle : function(value)
    {
        var e = Function._validateParams(arguments, [{name: 'value',  type: $ADC.TableItemStyle}]);
        if (e) throw e;

        if (this._emptyDataRowStyle != value)
        {
            this._emptyDataRowStyle = value;
            this.raisePropertyChanged('emptyDataRowStyle');
        }
    },

    get_dragOpacity : function()
    {
        /// <value type="Number" integer="true">
        /// The opacity of the drag visual.
        /// </value>

        if (arguments.length !== 0) throw Error.parameterCount();

        return this._dragOpacity;
    },

    set_dragOpacity : function(value)
    {
        var e = Function._validateParams(arguments, [{name: 'value', type: Number}]);
        if (e) throw e;

        if ((value < 0) || (value > 10))
        {
            throw Error.argument('value','Drag opacity must be 0-100.');
        }

        if (this._dragOpacity != value)
        {
            this._dragOpacity = value;
            this.raisePropertyChanged('dragOpacity');
        }
    },

    get_animate : function()
    {
        /// <value type="Boolean">
        /// Whether the control animate fade in effect when databinding is complete.
        /// </value>

        if (arguments.length !== 0) throw Error.parameterCount();

        return this._animate;
    },

    set_animate : function(value)
    {
        var e = Function._validateParams(arguments, [{name: 'value', type: Boolean}]);
        if (e) throw e;

        if (this._animate != value)
        {
            this._animate = value;
            this.raisePropertyChanged('animate');
        }
    },

    get_animationDuration : function()
    {
        /// <value type="Number">
        /// The animation duration in seconds.
        /// </value>

        if (arguments.length !== 0) throw Error.parameterCount();

        return this._animationDuration;
    },

    set_animationDuration : function(value)
    {
        var e = Function._validateParams(arguments, [{name: 'value', type: Number}]);
        if (e) throw e;

        if (this._animationDuration != value)
        {
            this._animationDuration = value;
            this.raisePropertyChanged('animationDuration');
        }
    },

    get_animationFps : function()
    {
        /// <value type="Number" integer="true">
        /// The animation frames per second.
        /// </value>

        if (arguments.length !== 0) throw Error.parameterCount();

        return this._animationFps;
    },

    set_animationFps : function(value)
    {
        var e = Function._validateParams(arguments, [{name: 'value', type: Number}]);
        if (e) throw e;

        if (this._animationFps != value)
        {
            this._animationFps = value;
            this.raisePropertyChanged('animationFps');
        }
    },

    get_dataKeyName : function()
    {
        /// <value type="String">
        /// The name of the field in the data source which is used to populate the dataKeys Property.
        /// </value>

        if (arguments.length !== 0) throw Error.parameterCount();

        return this._dataKeyName;
    },

    set_dataKeyName : function(value)
    {
        var e = Function._validateParams(arguments, [{name: 'value', type: String}]);
        if (e) throw e;

        if (this._dataKeyName != value)
        {
            this._dataKeyName = value;
            this.raisePropertyChanged('dataKeyName');
        }
    },

    get_dataKeys : function()
    {
        /// <value type="Array" mayBeNull="true">
        /// Stores the key values of each record in a DataList control. This allows you to store the key field with a GridView control without displaying it in the control. This collection is automatically filled with the values from the field specified by the DataKeyName property.
        /// </value>

        if (arguments.length !== 0) throw Error.parameterCount();

        return this._dataKeys;
    },

    get_columns : function()
    {
        /// <value type="Array" mayBeNull="true" elementType="AjaxDataControls.GridViewBaseColumn">
        /// The set of columns to be shown in the control.
        /// </value>

        if (arguments.length !== 0) throw Error.parameterCount();

        return this._columns;
    },

    set_columns : function(value)
    {
        var e = Function._validateParams(arguments, [{name: 'value', type: Array, elementType: $ADC.GridViewBaseColumn, elementMayBeNull: false}]);
        if (e) throw e;

        if (this._columns != value)
        {
            this._columns = value;
            this.raisePropertyChanged('columns');
        }
    },

    get_selectedIndex : function()
    {
        /// <value type="Number" integer="true">
        /// The index of the currently selected row.
        /// </value>

        if (arguments.length !== 0) throw Error.parameterCount();

        return this._selectedIndex;
    },

    set_selectedIndex : function(value)
    {
        var e = Function._validateParams(arguments, [{name: 'value', type: Number}]);
        if (e) throw e;

        if (this._selectedIndex != value)
        {
            this._select(value)
        }
    },

    get_selectedRow : function()
    {
        /// <value type="AjaxDataControls.GridViewRow" mayBeNull="true">
        /// The selected row of the GridView Control.
        /// </value>

        if (arguments.length !== 0) throw Error.parameterCount();

        if (this._selectedIndex < 0)
        {
            return null;
        }

        if (this._rows.length > 0)
        {
            return this._rows()[this._selectedIndex];
        }
    },

    get_selectedValue : function()
    {
        /// <value type="Object" mayBeNull="true">
        /// The value of the selected row dataKeyName.
        /// </value>

        if (arguments.length !== 0) throw Error.parameterCount();

        if ((this.get_dataSource() == null) || (this.get_dataSource().length == 0))
        {
            return null;
        }

        var dataKeyName = this.get_dataKeyName();

        if ((dataKeyName == null) || (dataKeyName.length == 0))
        {
            return null;
        }

        if (this.get_selectedIndex() > -1)
        {
            return this._dataKeys[this.get_selectedIndex()];
        }

        return null;
    },

    get_editIndex : function()
    {
        /// <value type="Number" integer="true">
        /// The index of the currently editing row.
        /// </value>

        if (arguments.length !== 0) throw Error.parameterCount();

        return this._editIndex;
    },

    set_editIndex : function(value)
    {
        var e = Function._validateParams(arguments, [{name: 'value', type: Number}]);
        if (e) throw e;

        if (this._editIndex != value)
        {
            this._editIndex = value;
            this.raisePropertyChanged('editIndex');

            if (this._hasBinded)
            {
                this._internalDataBind(false);
            }
        }
    },

    get_editRow : function()
    {
        /// <value type="AjaxDataControls.GridViewRow" mayBeNull="true">
        /// The edit row of the GridView Control.
        /// </value>

        if (arguments.length !== 0) throw Error.parameterCount();

        if (this._editIndex < 0)
        {
            return null;
        }

        if (this._rows.length > 0)
        {
            return this._rows[this._editIndex];
        }

        return null;
    },

    get_dataSource : function()
    {
        /// <value type="Array" mayBeNull="true">
        /// The data source that provides data for populating the GridView.
        /// </value>

        if (arguments.length !== 0) throw Error.parameterCount();

        return this._dataSource;
    },

    set_dataSource : function(value)
    {
        var e = Function._validateParams(arguments, [{name: 'value', type: Array, mayBeNull:true}]);
        if (e) throw e;

        if (this._dataSource != value)
        {
            this._dataSource = value;
            this._hasBinded = false;
            this.raisePropertyChanged('dataSource');
        }
    },

    get_headerRow : function()
    {
        /// <value type="AjaxDataControls.GridViewRow" mayBeNull="true">
        /// The header row of the GridView Control.
        /// </value>

        if (arguments.length !== 0) throw Error.parameterCount();

        return this._headerRow;
    },

    get_rows : function()
    {
        /// <value type="Array" mayBeNull="true" elementType="AjaxDataControls.GridViewRow">
        /// The collection of GridViewRow objects in the GridView control.
        /// </value>

        if (arguments.length !== 0) throw Error.parameterCount();

        return this._rows;
    },

    get_footerRow : function()
    {
        /// <value type="AjaxDataControls.GridViewRow" mayBeNull="true">
        /// The footer row of the GridView Control.
        /// </value>

        if (arguments.length !== 0) throw Error.parameterCount();

        return this._footerRow;
    },

    get_emptyDataTemplate : function()
    {
        /// <value type="String" mayBeNull="true">
        /// The empty data row template which is used when a GridView control is bound to a data source that does not contain any records.
        /// </value>

        if (arguments.length !== 0) throw Error.parameterCount();

        return this._emptyDataTemplate;
    },

    set_emptyDataTemplate : function(value)
    {
        var e = Function._validateParams(arguments, [{name: 'value', type: String}]);
        if (e) throw e;

        if (this._emptyDataTemplate != value)
        {
            this._emptyDataTemplate = value;
            this.raisePropertyChanged('emptyDataTemplate');
        }
    },

    get_emptyDataText : function()
    {
        /// <value type="String" mayBeNull="true">
        /// The text shown in the empty data row if no EmptyDataTemplate is defined.
        /// </value>

        if (arguments.length !== 0) throw Error.parameterCount();

        return this._emptyDataText;
    },

    set_emptyDataText : function(value)
    {
        var e = Function._validateParams(arguments, [{name: 'value', type: String}]);
        if (e) throw e;

        if (this._dataSource != value)
        {
            this._emptyDataText = value;
            this.raisePropertyChanged('emptyDataText');
        }
    },

    initialize : function()
    {
        /// <summary>
        /// Initialize the control.
        /// </summary>

        $ADC.GridView.callBaseMethod(this, 'initialize');
    },

    dispose : function()
    {
        /// <summary>
        /// Dispose the control.
        /// </summary>

        if (this._profileLoadedHandler != null)
        {
            delete this._profileLoadedHandler;
        }

        if (this._profileLoadedHandler != null)
        {
            delete this._profileSavedHandler;
        }

        if (this._animation != null)
        {
            this._animation.dispose();
        }

        delete this._animation;

        if (this._headerRow != null)
        {
            this._headerRow.dispose();
        }

        delete this._headerRow;

        if (this._footerRow != null)
        {
            this._footerRow.dispose();
        }

        delete this._footerRow;

        this._cleanupRows();
        delete this._rows;

        Array.clear(this._dataKeys);
        delete this._dataKeys;

        if (this._columns != null)
        {
            Array.clear(this._columns);
        }

        delete this._columns;

        delete this._dataSource;

        delete this._headerStyle;
        delete this._rowStyle;
        delete this._alternatingRowStyle;
        delete this._footerStyle;
        delete this._selectedRowStyle;
        delete this._editRowStyle;
        delete this._emptyDataRowStyle;

        $ADC.GridView.callBaseMethod(this, 'dispose');
    },

    dataBind : function()
    {
        /// <summary>
        /// Binds the data source to the DataList control.
        /// </summary>

        if (arguments.length !== 0) throw Error.parameterCount();
        this._internalDataBind(true);
    },

    getColumnIndexByColumnID : function(columnID)
    {
        /// <summary>
        /// Returns the Index of the specified columnID.
        /// </summary>
        /// <param name="columnID" type="Number" integer="true">
        /// The ColumnID of the column which is uniquely identify it among the other columns.
        /// </param>
        /// <returns type="Number" integer="true">Returns the Index if found otherwise -1.</returns>

        //Argument validation
        var e = Function._validateParams(arguments, [{name: 'columnID', type: Number}]);
        if (e) throw e;

        var columns = this.get_columns();

        if (columns != null)
        {
            var columnLength = columns.length;
            
            if (columnLength > 0)
            {
                for(var i = 0; i < columnLength; i++)
                {
                    if (columns[i].get_columnID() == columnID)
                    {
                        return i;
                    }
                }
            }
        }

        return -1;
    },

    getColumnIndexByHeaderText : function(headerText)
    {
        /// <summary>
        /// Returns the Index of the specified column headerText, if the same header text is used for more than one column then only returns the first index.
        /// </summary>
        /// <param name="headerText" type="String">
        /// The header text of the column.
        /// </param>
        /// <returns type="Number" integer="true">Returns the Index if found otherwise -1.</returns>

        //Argument validation
        var e = Function._validateParams(arguments, [{name: 'headerText', type: String}]);
        if (e) throw e;

        //Since we are supporing drag n drop it is not possible
        //that the index of the column will be static,
        //that is way we need a helper function which will
        //resolve the proper index based upon the header text.
        //****Warning: if Same header is used for more than one column
        //it will only return the first

        var columns = this.get_columns();

        if (columns != null)
        {
            var columnLength = columns.length;
            
            if (columnLength > 0)
            {
                for(var i = 0; i < columnLength; i++)
                {
                    if (columns[i].get_headerText() == headerText)
                    {
                        return i;
                    }
                }
            }
        }

        return -1;
    },

    loadColumnsFromProfile : function(propertyName)
    {
        /// <summary>
        /// Loads the column sequence from the specified property name of the ASP.net Profile. The Ajax profile Service must be configured to call this method.
        //  It fires the columnsLoadedFromProfile event after loading the columns.
        /// </summary>
        /// <param name="propertyName" type="String">
        /// The name of the property where the column sequence is stored.
        /// </param>

        //Argument validation
        var e = Function._validateParams(arguments, [{name: 'propertyName', type: String}]);
        if (e) throw e;

        if  ((typeof(Sys.Services) == 'undefined') || (typeof(Sys.Services.ProfileService) === 'undefined'))
        {
            throw Error.invalidOperation('ProfileService must be configured before calling this method.');
        }

        this._profileLoadedHandler = Function.createDelegate(this, this._onProfileLoaded);
        Sys.Services.ProfileService.load([propertyName], this._profileLoadedHandler, null, propertyName);
    },

    saveColumnsToProfile : function(propertyName)
    {
        /// <summary>
        /// Saves the column sequence in the specified property name of the ASP.net Profile. The Ajax profile Service must be configured to call this method.
        //  It fires the columnsSavedToProfile event after saving the columns. The consumer of this control required to call this method
        /// in the columnDropped event to persist the column sequence.
        /// </summary>
        /// <param name="propertyName" type="String">
        /// The name of the property where the column sequence will be stored.
        /// </param>

        var e = Function._validateParams(arguments, [{name: 'propertyName', type: String}]);
        if (e) throw e;

        if  ((typeof(Sys.Services) == 'undefined') || (typeof(Sys.Services.ProfileService) === 'undefined'))
        {
            throw Error.invalidOperation('ProfileService must be configured before calling this method.');
        }

        var columns = this.get_columns();
        var profileColumns = new Array();

        for(var i = 0; i < columns.length; i++)
        {
            profileColumns.push({id: columns[i].get_columnID(), idx: i});
        }

        var serializedColumns = Sys.Serialization.JavaScriptSerializer.serialize(profileColumns);

        if (serializedColumns)
        {
            if (serializedColumns.length > 0)
            {
                this._profileSavedHandler = Function.createDelegate(this, this._onProfileSaved);

                Sys.Services.ProfileService.properties[propertyName] = serializedColumns;
                Sys.Services.ProfileService.save([propertyName], this._profileSavedHandler);
            }
        }
    },

    add_columnsLoadedFromProfile : function(handler)
    {
        /// <summary>
        /// This event is raised when the columns sequence are loaded form the Ajax Profile Service.
        /// </summary>
        /// <param name="handler" type="Function">
        /// Event handler
        /// </param>

        var e = Function._validateParams(arguments, [{name: 'handler', type: Function}]);
        if (e) throw e;

        this.get_events().addHandler('columnsLoadedFromProfile', handler);
    },

    remove_columnsLoadedFromProfile : function(handler)
    {
        var e = Function._validateParams(arguments, [{name: 'handler', type: Function}]);
        if (e) throw e;

        this.get_events().removeHandler('columnsLoadedFromProfile', handler);
    },

    add_columnsSavedToProfile : function(handler)
    {
        /// <summary>
        /// This event is raised when the columns sequence are saved in the Ajax Profile Service.
        /// </summary>
        /// <param name="handler" type="Function">
        /// Event handler
        /// </param>

        var e = Function._validateParams(arguments, [{name: 'handler', type: Function}]);
        if (e) throw e;

        this.get_events().addHandler('columnsSavedToProfile', handler);
    },

    remove_columnsSavedToProfile : function(handler)
    {
        var e = Function._validateParams(arguments, [{name: 'handler', type: Function}]);
        if (e) throw e;

        this.get_events().removeHandler('columnsSavedToProfile', handler);
    },

    add_columnDragStart : function(handler)
    {
        /// <summary>
        /// This event is raised when the user starts dragging of a column.
        /// </summary>
        /// <param name="handler" type="Function">
        /// Event handler
        /// </param>

        var e = Function._validateParams(arguments, [{name: 'handler', type: Function}]);
        if (e) throw e;

        this.get_events().addHandler('columnDragStart', handler);
    },

    remove_columnDragStart : function(handler)
    {
        var e = Function._validateParams(arguments, [{name: 'handler', type: Function}]);
        if (e) throw e;

        this.get_events().removeHandler('columnDragStart', handler);
    },

    add_columnDropped : function(handler)
    {
        /// <summary>
        /// This event is raised when the user drops a column and the drop is sucessfull.
        /// </summary>
        /// <param name="handler" type="Function">
        /// Event handler
        /// </param>

        var e = Function._validateParams(arguments, [{name: 'handler', type: Function}]);
        if (e) throw e;

        this.get_events().addHandler('columnDropped', handler);
    },

    remove_columnDropped : function(handler)
    {
        var e = Function._validateParams(arguments, [{name: 'handler', type: Function}]);
        if (e) throw e;

        this.get_events().removeHandler('columnDropped', handler);
    },

    add_sortCommand : function(handler)
    {
        /// <summary>
        /// This event is raised when a column header is clicked to sort.
        /// </summary>
        /// <param name="handler" type="Function">
        /// Event handler
        /// </param>

        var e = Function._validateParams(arguments, [{name: 'handler', type: Function}]);
        if (e) throw e;

        this.get_events().addHandler('sortCommand', handler);
    },

    remove_sortCommand : function(handler)
    {
        var e = Function._validateParams(arguments, [{name: 'handler', type: Function}]);
        if (e) throw e;

        this.get_events().removeHandler('sortCommand', handler);
    },

    add_selectedIndexChanged : function(handler)
    {
        /// <summary>
        /// This event is raised when a row is selected with a Select Command.
        /// </summary>
        /// <param name="handler" type="Function">
        /// Event handler
        /// </param>

        var e = Function._validateParams(arguments, [{name: 'handler', type: Function}]);
        if (e) throw e;

        this.get_events().addHandler('selectedIndexChanged', handler);
    },

    remove_selectedIndexChanged : function(handler)
    {
        var e = Function._validateParams(arguments, [{name: 'handler', type: Function}]);
        if (e) throw e;

        this.get_events().removeHandler('selectedIndexChanged', handler);
    },

    add_editCommand : function(handler)
    {
        /// <summary>
        /// This event is raised when the Edit button is clicked for a row in the GridView control.
        /// </summary>
        /// <param name="handler" type="Function">
        /// Event handler
        /// </param>

        var e = Function._validateParams(arguments, [{name: 'handler', type: Function}]);
        if (e) throw e;

        this.get_events().addHandler('editCommand', handler);
    },

    remove_editCommand : function(handler)
    {
        var e = Function._validateParams(arguments, [{name: 'handler', type: Function}]);
        if (e) throw e;

        this.get_events().removeHandler('editCommand', handler);
    },

    add_updateCommand : function(handler)
    {
        /// <summary>
        /// This event is raised when the Update button is clicked for a row in the GridView control.
        /// </summary>
        /// <param name="handler" type="Function">
        /// Event handler
        /// </param>

        var e = Function._validateParams(arguments, [{name: 'handler', type: Function}]);
        if (e) throw e;

        this.get_events().addHandler('updateCommand', handler);
    },

    remove_updateCommand : function(handler)
    {
        var e = Function._validateParams(arguments, [{name: 'handler', type: Function}]);
        if (e) throw e;

        this.get_events().removeHandler('updateCommand', handler);
    },

    add_cancelCommand : function(handler)
    {
        /// <summary>
        /// This event is raised when the Cancel button is clicked for a row in the GridView control.
        /// </summary>
        /// <param name="handler" type="Function">
        /// Event handler
        /// </param>

        var e = Function._validateParams(arguments, [{name: 'handler', type: Function}]);
        if (e) throw e;

        this.get_events().addHandler('cancelCommand', handler);
    },

    remove_cancelCommand : function(handler)
    {
        var e = Function._validateParams(arguments, [{name: 'handler', type: Function}]);
        if (e) throw e;

        this.get_events().removeHandler('cancelCommand', handler);
    },

    add_deleteCommand : function(handler)
    {
        /// <summary>
        /// This event is raised when the Delete button is clicked for a row in the GridView control.
        /// </summary>
        /// <param name="handler" type="Function">
        /// Event handler
        /// </param>

        var e = Function._validateParams(arguments, [{name: 'handler', type: Function}]);
        if (e) throw e;

        this.get_events().addHandler('deleteCommand', handler);
    },

    remove_deleteCommand : function(handler)
    {
        var e = Function._validateParams(arguments, [{name: 'handler', type: Function}]);
        if (e) throw e;

        this.get_events().removeHandler('deleteCommand', handler);
    },

    add_rowCommand : function(handler)
    {
        /// <summary>
        /// This event is raised when a button which has associated commandName is clicked in the GridView row.
        /// </summary>
        /// <param name="handler" type="Function">
        /// Event handler
        /// </param>

        var e = Function._validateParams(arguments, [{name: 'handler', type: Function}]);
        if (e) throw e;

        this.get_events().addHandler('rowCommand', handler);
    },

    remove_rowCommand : function(handler)
    {
        var e = Function._validateParams(arguments, [{name: 'handler', type: Function}]);
        if (e) throw e;

        this.get_events().removeHandler('rowCommand', handler);
    },

    add_rowCreated : function(handler)
    {
        /// <summary>
        /// This event is raised when arow in the GridView control is created.
        /// </summary>
        /// <param name="handler" type="Function">
        /// Event handler
        /// </param>

        var e = Function._validateParams(arguments, [{name: 'handler', type: Function}]);
        if (e) throw e;

        this.get_events().addHandler('rowCreated', handler);
    },

    remove_rowCreated : function(handler)
    {
        var e = Function._validateParams(arguments, [{name: 'handler', type: Function}]);
        if (e) throw e;

        this.get_events().removeHandler('rowCreated', handler);
    },

    add_rowDataBound : function(handler)
    {
        /// <summary>
        /// This event is raised when a row in the GridView control is going to be data-bound.
        /// </summary>
        /// <param name="handler" type="Function">
        /// Event handler
        /// </param>

        var e = Function._validateParams(arguments, [{name: 'handler', type: Function}]);
        if (e) throw e;

        this.get_events().addHandler('rowDataBound', handler);
    },

    remove_rowDataBound : function(handler)
    {
        var e = Function._validateParams(arguments, [{name: 'handler', type: Function}]);
        if (e) throw e;

        this.get_events().removeHandler('rowDataBound', handler);
    },

    _raiseColumnDragStart : function(column)
    {
        var handler = this.get_events().getHandler('columnDragStart');

        if (handler)
        {
            handler(this, new $ADC.GridViewColumnDragStartEventArgs(column));
        }
    },

    _raiseColumnDropped : function(column, oldIndex, newIndex)
    {
        var handler = this.get_events().getHandler('columnDropped');

        if (handler)
        {
            handler(this, new $ADC.GridViewColumnDroppedEventArgs(column, oldIndex, newIndex));
        }
    },

    _raiseSort : function(e, context)
    {
        var handler = context.sender.get_events().getHandler('sortCommand');

        if (handler)
        {
            handler(context.sender, new $ADC.GridViewSortCommandEventArgs(context.sortColumn, context.sortOrder));
        }
    },

    _raiseCommand : function(e, context)
    {
        var commandName = '';
        var commandArgument = '';

        if (e.target.commandName)
        {
            commandName = e.target.commandName;
        }
        else
        {
            var commandNameAttribute = e.target.attributes['commandName'];

            if (commandNameAttribute)
            {
                if (commandNameAttribute.value)
                {
                    commandName = commandNameAttribute.value;
                }
                else if (commandNameAttribute.nodeValue)
                {
                    commandName = commandNameAttribute.nodeValue;
                }
            }
        }

        if (e.target.commandArgument)
        {
            commandArgument = e.target.commandArgument;
        }
        else
        {
            var commandArgumentAttribute = e.target.attributes['commandArgument'];

            if (commandArgumentAttribute)
            {
                if (commandArgumentAttribute.value)
                {
                    commandArgument = commandArgumentAttribute.value;
                }
                else if (commandArgumentAttribute.nodeValue)
                {
                    commandArgument = commandArgumentAttribute.nodeValue;
                }
            }
        }

        if ((commandName.length > 0) && (context.row.get_isDataRowType()))
        {
            var handler;

            var handler;

            if (commandName === context.sender.SelectCommandName)
            {
                context.sender._select(context.row.get_rowIndex());
            }
            if (commandName === context.sender.EditCommandName)
            {
                handler = context.sender.get_events().getHandler('editCommand');
            }
            else if (commandName === context.sender.UpdateCommandName)
            {
                handler = context.sender.get_events().getHandler('updateCommand');
            }
            else if (commandName === context.sender.CancelCommandName)
            {
                handler = context.sender.get_events().getHandler('cancelCommand');
            }
            else if (commandName === context.sender.DeleteCommandName)
            {
                handler = context.sender.get_events().getHandler('deleteCommand');
            }

            if (handler)
            {
                handler(context.sender, new $ADC.GridViewCommandEventArgs(commandName, commandArgument, e.target, context.row));
            }

            handler = context.sender.get_events().getHandler('rowCommand');

            if (handler)
            {
                handler(context.sender, new $ADC.GridViewCommandEventArgs(commandName, commandArgument, e.target, context.row));
            }
        }
    },

    _internalDataBind : function(animate)
    {
        var table = this.get_element(); 
        table.style.visibility = 'hidden';

        if (this._headerRow != null)
        {
            this._headerRow.dispose();
            this._headerRow = null;
        }

        if (this._footerRow != null)
        {
            this._footerRow.dispose();
            this._footerRow = null;
        }

        $ADC.Util.clearContent(table);
        this._cleanupRows();
        Array.clear(this._dataKeys);

        var dataSource = this.get_dataSource();
        var tBody;

        if ((dataSource == null) || (dataSource.length == 0))
        {
            var trEmpty;
            var tdEmpty;

            if (!$ADC.Util.isEmptyString(this.get_emptyDataTemplate()))
            {
                tBody = document.createElement('tbody');
                table.appendChild(tBody);

                trEmpty = document.createElement('tr');
                tBody.appendChild(trEmpty);

                tdEmpty = document.createElement('td');
                trEmpty.appendChild(tdEmpty);

                tdEmpty.innerHTML = this.get_emptyDataTemplate();

                if (this.get_emptyDataRowStyle() != null)
                {
                    this.get_emptyDataRowStyle().apply(trEmpty);
                    this.get_emptyDataRowStyle().apply(tdEmpty);
                }
            }
            else if (!$ADC.Util.isEmptyString(this.get_emptyDataText()))
            {
                tBody = document.createElement('tbody');
                table.appendChild(tBody);

                trEmpty = document.createElement('tr');
                tBody.appendChild(trEmpty);

                tdEmpty = document.createElement('td');
                trEmpty.appendChild(tdEmpty);
                tdEmpty.style.textAlign = 'left';

                tdEmpty.appendChild(document.createTextNode(this.get_emptyDataText()));
            }

            table.style.visibility = 'visible';
            return;
        }

        var dataKeyName = this.get_dataKeyName();
        var hasDataKeyName = false;
        var dataRow;

        if (!$ADC.Util.isEmptyString(dataKeyName))
        {
            hasDataKeyName = true;

            dataRow = dataSource[0];

            var exists = false;

            //We can iterate it since all the JavaScript object is a Dictionary
            for(var property in dataRow)
            {
                if (!property.startsWith('__')) // Excluding the Ajax Framework Properties
                {
                    if (property == dataKeyName)
                    {
                        exists = true;
                        break;
                    }
                }
            }

            if (!exists)
            {
                //DataKeyName does not exist, so raise exception
                throw Error.invalidOperation('Specified dataKeyName does not exists in dataSource.');
            }
        }

        var column;
        var i = 0;

        if ((this._columns == null) || (this._columns.length == 0))
        {
            //Columns collection has not been specified, so we have to
            //discover it from the datasource, this is same as GridView AutoGenerateColumn = True
            this._columns = new Array();
            dataRow = dataSource[0];

            for(var property in dataRow)
            {
                if (!property.startsWith('__')) // Excluding the Ajax Framework Properties
                {
                    column = new $ADC.GridViewBoundColumn();

                    column.set_headerText(property);
                    column.set_dataField(property);
                    column.set_allowDragAndDrop(false);

                    Array.add(this._columns, column);
                    column.set_columnID(this._columns.length);
                }
            }
        }

        if ((this.get_autoGenerateDeleteButton()) || (this.get_autoGenerateEditButton()) || (this.get_autoGenerateSelectButton()))
        {
            column = new $ADC.GridViewCommandColumn();

            column.set_buttonType($ADC.GridViewColumnButtonType.Button);
            column.set_showDeleteButton(this.get_autoGenerateDeleteButton());
            column.set_showEditButton(this.get_autoGenerateEditButton());
            column.set_showCancelButton(this.get_autoGenerateEditButton());
            column.set_showSelectButton(this.get_autoGenerateSelectButton());

            Array.insert(this._columns, 0, column);
        }

        var columnsLength = this._columns.length;

        //Setting the owner and releasing previous resources which is associated with each column
        for(i = 0; i < columnsLength; i++)
        {
            this._columns[i].set_owner(this);
            this._columns[i].releaseResource();
        }

        var showHeader = this.get_showHeader();

        var allowDragAndDrop = false;

        if (showHeader == true)
        {
            for(i = 0; i < columnsLength; i++)
            {
                if (this._columns[i].get_allowDragAndDrop() === true)
                {
                    allowDragAndDrop = true;
                    break;
                }
            }
        }

        var thead = document.createElement('thead');
        table.appendChild(thead);

        var trHead = document.createElement('tr');
        thead.appendChild(trHead);

        var namingContainer;

        namingContainer = this._getNamingContainer($ADC.GridViewRowType.Header, -1);
        this._headerRow = new $ADC.GridViewRow(namingContainer, trHead, -1, $ADC.GridViewRowType.Header, null);

        if (this.get_headerStyle() != null)
        {
            this.get_headerStyle().apply(trHead);
        }

        var th;

        if (showHeader == true)
        {
            for(i = 0; i < columnsLength; i++)
            {
                column = this._columns[i];

                if (column.get_visible() == true)
                {
                    th = document.createElement('th');
                    trHead.appendChild(th);

                    column.set_headerContainer(th);
                    column.renderHeader(this._headerRow);
                }
            }
        }

        var handler;

        handler = this.get_events().getHandler('rowCreated');

        if (handler)
        {
            handler(this, new $ADC.GridViewRowEventArgs(this._headerRow));
        }

        handler = this.get_events().getHandler('rowDataBound');

        if (handler)
        {
            handler(this, new $ADC.GridViewRowEventArgs(this._headerRow));
        }

        var tBody = document.createElement('tbody');
        table.appendChild(tBody);

        var tr;
        var td;
        var dataLength = dataSource.length;

        var rowType;
        var style;
        var row;
        var isAlt = false;

        var rowStyle = this.get_rowStyle();
        var alternatingRowStyle = this.get_alternatingRowStyle();
        var selectedRowStyle = this.get_selectedRowStyle();
        var editRowStyle = this.get_editRowStyle();

        for(i = 0; i < dataLength; i++)
        {
            dataRow = dataSource[i];

            if (hasDataKeyName)
            {
                Array.add(this._dataKeys, dataRow[dataKeyName]);
            }

            tr = document.createElement('tr');
            tBody.appendChild(tr);

            rowType = $ADC.GridViewRowType.Row;
            style = rowStyle;

            if (isAlt)
            {
                rowType = $ADC.GridViewRowType.AlternatingRow;

                if (alternatingRowStyle != null)
                {
                    style = alternatingRowStyle;
                }
            }

            if (this._selectedIndex == i)
            {
                rowType = $ADC.GridViewRowType.SelectedRow;

                if (selectedRowStyle != null)
                {
                    style = selectedRowStyle;
                }
            }
            else if (this._editIndex == i)
            {
                rowType = $ADC.GridViewRowType.EditRow;

                if (editRowStyle != null)
                {
                    style = editRowStyle;
                }
            }

            namingContainer = this._getNamingContainer(rowType, i);
            row = new $ADC.GridViewRow(namingContainer, tr, i, rowType, dataRow);
            Array.add(this._rows, row);

            if (style != null)
            {
                style.apply(tr);
            }

            for(var j = 0; j < columnsLength; j++)
            {
                column = this._columns[j];

                if (column.get_visible() == true)
                {
                    td = document.createElement('td');
                    tr.appendChild(td);

                    column.renderData(dataRow, row, td);
                }
            }

            isAlt = !isAlt;

            handler = this.get_events().getHandler('rowCreated');

            if (handler)
            {
                handler(this, new $ADC.GridViewRowEventArgs(row));
            }

            handler = this.get_events().getHandler('rowDataBound');

            if (handler)
            {
                handler(this, new $ADC.GridViewRowEventArgs(row));
            }
        }

        var tfoot = document.createElement('tfoot');
        table.appendChild(tfoot);

        var trFoot = document.createElement('tr');
        tfoot.appendChild(trFoot);

        namingContainer = this._getNamingContainer($ADC.GridViewRowType.Footer, -1);
        this._footerRow = new $ADC.GridViewRow(namingContainer, trFoot, -1, $ADC.GridViewRowType.Footer, null);

        if (this.get_footerStyle() != null)
        {
            this.get_footerStyle().apply(trFoot);
        }
        
        if (this.get_showFooter() == true)
        {
            for(i = 0; i < columnsLength; i++)
            {
                column = this._columns[i];

                if (column.get_visible() == true)
                {
                    td = document.createElement('td');
                    trFoot.appendChild(td);

                    column.set_footerContainer(td);
                    column.renderFooter(this._footerRow);
                }
            }
        }

        var handler;

        handler = this.get_events().getHandler('rowCreated');

        if (handler)
        {
            handler(this, new $ADC.GridViewRowEventArgs(this._footerRow));
        }

        handler = this.get_events().getHandler('rowDataBound');

        if (handler)
        {
            handler(this, new $ADC.GridViewRowEventArgs(this._footerRow));
        }

        this._hasBinded = true;

        if (allowDragAndDrop)
        {
            //The Following will prevent the content selection while dragging

            if (Sys.Browser.agent == Sys.Browser.InternetExplorer)
            {
                table.style.userSelect = 'none';
            } 
            else if (Sys.Browser.agent == Sys.Browser.Safari)
            {
                table.style.KhtmlUserSelect = 'none';
            }
            else
            {
                table.style.MozUserSelect = 'none';// Both Firefox and Opera is suppose to support it
            }
        }

        table.style.visibility = 'visible';

        if (animate == true)
        {
            if (this._canAnimate())
            {
                if (this._animation == null)
                {
                    this._animation = $ADC.Util.createDataBindAnimation(this.get_animationDuration(), this.get_animationFps(), this);
                }

                if (Sys.Browser.agent == Sys.Browser.InternetExplorer)
                {
                    var backColor = $ADC.Style.getStyleValue(table, 'backgroundColor');

                    if ((!backColor) || (backColor == '') || (backColor == 'transparent') || (backColor == 'rgba(0, 0, 0, 0)'))
                    {
                        table.style.backgroundColor = $ADC.Style.getInheritedBackgroundColor(table);
                    }
                }

                this._animation.play(); 
            }
        }
    },

    _onProfileLoaded : function(result, propertyName)
    {
        var serializedColumns =  Sys.Services.ProfileService.properties[propertyName];

        if (serializedColumns)
        {
            if (serializedColumns.length > 0)
            {
                var profileColumns = Sys.Serialization.JavaScriptSerializer.deserialize(serializedColumns);

                if ((profileColumns != null) && (profileColumns.length > 0))
                {
                    for(var i = 0; i < profileColumns.length; i++)
                    {
                        var oldIndex = this.getColumnIndexByColumnID(profileColumns[i].id);
                        var newIndex = profileColumns[i].idx;

                        if ((oldIndex > -1) && (oldIndex != newIndex))
                        {
                            var column = this._columns[oldIndex];
                            //First remove the column from that index.
                            Array.removeAt(this._columns, oldIndex);
                            //Now insert it in new index
                            Array.insert(this._columns, newIndex, column);
                        }
                    }
                }
            }
        }

        var handler = this.get_events().getHandler('columnsLoadedFromProfile');

        if (handler)
        {
            handler(this, Sys.EventArgs.Empty);
        }
    },

    _onProfileSaved : function(result, propertyName)
    {
        var handler = this.get_events().getHandler('columnsSavedToProfile');

        if (handler)
        {
            handler(this, Sys.EventArgs.Empty);
        }
    },

    _select : function(index)
    {
        var e = Function._validateParams(arguments, [{name: 'index', type: Number}]);
        if (e) throw e;

        //No need to processed further if we dont have any data
        if ((this._rows.length == 0))
        {
            return;
        }

        //No need to proceed if the current selected index and new index is same
        if (this._selectedIndex == index)
        {
            return;
        }

        var isAlt = false;
        var length = this._rows.length;
        var style;
        var rowStyle = this.get_rowStyle();
        var alternatingRowStyle = this.get_alternatingRowStyle();
        var selectedRowStyle = this.get_selectedRowStyle();
        var editRowStyle = this.get_editRowStyle();

        //Now Revert back the datarows styles with the original state
        for(var i = 0; i < length; i++)
        {
            style = rowStyle;

            if (isAlt)
            {
                if (alternatingRowStyle != null)
                {
                    style = alternatingRowStyle;
                }
            }

            if (index == i)
            {
                if (selectedRowStyle != null)
                {
                    style = selectedRowStyle;
                }
            }
            else if (this._editIndex == i)
            {
                if (editRowStyle != null)
                {
                    style = editRowStyle;
                }
            }

            if (style != null)
            {
                style.apply(this._rows[i].get_container());
            }

            isAlt = !isAlt;
        }

        //Store the new index
        this._selectedIndex = index;
        //Since the index has changed raise the property change event
        this.raisePropertyChanged('selectedIndex');

        var handler = this.get_events().getHandler('selectedIndexChanged');

        if (handler)
        {
            handler(this, Sys.EventArgs.Empty);
        }
    },

    _getNamingContainer : function(rowType, index)
    {
        return this.get_element().id + '$' + rowType.toString() + '$' + index.toString();
    },

    _cleanupRows : function()
    {
        if (this._rows.length > 0)
        {
            for(var i = this._rows.length - 1; i > -1; i--)
            {
                this._rows[i].dispose();
                delete this._rows[i];
            }
        }

        Array.clear(this._rows);
    },

    _canAnimate : function()
    {
        var canAnimate = this.get_animate();

        if (canAnimate)
        {
            canAnimate = $ADC.Util.hasAnimationSupport();
        }

        return canAnimate;
    }
}

$ADC.GridView.registerClass('AjaxDataControls.GridView', Sys.UI.Control);

if (typeof(Sys) != 'undefined')
{
    Sys.Application.notifyScriptLoaded();
}