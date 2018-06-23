Type.registerNamespace('AjaxDataControls');

$ADC.RepeaterItemType = function()
{
    /// <summary>
    /// Specifies the type of an item in a Repeater control.
    /// </summary>
    /// <field name="NotSet" type="Number" integer="true" static="true">Not set. Used internally.</field>
    /// <field name="Header" type="Number" integer="true" static="true">A header for the Repeater control. It is not data-bound.</field>
    /// <field name="Footer" type="Number" integer="true" static="true">A footer for the Repeater control. It is not data-bound. </field>
    /// <field name="Item" type="Number" integer="true" static="true">An item in the Repeater control. It is data-bound.</field>
    /// <field name="AlternatingItem" type="Number" integer="true" static="true">An item in alternating (zero-based even-indexed) cells. It is data-bound.</field>
    /// <field name="Separator" type="Number" integer="true" static="true">A separator between items in a Repeater control. It is not data-bound.</field>

    throw Error.notImplemented();
}

$ADC.RepeaterItemType.prototype =
{
    NotSet : 0,
    Header : 1,
    Footer : 2,
    Item : 3,
    AlternatingItem : 4,
    Separator : 5
}

$ADC.RepeaterItemType.registerEnum('AjaxDataControls.RepeaterItemType');


$ADC.RepeaterItem = function(owner, namingContainer, itemIndex, itemType, dataItem)
{
    /// <summary>
    /// Represents an item in the Repeater control.
    /// </summary>
    /// <param name="owner" type="AjaxDataControls.Repeater">
    /// The owner of the item.
    /// </param>
    /// <param name="namingContainer" type="string">
    /// The naming container, which creates a unique namespace for differentiating between controls with the same Control.ID property value.
    /// </param>
    /// <param name="itemIndex" type="Number" integer="true">
    /// The Index of the item.
    /// </param>
    /// <param name="itemType" type="AjaxDataControls.RepeaterItemType">
    /// The Type of the item.
    /// </param>
    /// <param name="dataItem" type="Object" mayBeNull="true">
    /// The associate data with this item of the data source of the owner Repeater.
    /// </param>

    var e = Function._validateParams(arguments, [{name: 'owner', type: $ADC.Repeater}, {name: 'namingContainer', type: String}, {name: 'itemIndex', type: Number}, {name: 'itemType', type: $ADC.RepeaterItemType}, {name: 'dataItem', mayBeNull:true}]);
    if (e) throw e;

    this._owner = owner;
    this._namingContainer = namingContainer;
    this._itemIndex = itemIndex;
    this._itemType = itemType;
    this._dataItem = dataItem;
    this._controls = new Array();

    this._containers = new Array();
    this._commandHandlers = new Array();
}

$ADC.RepeaterItem.prototype =
{
    get_itemIndex : function()
    {
        /// <value type="Number" integer="true">
        /// The index of the item in the Repeater control from the Items collection of the control.
        /// </value>

        if (arguments.length !== 0) throw Error.parameterCount();

        return this._itemIndex;
    },

    get_itemType : function()
    {
        /// <value type="AjaxDataControls.RepeaterItemType">
        /// The type of the item.
        /// </value>

        if (arguments.length !== 0) throw Error.parameterCount();

        return this._itemType;
    },

    get_dataItem : function()
    {
        /// <value type="Object" mayBeNull="true">
        /// The data of the datasource which is associated with this item .
        /// </value>

        if (arguments.length !== 0) throw Error.parameterCount();

        return this._dataItem;
    },

    get_isDataItemType : function()
    {
        /// <summary>
        /// Checks if the item type is either Item or AlternatingItem.
        /// </summary>
        /// <returns type="Boolean">
        /// Returns true if its type is either item or AlternatingItem
        /// </returns>

        if (arguments.length !== 0) throw Error.parameterCount();

        var itemType = this.get_itemType();

        return  (
                    (itemType == $ADC.RepeaterItemType.Item) ||
                    (itemType == $ADC.RepeaterItemType.AlternatingItem)
                );
    },

    dispose : function()
    {
        /// <summary>
        /// Dispose the item.
        /// </summary>

        if (arguments.length !== 0) throw Error.parameterCount();

        var i = 0;

        for(i = this._controls.length -1; i > -1; i--)
        {
            delete this._controls[i];
        }

        Array.clear(this._controls);

        if ((this._containers.length > 0) && (this._commandHandlers.length > 0))
        {
            for(i = this._containers.length - 1; i > -1; i--)
            {
                $removeHandler(this._containers[i], 'click', this._commandHandlers[i]);
                delete this._containers[i];
                delete this._commandHandlers[i];
            }
        }
        else
        {
            if (this._containers.length > 0)
            {
                for(i = this._containers.length - 1; i > -1; i--)
                {
                    delete this._containers[i];
                }
            }
        }

        Array.clear(this._containers);
        Array.clear(this._commandHandlers);

        delete this._controls;
        delete this._containers;
        delete this._commandHandlers;

        delete this._owner;
    },

    addControl : function(parentControl, childControl)
    {
        /// <summary>
        /// Add the childControl in the specified parent while maintaining the naming container.
        /// </summary>
        /// <param name="parentControl" domElement="true">
        /// The parent dome element.
        /// </param>
        /// <param name="childControl" domElement="true">
        /// The child dome element.
        /// </param>
        /// <returns/>

        var e = Function._validateParams(arguments, [{name: 'parentControl', type: Object}, {name: 'childControl', type: Object}]);
        if (e) throw e;

        this._addControl(childControl);
        parentControl.appendChild(childControl);
    },

    removeControl : function(controlId)
    {
        /// <summary>
        /// Removes the specified control from the item control collection.
        /// </summary>
        /// <param name="controlId" type="String">
        /// The control ID without the naming container.
        /// </param>
        /// <returns/>

        var e = Function._validateParams(arguments, [{name: "controlId", type: String}]);
        if (e) throw e;

        var control = this.findControl(controlId);

        if (control)
        {
            Array.remove(control.id);
            control.parentNode.removeChild(control);
        }
    },

    findControl : function (controlId)
    {
        /// <summary>
        /// Finds the specified control from the item control collection.
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

$ADC.RepeaterItem.registerClass('AjaxDataControls.RepeaterItem', null, Sys.IDisposable);


$ADC.RepeaterItemEventArgs = function(item)
{
    /// <summary>
    /// Event arguments used when the repeater item is created or databound.
    /// </summary>
    /// <param name="item" type="AjaxDataControls.RepeaterItem">
    /// The associated Repeater item.
    /// </param>

    var e = Function._validateParams(arguments, [{name: 'item', type: $ADC.RepeaterItem}]);
    if (e) throw e;

    $ADC.RepeaterItemEventArgs.initializeBase(this);
    this._item = item;
}

$ADC.RepeaterItemEventArgs.prototype =
{
    get_item : function()
    {
        /// <value type="AjaxDataControls.RepeaterItem">
        /// The repeater item associated with this event.
        /// </value>

        if (arguments.length !== 0) throw Error.parameterCount();

        return this._item;
    }
}

$ADC.RepeaterItemEventArgs.registerClass('AjaxDataControls.RepeaterItemEventArgs', Sys.EventArgs);


$ADC.RepeaterCommandEventArgs = function(commandName, commandArgument, commandSource, item)
{
    /// <summary>
    /// Event arguments used for the repeater command event.
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
    /// <param name="item" type="AjaxDataControls.RepeaterItem">
    /// The associated repeater item.
    /// </param>

    var e = Function._validateParams(arguments, [{name: 'commandName', type: String}, {name: 'commandArgument'}, {name: 'commandSource', type: Object}, {name: 'item', type: $ADC.RepeaterItem}]);
    if (e) throw e;

    $ADC.RepeaterCommandEventArgs.initializeBase(this);
    this._commandName = commandName;
    this._commandArgument = commandArgument;
    this._commandSource = commandSource;
    this._item = item;
}

$ADC.RepeaterCommandEventArgs.prototype =
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

    get_item : function()
    {
        /// <value type="AjaxDataControls.RepeaterItem">
        /// The associated repeater item.
        /// </value>

        if (arguments.length !== 0) throw Error.parameterCount();

        return this._item;
    }
}

$ADC.RepeaterCommandEventArgs.registerClass('AjaxDataControls.RepeaterCommandEventArgs', Sys.EventArgs);


$ADC.Repeater = function(element)
{
    /// <summary>
    /// A data-bound list control that allows custom layout by repeating a specified template for each item displayed in the list.
    /// </summary>
    /// <param name="element" domElement="true">
    /// The dom element where the Repeater will be rendered.
    /// </param>

    this._headerTemplate = '';
    this._itemTemplate = '';
    this._separatorTemplate = '';
    this._alternatingItemTemplate = '';
    this._footerTemplate = '';

    this._dataSource = null;

    this._items = new Array();

    this._animate = true
    this._animationDuration = 0.2;
    this._animationFps = 20;
    this._animation = null;

    $ADC.Repeater.initializeBase(this, [element]);
}

$ADC.Repeater.prototype =
{
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

    get_headerTemplate : function()
    {
        /// <value type="String">
        /// The template that defines how the header section of the Repeater control is displayed.
        /// </value>

        if (arguments.length !== 0) throw Error.parameterCount();

        return this._headerTemplate;
    },

    set_headerTemplate : function(value)
    {
        var e = Function._validateParams(arguments, [{name: 'value', type: String}]);
        if (e) throw e;

        if (this._headerTemplate != value)
        {
            this._headerTemplate = value;
            this.raisePropertyChanged('headerTemplate');
        }
    },

    get_itemTemplate : function()
    {
        /// <value type="String">
        /// The template that defines how items in the Repeater control are displayed.
        /// </value>

        if (arguments.length !== 0) throw Error.parameterCount();

        return this._itemTemplate;
    },

    set_itemTemplate : function(value)
    {
        var e = Function._validateParams(arguments, [{name: 'value', type: String}]);
        if (e) throw e;

        if (this._itemTemplate != value)
        {
            this._itemTemplate = value;
            this.raisePropertyChanged('itemTemplate');
        }
    },

    get_separatorTemplate : function()
    {
        /// <value type="String">
        /// The template that defines how the separator between items is displayed.
        /// </value>

        if (arguments.length !== 0) throw Error.parameterCount();

        return this._separatorTemplate;
    },

    set_separatorTemplate : function(value)
    {
        var e = Function._validateParams(arguments, [{name: 'value', type: String}]);
        if (e) throw e;

        if (this._separatorTemplate != value)
        {
            this._separatorTemplate = value;
            this.raisePropertyChanged('separatorTemplate');
        }
    },

    get_alternatingItemTemplate : function()
    {
        /// <value type="String">
        /// The template that defines how alternating items in the control are displayed.
        /// </value>

        if (arguments.length !== 0) throw Error.parameterCount();

        return this._alternatingItemTemplate;
    },

    set_alternatingItemTemplate : function(value)
    {
        var e = Function._validateParams(arguments, [{name: 'value', type: String}]);
        if (e) throw e;

        if (this._alternatingItemTemplate != value)
        {
            this._alternatingItemTemplate = value;
            this.raisePropertyChanged('alternatingItemTemplate');
        }
    },

    get_footerTemplate : function()
    {
        /// <value type="String">
        /// The template that defines how the footer section of the Repeater control is displayed.
        /// </value>

        if (arguments.length !== 0) throw Error.parameterCount();

        return this._footerTemplate;
    },

    set_footerTemplate : function(value)
    {
        var e = Function._validateParams(arguments, [{name: 'value', type: String}]);
        if (e) throw e;

        if (this._footerTemplate != value)
        {
            this._footerTemplate = value;
            this.raisePropertyChanged('footerTemplate');
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

    get_dataSource : function()
    {
        /// <value type="Array" mayBeNull="true">
        /// The data source that provides data for populating the Repeater.
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
            this.raisePropertyChanged('dataSource');
        }
    },

    get_items : function()
    {
        /// <value type="Array" mayBeNull="true" elementType="AjaxDataControls.RepeaterItem">
        /// The collection of RepeaterItem objects in the Repeater control.
        /// </value>

        if (arguments.length !== 0) throw Error.parameterCount();

        return this._items;
    },

    initialize : function()
    {
        /// <summary>
        /// Initialize the control.
        /// </summary>

        $ADC.Repeater.callBaseMethod(this, 'initialize');
    },

    dispose : function()
    {
        /// <summary>
        /// Dispose the control.
        /// </summary>

        if (this._animation != null)
        {
            this._animation.dispose();
        }

        delete this._animation;

        this._clearItems();
        delete this._items;

        $ADC.Repeater.callBaseMethod(this, 'dispose');
    },

    dataBind : function()
    {
        /// <summary>
        /// Binds the data source to the Repeater control.
        /// </summary>

        if (arguments.length !== 0) throw Error.parameterCount();

        if ($ADC.Util.isEmptyString(this.get_itemTemplate()))
        {
            throw Error.invalidOperation('ItemTemplate must be set before calling this method.');
        }

        var target = this.get_element();
        target.style.visibility = 'hidden';

        this._clearItems();
        $ADC.Util.clearContent(target);

        var headerTemplate = this.get_headerTemplate();

        if (!$ADC.Util.isEmptyString(headerTemplate))
        {
            this._addTemplate(headerTemplate, -1, $ADC.RepeaterItemType.Header, null);
        }

        var dataSource = this.get_dataSource();

        //Do not render the ItemTemplate, AlternateTemplate and Separatortemplate if data
        //soure contains nothing 
        if ((dataSource != null) && (dataSource.length > 0))
        {
            var itemTemplate = this.get_itemTemplate();

            var alternatingItemTemplate = this.get_alternatingItemTemplate();
            var hasAlternatingItemTemplate = !$ADC.Util.isEmptyString(alternatingItemTemplate);

            var separatorTemplate = this.get_separatorTemplate();
            var hasSeparatorTemplate = !$ADC.Util.isEmptyString(separatorTemplate);

            var isAlt = false;
            var itemType = $ADC.RepeaterItemType.Item;
            var template;
            var length = dataSource.length;

            for(var i = 0; i < length; i++)
            {
                var dataItem = dataSource[i];
                template = itemTemplate;

                if (hasAlternatingItemTemplate)
                {
                    if (isAlt)
                    {
                        template = alternatingItemTemplate;
                        itemType = $ADC.RepeaterItemType.AlternatingItem;
                    }
                    else
                    {
                        itemType = $ADC.RepeaterItemType.Item;
                    }
                }

                this._addTemplate(template, i, itemType, dataItem);
                isAlt = !isAlt;

                if ((hasSeparatorTemplate) && (i != (length - 1)))
                {
                    this._addTemplate(separatorTemplate, i, $ADC.RepeaterItemType.Separator, null);
                }
            }
        }

        var footerTemplate = this.get_footerTemplate();

        if (!$ADC.Util.isEmptyString(footerTemplate))
        {
            this._addTemplate(footerTemplate, -1, $ADC.RepeaterItemType.Footer, null);
        }

        target.style.visibility = 'visible';

        if (this._canAnimate())
        {
            if (this._animation == null)
            {
                this._animation = $ADC.Util.createDataBindAnimation(this.get_animationDuration(), this.get_animationFps(), this);
            }

            if (Sys.Browser.agent == Sys.Browser.InternetExplorer)
            {
                var backColor = $ADC.Style.getStyleValue(target, 'backgroundColor');

                if ((!backColor) || (backColor == '') || (backColor == 'transparent') || (backColor == 'rgba(0, 0, 0, 0)'))
                {
                    target.style.backgroundColor = $ADC.Style.getInheritedBackgroundColor(target);
                }
            }

            this._animation.play(); 
        }
    },

    add_itemCreated : function(handler)
    {
        /// <summary>
        /// This event is raised when an item is created in the Repeater control
        /// </summary>
        /// <param name="handler" type="Function">
        /// Event handler
        /// </param>

        var e = Function._validateParams(arguments, [{name: 'handler', type: Function}]);
        if (e) throw e;

        this.get_events().addHandler('itemCreated', handler);
    },

    remove_itemCreated : function(handler)
    {
        var e = Function._validateParams(arguments, [{name: 'handler', type: Function}]);
        if (e) throw e;

        this.get_events().removeHandler('itemCreated', handler);
    },

    add_itemDataBound : function(handler)
    {
        /// <summary>
        /// This event is raised when an item in the Repeater control is going to be data-bounded.
        /// </summary>
        /// <param name="handler" type="Function">
        /// Event handler
        /// </param>

        var e = Function._validateParams(arguments, [{name: 'handler', type: Function}]);
        if (e) throw e;

        this.get_events().addHandler('itemDataBound', handler);
    },

    remove_itemDataBound : function(handler)
    {
        var e = Function._validateParams(arguments, [{name: 'handler', type: Function}]);
        if (e) throw e;

        this.get_events().removeHandler('itemDataBound', handler);
    },

    add_itemCommand : function(handler)
    {
        /// <summary>
        /// This event is raised when a button which has associated commandName in the Repeater control is clicked.
        /// </summary>
        /// <param name="handler" type="Function">
        /// Event handler
        /// </param>

        var e = Function._validateParams(arguments, [{name: 'handler', type: Function}]);
        if (e) throw e;

        this.get_events().addHandler('itemCommand', handler);
    },

    remove_itemCommand : function(handler)
    {
        var e = Function._validateParams(arguments, [{name: 'handler', type: Function}]);
        if (e) throw e;

        this.get_events().removeHandler('itemCommand', handler);
    },

    _addTemplate : function(template, index, itemType, dataItem)
    {
        var controlElement = this.get_element();

        //Our Custom logic of Naming Container
        var namingContainer = controlElement.id + '$' + itemType + '$' + index;

        //Create an Instance of RepeaterItem
        var item = new $ADC.RepeaterItem(this, namingContainer, index, itemType, dataItem);

        //Create a Temporary Node, to make the server side html snippet programmable
        var tempElement = document.createElement(controlElement.tagName);
        tempElement.innerHTML = template;

        //Now iterate the Child nodes to ensure the unique id generation
        var length = tempElement.childNodes.length;

        for(i = 0; i < length; i++)
        {
            this._iterateElements(tempElement.childNodes[i], item);
        }

        var clickHandler;
        var firstChild;
        var isDataItemType = item.get_isDataItemType();

        //Now Add the Child Nodes in this Control
        if (tempElement.firstChild)
        {
            while(tempElement.firstChild)
            {
                firstChild = tempElement.firstChild;

                controlElement.appendChild(firstChild);

                if (isDataItemType)
                {
                    clickHandler = Function.createCallback(this._raiseCommand, {sender:this, item:item});
                    $addHandler(firstChild, 'click', clickHandler);

                    Array.add(item._containers, firstChild);
                    Array.add(item._commandHandlers, clickHandler);
                }
            }
        }

        //Only adds the item in the Items collection if it is the DataItem
        if (isDataItemType)
        {
            this.get_items().push(item);
        }

        //Now the Raise events if there is any subscriber;
        var handler;

        handler = this.get_events().getHandler('itemCreated');

        if (handler)
        {
            handler(this, new $ADC.RepeaterItemEventArgs(item));
        }

        handler = this.get_events().getHandler('itemDataBound');

        if (handler)
        {
            handler(this, new $ADC.RepeaterItemEventArgs(item));
        }
    },

    _iterateElements : function(element, item)
    {
        item._addControl(element);

        var length = element.childNodes.length;

        for(var i = 0; i < length; i++)
        {
            this._iterateElements(element.childNodes[i], item);
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

        if ((commandName.length > 0) && (context.item.get_isDataItemType()))
        {
            var handler = context.sender.get_events().getHandler('itemCommand');

            if (handler)
            {
                handler(context.sender, new $ADC.RepeaterCommandEventArgs(commandName, commandArgument, e.target, context.item));
            }
        }
    },

    _clearItems : function()
    {
        if (this._items.length > 0)
        {
            for(var i = this._items.length - 1; i > -1; i--)
            {
                this._items[i].dispose();
                delete this._items[i];
            }
        }

        Array.clear(this._items);
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

$ADC.Repeater.registerClass('AjaxDataControls.Repeater', Sys.UI.Control);

if (typeof(Sys) != 'undefined')
{
    Sys.Application.notifyScriptLoaded();
}