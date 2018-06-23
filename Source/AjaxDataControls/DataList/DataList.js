
Type.registerNamespace('AjaxDataControls');
$ADC.DataListRepeatDirection=function()
{
throw Error.notImplemented();}
$ADC.DataListRepeatDirection.prototype=
{
Vertical:0,
Horizontal:1}
$ADC.DataListRepeatDirection.registerEnum('AjaxDataControls.DataListRepeatDirection');
$ADC.DataListItemType=function()
{
throw Error.notImplemented();}
$ADC.DataListItemType.prototype=
{
NotSet:0,
Header:1,
Footer:2,
Item:3,
AlternatingItem:4,
SelectedItem:5,
EditItem:6,
Separator:7}
$ADC.DataListItemType.registerEnum('AjaxDataControls.DataListItemType');
$ADC.DataListItem=function(owner,namingContainer,container,itemIndex,itemType,dataItem)
{
var e=Function._validateParams(arguments,[{name:'owner',type:$ADC.DataList},{name:'namingContainer',type:String},{name:'container',type:Object},{name:'itemIndex',type:Number},{name:'itemType',type:$ADC.DataListItemType},{name:'dataItem',mayBeNull:true}]);
if(e)throw e;
this._owner=owner;
this._namingContainer=namingContainer;
this._container=container;
this._itemIndex=itemIndex;
this._itemType=itemType;
this._dataItem=dataItem;
this._controls=new Array();
this._clickHandler;
this._mouseDownHandler;
this._visualClue=null;
this._initialize();}
$ADC.DataListItem.prototype=
{
get_itemIndex:function()
{
if(arguments.length!==0)throw Error.parameterCount();
return this._itemIndex;},
get_itemType:function()
{
if(arguments.length!==0)throw Error.parameterCount();
return this._itemType;},
get_dataItem:function()
{
if(arguments.length!==0)throw Error.parameterCount();
return this._dataItem;},
get_isDataItemType:function()
{
if(arguments.length!==0)throw Error.parameterCount();
var itemType=this.get_itemType();
return(
(itemType==$ADC.DataListItemType.Item)||
(itemType==$ADC.DataListItemType.AlternatingItem)||
(itemType==$ADC.DataListItemType.SelectedItem)||
(itemType==$ADC.DataListItemType.EditItem));},
get_container:function()
{
if(arguments.length!==0)throw Error.parameterCount();
return this._container;},
get_dragDataType:function()
{
var dataType=this._owner.get_id()+'-DataListItem';
return dataType;},
get_dragMode:function()
{
return Sys.Preview.UI.DragMode.Move;},
get_dropTargetElement:function()
{
return this._container;},
dispose:function()
{
if(arguments.length!==0)throw Error.parameterCount();
if(this._isDragAndDropAllowed())
{
if(this._mouseDownHandler)
{
$removeHandler(this._container,'mousedown',this._mouseDownHandler);
Sys.Preview.UI.DragDropManager.unregisterDropTarget(this);}
if(this._visualClue!=null)
{
document.getElementsByTagName('body')[0].removeChild(this._visualClue);}}
for(var i=this._controls.length-1;i>-1;i--)
{
delete this._controls[i];}
Array.clear(this._controls);
delete this._controls;
if(this._clickHandler)
{
$removeHandler(this._container,'click',this._clickHandler);}
delete this._clickHandler;
delete this._mouseDownHandler;
delete this._container;
delete this._visualClue;
delete this._owner;},
addControl:function(childControl)
{
this._addControl(childControl);
this._container.appendChild(childControl);},
removeControl:function(controlId)
{
var e=Function._validateParams(arguments,[{name:"controlId",type:String}]);
if(e)throw e;
var control=this.findControl(controlId);
if(control)
{
Array.remove(control.id);
control.parentNode.removeChild(control);}},
findControl:function(controlId)
{
var e=Function._validateParams(arguments,[{name:"controlId",type:String}]);
if(e)throw e;
var targetId=(this._namingContainer+'$'+controlId);
var index=Array.indexOf(this._controls,targetId);
if(index>-1)
{
return $get(targetId);}
return null;},
getDragData:function(context)
{
return this;},
onDragStart:function()
{
this._owner._raiseItemDragStart(this);},
onDrag:function()
{},
onDragEnd:function(cancelled)
{
if(this._visualClue!=null)
{
document.getElementsByTagName('body')[0].removeChild(this._visualClue);
this._visualClue=null;}},
canDrop:function(dragMode,dataType,dragData)
{
var supportedDataType=this._owner.get_id()+'-DataListItem';
return(dataType==supportedDataType);},
drop:function(dragMode,dataType,draggingItem)
{
var oldInex=draggingItem.get_itemIndex();
var newInex=this.get_itemIndex();
if(oldInex==newInex)
{
return;}
if(draggingItem.get_itemType()==$ADC.DataListItemType.SelectedItem)
{
this._owner._selectedIndex=newInex;}
else if(draggingItem.get_itemType()==$ADC.DataListItemType.EditItem)
{
this._owner._editItemIndex=newInex;}
else if(this.get_itemType()==$ADC.DataListItemType.SelectedItem)
{
if(this.get_itemIndex()<draggingItem.get_itemIndex())
{
this._owner._selectedIndex+=1;}
else if(this.get_itemIndex()>draggingItem.get_itemIndex())
{
this._owner._selectedIndex-=1;}}
else if(this.get_itemType()==$ADC.DataListItemType.EditItem)
{
if(this.get_itemIndex()<draggingItem.get_itemIndex())
{
this._owner._editItemIndex+=1;}
else if(this.get_itemIndex()>draggingItem.get_itemIndex())
{
this._owner._editItemIndex-=1;}}
if(Array.remove(this._owner.get_dataSource(),draggingItem.get_dataItem()))
{
Array.insert(this._owner.get_dataSource(),newInex,draggingItem.get_dataItem());}
this._owner._raiseItemDropped(draggingItem,oldInex,newInex);
this._owner._internalDataBind(false);},
onDragEnterTarget:function(dragMode,dataType,dragData)
{},
onDragInTarget:function(dragMode,dataType,dragData)
{},
onDragLeaveTarget:function(dragMode,dataType,dragData)
{},
_initialize:function()
{
if(this._isDragAndDropAllowed())
{
this._mouseDownHandler=Function.createDelegate(this,this._onMouseDown)
$addHandler(this._container,'mousedown',this._mouseDownHandler);
Sys.Preview.UI.DragDropManager.registerDropTarget(this);
if(this.get_itemType()!=$ADC.DataListItemType.EditItem)
{
this._container.style.cursor='move';
this._container.style.zIndex='9999';}}},
_addControl:function(childControl)
{
if((childControl.id!=null)&&(childControl.id.length>0))
{
var targetId=(this._namingContainer+'$'+childControl.id);
if(Array.contains(this._controls,targetId))
{
throw Error.invalidOperation('Control of the same id already exists.');}
childControl.id=targetId;
Array.add(this._controls,childControl.id);}},
_isDragAndDropAllowed:function()
{
var allowed=this._owner.get_allowDragAndDrop();
if(allowed)
{
allowed=this.get_isDataItemType();}
if(allowed)
{
allowed=$ADC.Util.hasDragNDropSupport();}
return allowed;},
_onMouseDown:function(e)
{
var allowDrag=true;
if(this.get_itemType()==$ADC.DataListItemType.EditItem)
{
allowDrag=false;}
else
{
var element=e.target;
if(element!=this._container)
{
var commandName='';
if(e.target.commandName)
{
commandName=e.target.commandName;}
else
{
var commandNameAttribute=e.target.attributes['commandName'];
if(commandNameAttribute)
{
if(commandNameAttribute.value)
{
commandName=commandNameAttribute.value;}
else if(commandNameAttribute.nodeValue)
{
commandName=commandNameAttribute.nodeValue;}}}
if(commandName.length>0)
{
allowDrag=false;}
if(allowDrag==true)
{
if(typeof(element.onclick)=='function')
{
allowDrag=false;}}}}
if(allowDrag==true)
{
window._event=e;
e.preventDefault();
this._createVisualClue();
Sys.Preview.UI.DragDropManager.startDragDrop(this,this._visualClue,null);}},
_createVisualClue:function()
{
this._visualClue=this._owner.get_element().cloneNode(false);
if(this._visualClue.id)
{
this._visualClue.removeAttribute('id');}
document.getElementsByTagName('body')[0].appendChild(this._visualClue);
var tbody=document.createElement('tbody');
this._visualClue.appendChild(tbody);
var tr=document.createElement('tr');
tbody.appendChild(tr);
var td=this._container.cloneNode(true);
tr.appendChild(td);
var alphaOpacity=this._owner.get_dragOpacity();
var opacity=(alphaOpacity/100);
this._visualClue.style.filter='alpha(opacity='+alphaOpacity.toString()+')';
this._visualClue.style.opacity=opacity.toString();
this._visualClue.style.mozOpacity=opacity.toString();
var location=Sys.UI.DomElement.getLocation(this._container);
this._visualClue.style.width=this._container.clientWidth+'px';
this._visualClue.style.height=this._container.clientHeight+'px';
Sys.UI.DomElement.setLocation(this._visualClue,location.x,location.y);}}
if($ADC.Util.hasDragNDropSupport())
{
$ADC.DataListItem.registerClass('AjaxDataControls.DataListItem',null,Sys.IDisposable,Sys.Preview.UI.IDragSource,Sys.Preview.UI.IDropTarget);}
else
{
$ADC.DataListItem.registerClass('AjaxDataControls.DataListItem',null,Sys.IDisposable);}
$ADC.DataListItemEventArgs=function(item)
{
var e=Function._validateParams(arguments,[{name:'item',type:$ADC.DataListItem}]);
if(e)throw e;
$ADC.DataListItemEventArgs.initializeBase(this);
this._item=item;}
$ADC.DataListItemEventArgs.prototype=
{
get_item:function()
{
if(arguments.length!==0)throw Error.parameterCount();
return this._item;}}
$ADC.DataListItemEventArgs.registerClass('AjaxDataControls.DataListItemEventArgs',Sys.EventArgs);
$ADC.DataListCommandEventArgs=function(commandName,commandArgument,commandSource,item)
{
var e=Function._validateParams(arguments,[{name:'commandName',type:String},{name:'commandArgument'},{name:'commandSource',type:Object},{name:'item',type:$ADC.DataListItem}]);
if(e)throw e;
$ADC.DataListCommandEventArgs.initializeBase(this);
this._commandName=commandName;
this._commandArgument=commandArgument;
this._commandSource=commandSource;
this._item=item;}
$ADC.DataListCommandEventArgs.prototype=
{
get_commandName:function()
{
if(arguments.length!==0)throw Error.parameterCount();
return this._commandName;},
get_commandArgument:function()
{
if(arguments.length!==0)throw Error.parameterCount();
return this._commandArgument;},
get_commandSource:function()
{
if(arguments.length!==0)throw Error.parameterCount();
return this._commandSource;},
get_item:function()
{
if(arguments.length!==0)throw Error.parameterCount();
return this._item;}}
$ADC.DataListCommandEventArgs.registerClass('AjaxDataControls.DataListCommandEventArgs',Sys.EventArgs);
$ADC.DataListItemDragStartEventArgs=function(item)
{
var e=Function._validateParams(arguments,[{name:'item',type:$ADC.DataListItem}]);
if(e)throw e;
this._item=item;
$ADC.DataListItemDragStartEventArgs.initializeBase(this);}
$ADC.DataListItemDragStartEventArgs.prototype=
{
get_item:function()
{
if(arguments.length!==0)throw Error.parameterCount();
return this._item;}}
$ADC.DataListItemDragStartEventArgs.registerClass('AjaxDataControls.DataListItemDragStartEventArgs',Sys.EventArgs);
$ADC.DataListItemDroppedEventArgs=function(item,oldIndex,newIndex)
{
var e=Function._validateParams(arguments,[{name:'item',type:$ADC.DataListItem},{name:'oldIndex',type:Number},{name:'newIndex',type:Number}]);
if(e)throw e;
this._item=item;
this._oldIndex=oldIndex;
this._newIndex=newIndex;
$ADC.DataListItemDroppedEventArgs.initializeBase(this);}
$ADC.DataListItemDroppedEventArgs.prototype=
{
get_item:function()
{
if(arguments.length!==0)throw Error.parameterCount();
return this._item;},
get_oldIndex:function()
{
if(arguments.length!==0)throw Error.parameterCount();
return this._oldIndex;},
get_newIndex:function()
{
if(arguments.length!==0)throw Error.parameterCount();
return this._newIndex;}}
$ADC.DataListItemDroppedEventArgs.registerClass('AjaxDataControls.DataListItemDroppedEventArgs',Sys.EventArgs);
$ADC.DataList=function(element)
{
this.SelectCommandName='select';
this.EditCommandName='edit';
this.UpdateCommandName='update';
this.CancelCommandName='cancel';
this.DeleteCommandName='delete';
this._headerTemplate='';
this._itemTemplate='';
this._separatorTemplate='';
this._alternatingItemTemplate='';
this._footerTemplate='';
this._selectedItemTemplate='';
this._editItemTemplate='';
this._headerStyle=null;
this._itemStyle=null;
this._separatorStyle=null;
this._alternatingItemStyle=null;
this._footerStyle=null;
this._selectedItemStyle=null;
this._editItemStyle=null;
this._showHeader=true;
this._showFooter=true;
this._allowDragAndDrop=false;
this._dragOpacity=70;
this._repeatColumns=0;
this._repeatDirection=$ADC.DataListRepeatDirection.Vertical;
this._dataKeyField='';
this._hasBinded=false;
this._dataSource=null;
this._items=new Array();
this._dataKeys=new Array();
this._selectedIndex=-1;
this._editItemIndex=-1;
this._animate=true
this._animationDuration=0.2;
this._animationFps=20;
this._animation=null;
$ADC.DataList.initializeBase(this,[element]);}
$ADC.DataList.prototype=
{
get_border:function()
{
if(arguments.length!==0)throw Error.parameterCount();
return this.get_element().border;},
set_border:function(value)
{
var e=Function._validateParams(arguments,[{name:'value',type:Number}]);
if(e)throw e;
if(this.get_element().border!=value)
{
this.get_element().border=value;
this.raisePropertyChanged('border');}},
get_cellPadding:function()
{
if(arguments.length!==0)throw Error.parameterCount();
return this.get_element().cellPadding;},
set_cellPadding:function(value)
{
var e=Function._validateParams(arguments,[{name:'value',type:Number}]);
if(e)throw e;
if(this.get_element().cellPadding!=value)
{
this.get_element().cellPadding=value;
this.raisePropertyChanged('cellPadding');}},
get_cellSpacing:function()
{
if(arguments.length!==0)throw Error.parameterCount();
return this.get_element().cellSpacing;},
set_cellSpacing:function(value)
{
var e=Function._validateParams(arguments,[{name:'value',type:Number}]);
if(e)throw e;
if(this.get_element().cellSpacing!=value)
{
this.get_element().cellSpacing=value;
this.raisePropertyChanged('cellSpacing');}},
get_cssClass:function()
{
if(arguments.length!==0)throw Error.parameterCount();
return this.get_element().className;},
set_cssClass:function(value)
{
var e=Function._validateParams(arguments,[{name:'value',type:String}]);
if(e)throw e;
var target=this.get_element();
if(!Sys.UI.DomElement.containsCssClass(target,value))
{
Sys.UI.DomElement.addCssClass(target,value);
this.raisePropertyChanged('cssClass');}},
get_headerTemplate:function()
{
if(arguments.length!==0)throw Error.parameterCount();
return this._headerTemplate;},
set_headerTemplate:function(value)
{
var e=Function._validateParams(arguments,[{name:'value',type:String}]);
if(e)throw e;
if(this._headerTemplate!=value)
{
this._headerTemplate=value;
this.raisePropertyChanged('headerTemplate');}},
get_itemTemplate:function()
{
if(arguments.length!==0)throw Error.parameterCount();
return this._itemTemplate;},
set_itemTemplate:function(value)
{
var e=Function._validateParams(arguments,[{name:'value',type:String}]);
if(e)throw e;
if(this._itemTemplate!=value)
{
this._itemTemplate=value;
this.raisePropertyChanged('itemTemplate');}},
get_separatorTemplate:function()
{
if(arguments.length!==0)throw Error.parameterCount();
return this._separatorTemplate;},
set_separatorTemplate:function(value)
{
var e=Function._validateParams(arguments,[{name:'value',type:String}]);
if(e)throw e;
if(this._separatorTemplate!=value)
{
this._separatorTemplate=value;
this.raisePropertyChanged('separatorTemplate');}},
get_alternatingItemTemplate:function()
{
if(arguments.length!==0)throw Error.parameterCount();
return this._alternatingItemTemplate;},
set_alternatingItemTemplate:function(value)
{
var e=Function._validateParams(arguments,[{name:'value',type:String}]);
if(e)throw e;
if(this._alternatingItemTemplate!=value)
{
this._alternatingItemTemplate=value;
this.raisePropertyChanged('alternatingItemTemplate');}},
get_footerTemplate:function()
{
if(arguments.length!==0)throw Error.parameterCount();
return this._footerTemplate;},
set_footerTemplate:function(value)
{
var e=Function._validateParams(arguments,[{name:'value',type:String}]);
if(e)throw e;
if(this._footerTemplate!=value)
{
this._footerTemplate=value;
this.raisePropertyChanged('footerTemplate');}},
get_selectedItemTemplate:function()
{
if(arguments.length!==0)throw Error.parameterCount();
return this._selectedItemTemplate;},
set_selectedItemTemplate:function(value)
{
var e=Function._validateParams(arguments,[{name:'value',type:String}]);
if(e)throw e;
if(this._selectedItemTemplate!=value)
{
this._selectedItemTemplate=value;
this.raisePropertyChanged('selectedItemTemplate');}},
get_editItemTemplate:function()
{
if(arguments.length!==0)throw Error.parameterCount();
return this._editItemTemplate;},
set_editItemTemplate:function(value)
{
var e=Function._validateParams(arguments,[{name:'value',type:String}]);
if(e)throw e;
if(this._editItemTemplate!=value)
{
this._editItemTemplate=value;
this.raisePropertyChanged('editItemTemplate');}},
get_headerStyle:function()
{
if(arguments.length!==0)throw Error.parameterCount();
return this._headerStyle;},
set_headerStyle:function(value)
{
var e=Function._validateParams(arguments,[{name:'value',type:$ADC.TableItemStyle}]);
if(e)throw e;
if(this._headerStyle!=value)
{
this._headerStyle=value;
this.raisePropertyChanged('headerStyle');}},
get_itemStyle:function()
{
if(arguments.length!==0)throw Error.parameterCount();
return this._itemStyle;},
set_itemStyle:function(value)
{
var e=Function._validateParams(arguments,[{name:'value',type:$ADC.TableItemStyle}]);
if(e)throw e;
if(this._itemStyle!=value)
{
this._itemStyle=value;
this.raisePropertyChanged('itemStyle');}},
get_separatorStyle:function()
{
if(arguments.length!==0)throw Error.parameterCount();
return this._separatorStyle;},
set_separatorStyle:function(value)
{
var e=Function._validateParams(arguments,[{name:'value',type:$ADC.TableItemStyle}]);
if(e)throw e;
if(this._separatorStyle!=value)
{
this._separatorStyle=value;
this.raisePropertyChanged('separatorStyle');}},
get_alternatingItemStyle:function()
{
if(arguments.length!==0)throw Error.parameterCount();
return this._alternatingItemStyle;},
set_alternatingItemStyle:function(value)
{
var e=Function._validateParams(arguments,[{name:'value',type:$ADC.TableItemStyle}]);
if(e)throw e;
if(this._alternatingItemStyle!=value)
{
this._alternatingItemStyle=value;
this.raisePropertyChanged('alternatingItemStyle');}},
get_footerStyle:function()
{
if(arguments.length!==0)throw Error.parameterCount();
return this._footerStyle;},
set_footerStyle:function(value)
{
var e=Function._validateParams(arguments,[{name:'value',type:$ADC.TableItemStyle}]);
if(e)throw e;
if(this._footerStyle!=value)
{
this._footerStyle=value;
this.raisePropertyChanged('footerStyle');}},
get_selectedItemStyle:function()
{
if(arguments.length!==0)throw Error.parameterCount();
return this._selectedItemStyle;},
set_selectedItemStyle:function(value)
{
var e=Function._validateParams(arguments,[{name:'value',type:$ADC.TableItemStyle}]);
if(e)throw e;
if(this._selectedItemStyle!=value)
{
this._selectedItemStyle=value;
this.raisePropertyChanged('selectedItemStyle');}},
get_editItemStyle:function()
{
if(arguments.length!==0)throw Error.parameterCount();
return this._editItemStyle;},
set_editItemStyle:function(value)
{
var e=Function._validateParams(arguments,[{name:'value',type:$ADC.TableItemStyle}]);
if(e)throw e;
if(this._editItemStyle!=value)
{
this._editItemStyle=value;
this.raisePropertyChanged('editItemStyle');}},
get_showHeader:function()
{
if(arguments.length!==0)throw Error.parameterCount();
return this._showHeader;},
set_showHeader:function(value)
{
var e=Function._validateParams(arguments,[{name:'value',type:Boolean}]);
if(e)throw e;
if(this._showHeader!=value)
{
this._showHeader=value;
this.raisePropertyChanged('showHeader');}},
get_showFooter:function()
{
if(arguments.length!==0)throw Error.parameterCount();
return this._showFooter;},
set_showFooter:function(value)
{
var e=Function._validateParams(arguments,[{name:'value',type:Boolean}]);
if(e)throw e;
if(this._showFooter!=value)
{
this._showFooter=value;
this.raisePropertyChanged('showFooter');}},
get_allowDragAndDrop:function()
{
if(arguments.length!==0)throw Error.parameterCount();
return this._allowDragAndDrop;},
set_allowDragAndDrop:function(value)
{
var e=Function._validateParams(arguments,[{name:'value',type:Boolean}]);
if(e)throw e;
if(this._allowDragAndDrop!=value)
{
this._allowDragAndDrop=value;
this.raisePropertyChanged('allowDragAndDrop');}},
get_dragOpacity:function()
{
if(arguments.length!==0)throw Error.parameterCount();
return this._dragOpacity;},
set_dragOpacity:function(value)
{
var e=Function._validateParams(arguments,[{name:'value',type:Number}]);
if(e)throw e;
if((value<0)||(value>10))
{
throw Error.argument('value','Drag opacity must be 0-100.');}
if(this._dragOpacity!=value)
{
this._dragOpacity=value;
this.raisePropertyChanged('dragOpacity');}},
get_animate:function()
{
if(arguments.length!==0)throw Error.parameterCount();
return this._animate;},
set_animate:function(value)
{
var e=Function._validateParams(arguments,[{name:'value',type:Boolean}]);
if(e)throw e;
if(this._animate!=value)
{
this._animate=value;
this.raisePropertyChanged('animate');}},
get_animationDuration:function()
{
if(arguments.length!==0)throw Error.parameterCount();
return this._animationDuration;},
set_animationDuration:function(value)
{
var e=Function._validateParams(arguments,[{name:'value',type:Number}]);
if(e)throw e;
if(this._animationDuration!=value)
{
this._animationDuration=value;
this.raisePropertyChanged('animationDuration');}},
get_animationFps:function()
{
if(arguments.length!==0)throw Error.parameterCount();
return this._animationFps;},
set_animationFps:function(value)
{
var e=Function._validateParams(arguments,[{name:'value',type:Number}]);
if(e)throw e;
if(this._animationFps!=value)
{
this._animationFps=value;
this.raisePropertyChanged('animationFps');}},
get_repeatColumns:function()
{
if(arguments.length!==0)throw Error.parameterCount();
return this._repeatColumns;},
set_repeatColumns:function(value)
{
var e=Function._validateParams(arguments,[{name:'value',type:Number}]);
if(e)throw e;
if(value<1)
{
throw Error.argument('value','repeatColumns must be a positive integer.');}
if(this._repeatColumns!=value)
{
this._repeatColumns=value;
this.raisePropertyChanged('repeatColumns');}},
get_repeatDirection:function()
{
if(arguments.length!==0)throw Error.parameterCount();
return this._repeatDirection;},
set_repeatDirection:function(value)
{
var e=Function._validateParams(arguments,[{name:'value',type:$ADC.DataListRepeatDirection}]);
if(e)throw e;
if(this._repeatDirection!=value)
{
this._repeatDirection=value;
this.raisePropertyChanged('repeatDirection');}},
get_dataKeyField:function()
{
if(arguments.length!==0)throw Error.parameterCount();
return this._dataKeyField;},
set_dataKeyField:function(value)
{
var e=Function._validateParams(arguments,[{name:'value',type:String}]);
if(e)throw e;
if(this._dataKeyField!=value)
{
this._dataKeyField=value;
this.raisePropertyChanged('dataKeyField');}},
get_dataSource:function()
{
if(arguments.length!==0)throw Error.parameterCount();
return this._dataSource;},
set_dataSource:function(value)
{
var e=Function._validateParams(arguments,[{name:'value',type:Array,mayBeNull:true}]);
if(e)throw e;
if(this._dataSource!=value)
{
this._dataSource=value;
this._hasBinded=false;
this.raisePropertyChanged('dataSource');}},
get_items:function()
{
if(arguments.length!==0)throw Error.parameterCount();
return this._items;},
get_dataKeys:function()
{
if(arguments.length!==0)throw Error.parameterCount();
return this._dataKeys;},
get_selectedIndex:function()
{
if(arguments.length!==0)throw Error.parameterCount();
return this._selectedIndex;},
set_selectedIndex:function(value)
{
var e=Function._validateParams(arguments,[{name:'value',type:Number}]);
if(e)throw e;
if(this._selectedIndex!==value)
{
this._select(value);}},
get_selectedItem:function()
{
if(arguments.length!==0)throw Error.parameterCount();
if(this._selectedIndex<0)
{
return null;}
return this.get_items()[this._selectedIndex];},
get_selectedValue:function()
{
if(arguments.length!==0)throw Error.parameterCount();
if((this.get_dataSource()==null)||(this.get_dataSource().length==0))
{
return null;}
if((this.get_dataKeyField()==null)||(this.get_dataKeyField().length==0))
{
return null;}
if(this.get_selectedIndex()>-1)
{
return this.get_dataSource()[this.get_selectedIndex()][this.get_dataKeyField()];}
return null;},
get_editItemIndex:function()
{
if(arguments.length!==0)throw Error.parameterCount();
return this._editItemIndex;},
set_editItemIndex:function(value)
{
var e=Function._validateParams(arguments,[{name:'value',type:Number}]);
if(e)throw e;
if(this._editItemIndex!=value)
{
this._editItemIndex=value;
this.raisePropertyChanged('editItemIndex');
if(this._hasBinded)
{
this._internalDataBind(false);}}},
get_editItem:function()
{
if(arguments.length!==0)throw Error.parameterCount();
if(this._editItemIndex<0)
{
return null;}
return this.get_items()[this._editItemIndex];},
initialize:function()
{
$ADC.DataList.callBaseMethod(this,'initialize');},
dispose:function()
{
if(this._animation!=null)
{
this._animation.dispose();}
delete this._animation;
this._cleanupItems();
Array.clear(this._dataKeys);
delete this._headerStyle;
delete this._itemStyle;
delete this._separatorStyle;
delete this._alternatingItemStyle;
delete this._footerStyle;
delete this._selectedItemStyle;
delete this._editItemStyle;
delete this._dataKeys;
delete this._items;
$ADC.DataList.callBaseMethod(this,'dispose');},
dataBind:function()
{
if(arguments.length!==0)throw Error.parameterCount();
this._internalDataBind(true);},
add_itemDragStart:function(handler)
{
var e=Function._validateParams(arguments,[{name:'handler',type:Function}]);
if(e)throw e;
this.get_events().addHandler('itemDragStart',handler);},
remove_itemDragStart:function(handler)
{
var e=Function._validateParams(arguments,[{name:'handler',type:Function}]);
if(e)throw e;
this.get_events().removeHandler('itemDragStart',handler);},
add_itemDropped:function(handler)
{
var e=Function._validateParams(arguments,[{name:'handler',type:Function}]);
if(e)throw e;
this.get_events().addHandler('itemDropped',handler);},
remove_itemDropped:function(handler)
{
var e=Function._validateParams(arguments,[{name:'handler',type:Function}]);
if(e)throw e;
this.get_events().removeHandler('itemDropped',handler);},
add_itemCreated:function(handler)
{
var e=Function._validateParams(arguments,[{name:'handler',type:Function}]);
if(e)throw e;
this.get_events().addHandler('itemCreated',handler);},
remove_itemCreated:function(handler)
{
var e=Function._validateParams(arguments,[{name:'handler',type:Function}]);
if(e)throw e;
this.get_events().removeHandler('itemCreated',handler);},
add_itemDataBound:function(handler)
{
var e=Function._validateParams(arguments,[{name:'handler',type:Function}]);
if(e)throw e;
this.get_events().addHandler('itemDataBound',handler);},
remove_itemDataBound:function(handler)
{
var e=Function._validateParams(arguments,[{name:'handler',type:Function}]);
if(e)throw e;
this.get_events().removeHandler('itemDataBound',handler);},
add_selectedIndexChanged:function(handler)
{
var e=Function._validateParams(arguments,[{name:'handler',type:Function}]);
if(e)throw e;
this.get_events().addHandler('selectedIndexChanged',handler);},
remove_selectedIndexChanged:function(handler)
{
var e=Function._validateParams(arguments,[{name:'handler',type:Function}]);
if(e)throw e;
this.get_events().removeHandler('selectedIndexChanged',handler);},
add_editCommand:function(handler)
{
var e=Function._validateParams(arguments,[{name:'handler',type:Function}]);
if(e)throw e;
this.get_events().addHandler('editCommand',handler);},
remove_editCommand:function(handler)
{
var e=Function._validateParams(arguments,[{name:'handler',type:Function}]);
if(e)throw e;
this.get_events().removeHandler('editCommand',handler);},
add_updateCommand:function(handler)
{
var e=Function._validateParams(arguments,[{name:'handler',type:Function}]);
if(e)throw e;
this.get_events().addHandler('updateCommand',handler);},
remove_updateCommand:function(handler)
{
var e=Function._validateParams(arguments,[{name:'handler',type:Function}]);
if(e)throw e;
this.get_events().removeHandler('updateCommand',handler);},
add_cancelCommand:function(handler)
{
var e=Function._validateParams(arguments,[{name:'handler',type:Function}]);
if(e)throw e;
this.get_events().addHandler('cancelCommand',handler);},
remove_cancelCommand:function(handler)
{
var e=Function._validateParams(arguments,[{name:'handler',type:Function}]);
if(e)throw e;
this.get_events().removeHandler('cancelCommand',handler);},
add_deleteCommand:function(handler)
{
var e=Function._validateParams(arguments,[{name:'handler',type:Function}]);
if(e)throw e;
this.get_events().addHandler('deleteCommand',handler);},
remove_deleteCommand:function(handler)
{
var e=Function._validateParams(arguments,[{name:'handler',type:Function}]);
if(e)throw e;
this.get_events().removeHandler('deleteCommand',handler);},
add_itemCommand:function(handler)
{
var e=Function._validateParams(arguments,[{name:'handler',type:Function}]);
if(e)throw e;
this.get_events().addHandler('itemCommand',handler);},
remove_itemCommand:function(handler)
{
var e=Function._validateParams(arguments,[{name:'handler',type:Function}]);
if(e)throw e;
this.get_events().removeHandler('itemCommand',handler);},
_internalDataBind:function(animate)
{
if((this.get_itemTemplate()==null)||(this.get_itemTemplate().length==0))
{
throw Error.invalidOperation('ItemTemplate must be set before calling this method.');}
var table=this.get_element();
table.style.visibility='hidden';
Array.clear(this._dataKeys);
this._cleanupItems();
$ADC.Util.clearContent(table);
var dataSource=this.get_dataSource();
if((dataSource==null)||(dataSource.length==0))
{
table.style.visibility='visible';
return;}
var dataKeyField=this.get_dataKeyField();
var hasDataKeyField=(!$ADC.Util.isEmptyString(dataKeyField));
if(hasDataKeyField)
{
var dataRow=dataSource[0];
var exists=false;
for(var property in dataRow)
{
if(!property.startsWith('__'))
{
if(property==dataKeyField)
{
exists=true;
break;}}}
if(!exists)
{
throw Error.invalidOperation(String.format('Specified {0} does not exists in dataSource.',dataKeyField));}}
var allowDragAndDrop=this.get_allowDragAndDrop();
var repeatColumns=this.get_repeatColumns();
var dataSourceLength=dataSource.length;
var repeatCount=0;
var itemTemplate=this.get_itemTemplate();
var itemStyle=this.get_itemStyle();
var hasItemStyle=(itemStyle!=null);
var alternatingItemTemplate=this.get_alternatingItemTemplate();
var hasAlternateItemTemplate=(!$ADC.Util.isEmptyString(alternatingItemTemplate));
var alternatingItemStyle=this.get_alternatingItemStyle();
var hasAlternatingItemStyle=(alternatingItemStyle!=null);
var separatorTemplate=this.get_separatorTemplate();
var hasSeparatorTemplate=(!$ADC.Util.isEmptyString(separatorTemplate));
var separatorStyle=this.get_separatorStyle();
var hasSeparatorStyle=(separatorStyle!=null);
var selectedItemTemplate=this.get_selectedItemTemplate();
var hasSelectedItemTemplate=(!$ADC.Util.isEmptyString(selectedItemTemplate));
var selectedItemStyle=this.get_selectedItemStyle();
var hasSelectedItemStyle=(selectedItemStyle!=null);
var editItemTemplate=this.get_editItemTemplate();
var hasEditItemTemplate=(!$ADC.Util.isEmptyString(editItemTemplate));
var editItemStyle=this.get_editItemStyle();
var hasEditItemStyle=(editItemStyle!=null);
if(repeatColumns<2)
{
repeatColumns=1;
repeatCount=dataSourceLength;}
else
{
if((dataSourceLength%repeatColumns)==0)
{
repeatCount=(dataSourceLength/repeatColumns);}
else
{
repeatCount=(Math.floor(dataSourceLength/repeatColumns)+1);}
if((repeatColumns>1)&&(hasSeparatorTemplate))
{
repeatColumns*=2;}}
var tbody=document.createElement('tbody');
table.appendChild(tbody);
if(this.get_showHeader())
{
var headerTemplate=this.get_headerTemplate();
if(!$ADC.Util.isEmptyString(headerTemplate))
{
var trHeader=document.createElement('tr');
tbody.appendChild(trHeader);
var tdHeader=document.createElement('td');
trHeader.appendChild(tdHeader);
if(repeatColumns>1)
{
tdHeader.colSpan=repeatColumns;}
var headerStyle=this.get_headerStyle();
if(headerStyle!=null)
{
headerStyle.apply(tdHeader);}
this._addTemplate(tdHeader,headerTemplate,-1,$ADC.DataListItemType.Header,null);}}
var isAlt=false;
var itemType=$ADC.DataListItemType.Item;
var template;
var style;
var tr;
var td;
var i=0;
if(repeatColumns==1)
{
for(i=0;i<dataSourceLength;i++)
{
tr=document.createElement('tr');
tbody.appendChild(tr);
td=document.createElement('td');
tr.appendChild(td);
if(allowDragAndDrop)
{
this._makeUnselectable(td);}
template=itemTemplate;
itemType=$ADC.DataListItemType.Item;
if(hasAlternateItemTemplate)
{
if(isAlt)
{
template=alternatingItemTemplate;
itemType=$ADC.DataListItemType.AlternatingItem;}}
style=null;
if(isAlt)
{
if(hasAlternatingItemStyle)
{
style=alternatingItemStyle;}
else
{
if(hasItemStyle)
{
style=itemStyle;}}}
else
{
if(hasItemStyle)
{
style=itemStyle;}}
if(i==this._selectedIndex)
{
itemType=$ADC.DataListItemType.SelectedItem;
if(hasSelectedItemTemplate)
{
template=selectedItemTemplate;}
if(hasSelectedItemStyle)
{
style=selectedItemStyle;}}
else if(i==this._editItemIndex)
{
itemType=$ADC.DataListItemType.EditItem;
if(hasEditItemTemplate)
{
template=editItemTemplate;}
if(hasEditItemStyle)
{
style=editItemStyle;}}
if(style!=null)
{
style.apply(td);}
this._addTemplate(td,template,i,itemType,dataSource[i]);
isAlt=!isAlt;
if(hasDataKeyField)
{
Array.add(this._dataKeys,dataSource[i][dataKeyField]);}
if(hasSeparatorTemplate)
{
if(i<(dataSourceLength-1))
{
tr=document.createElement('tr');
tbody.appendChild(tr);
td=document.createElement('td');
tr.appendChild(td);
if(hasSeparatorStyle)
{
separatorStyle.apply(td);}
this._addTemplate(td,separatorTemplate,i,$ADC.DataListItemType.Separator,null);}}}}
else
{
var j=0;
if(this.get_repeatDirection()==$ADC.DataListRepeatDirection.Horizontal)
{
while(i<dataSourceLength)
{
tr=document.createElement('tr');
tbody.appendChild(tr);
j=0;
while(j<repeatColumns)
{
if(i>=dataSourceLength)
{
break;}
td=document.createElement('td');
tr.appendChild(td);
if(allowDragAndDrop)
{
this._makeUnselectable(td);}
template=itemTemplate;
itemType=$ADC.DataListItemType.Item;
if(hasAlternateItemTemplate)
{
if(isAlt)
{
template=alternatingItemTemplate;
itemType=$ADC.DataListItemType.AlternatingItem;}}
style=null;
if(isAlt)
{
if(hasAlternatingItemStyle)
{
style=alternatingItemStyle;}
else
{
if(hasItemStyle)
{
style=itemStyle;}}}
else
{
if(hasItemStyle)
{
style=itemStyle;}}
if(i==this._selectedIndex)
{
itemType=$ADC.DataListItemType.SelectedItem;
if(hasSelectedItemTemplate)
{
template=selectedItemTemplate;}
if(hasSelectedItemStyle)
{
style=selectedItemStyle;}}
else if(i==this._editItemIndex)
{
itemType=$ADC.DataListItemType.EditItem;
if(hasEditItemTemplate)
{
template=editItemTemplate;}
if(hasEditItemStyle)
{
style=editItemStyle;}}
if(style!=null)
{
style.apply(td);}
this._addTemplate(td,template,i,itemType,dataSource[i]);
if(hasDataKeyField)
{
Array.add(this._dataKeys,dataSource[i][dataKeyField]);}
isAlt=!isAlt;
i+=1;
j+=1;
if(hasSeparatorTemplate)
{
td=document.createElement('td');
tr.appendChild(td);
if(hasSeparatorStyle)
{
separatorStyle.apply(td);}
this._addTemplate(td,separatorTemplate,i,$ADC.DataListItemType.Separator,null);
j+=1;}}}}
else
{
var dataColumn;
while(i<repeatCount)
{
tr=document.createElement('tr');
tbody.appendChild(tr);
j=0;
dataColumn=0;
while(j<repeatColumns)
{
var index=i;
if(dataColumn>0)
{
index=(dataColumn*repeatCount)+i;}
if(index>=dataSourceLength)
{
break;}
td=document.createElement('td');
tr.appendChild(td);
if(allowDragAndDrop)
{
this._makeUnselectable(td);}
template=itemTemplate;
itemType=$ADC.DataListItemType.Item;
if(index==0)
{
isAlt=false;}
else
{
isAlt=((index%2)!=0);}
if(hasAlternateItemTemplate)
{
if(isAlt)
{
template=alternatingItemTemplate;
itemType=$ADC.DataListItemType.AlternatingItem;}}
style=null;
if(isAlt)
{
if(hasAlternatingItemStyle)
{
style=alternatingItemStyle;}
else
{
if(hasItemStyle)
{
style=itemStyle;}}}
else
{
if(hasItemStyle)
{
style=itemStyle;}}
if(index==this._selectedIndex)
{
itemType=$ADC.DataListItemType.SelectedItem;
if(hasSelectedItemTemplate)
{
template=selectedItemTemplate;}
if(hasSelectedItemStyle)
{
style=selectedItemStyle;}}
else if(index==this._editItemIndex)
{
itemType=$ADC.DataListItemType.EditItem;
if(hasEditItemTemplate)
{
template=editItemTemplate;}
if(hasEditItemStyle)
{
style=editItemStyle;}}
if(style!=null)
{
style.apply(td);}
this._addTemplate(td,template,index,itemType,dataSource[index]);
if(hasDataKeyField)
{
Array.add(this._dataKeys,dataSource[index][dataKeyField]);}
j+=1;
dataColumn+=1;
if(hasSeparatorTemplate)
{
td=document.createElement('td');
tr.appendChild(td);
if(hasSeparatorStyle)
{
separatorStyle.apply(td);}
this._addTemplate(td,separatorTemplate,index,$ADC.DataListItemType.Separator,null);
j+=1;}}
i+=1;}}}
if(this.get_showFooter())
{
var footerTemplate=this.get_footerTemplate();
if(!$ADC.Util.isEmptyString(footerTemplate))
{
var trFooter=document.createElement('tr');
tbody.appendChild(trFooter);
var tdFooter=document.createElement('td');
trFooter.appendChild(tdFooter);
if(repeatColumns>1)
{
tdFooter.colSpan=repeatColumns;}
var footerStyle=this.get_footerStyle();
if(footerStyle!=null)
{
footerStyle.apply(tdFooter);}
this._addTemplate(tdFooter,footerTemplate,-1,$ADC.DataListItemType.Footer,null);}}
if(allowDragAndDrop)
{
this._makeUnselectable(table);}
this._hasBinded=true;
table.style.visibility='visible';
if(animate==true)
{
if(this._canAnimate())
{
if(this._animation==null)
{
this._animation=$ADC.Util.createDataBindAnimation(this.get_animationDuration(),this.get_animationFps(),this);}
if(Sys.Browser.agent==Sys.Browser.InternetExplorer)
{
var backColor=$ADC.Style.getStyleValue(table,'backgroundColor');
if((!backColor)||(backColor=='')||(backColor=='transparent')||(backColor=='rgba(0, 0, 0, 0)'))
{
table.style.backgroundColor=$ADC.Style.getInheritedBackgroundColor(table);}}
this._animation.play();}}},
_addTemplate:function(container,template,index,itemType,dataItem)
{
var controlElement=this.get_element();
var namingContainer=controlElement.id+'$'+itemType+'$'+index;
var item=new $ADC.DataListItem(this,namingContainer,container,index,itemType,dataItem);
var tempElement=document.createElement(container.tagName);
tempElement.innerHTML=template;
var i;
var length=tempElement.childNodes.length;
for(i=0;i<length;i++)
{
this._iterateElements(tempElement.childNodes[i],item);}
if(tempElement.firstChild)
{
while(tempElement.firstChild)
{
container.appendChild(tempElement.firstChild);}}
if(item.get_isDataItemType())
{
item._clickHandler=Function.createCallback(this._raiseCommand,{sender:this,item:item});
$addHandler(container,'click',item._clickHandler);
this.get_items().push(item);}
var handler;
handler=this.get_events().getHandler('itemCreated');
if(handler)
{
handler(this,new $ADC.DataListItemEventArgs(item));}
handler=this.get_events().getHandler('itemDataBound');
if(handler)
{
handler(this,new $ADC.DataListItemEventArgs(item));}},
_iterateElements:function(element,item)
{
item._addControl(element);
var length=element.childNodes.length;
for(var i=0;i<length;i++)
{
this._iterateElements(element.childNodes[i],item);}},
_select:function(index)
{
if((index<0)||(index>(this.get_items().length-1)))
{
throw Error.argumentOutOfRange('index',index,'Specfied index is out of range.');}
if(this._selectedIndex==index)
{
return;}
var selectedItem=this.get_items()[index];
if((selectedItem!=null)&&(selectedItem.get_isDataItemType()))
{
this._selectedIndex=index;
this.raisePropertyChanged('selectedIndexChanged');
var handler=this.get_events().getHandler('selectedIndexChanged');
if(handler)
{
handler(this,Sys.EventArgs.Empty);}
this._internalDataBind(false);}},
_raiseItemDragStart:function(item)
{
var handler=this.get_events().getHandler('itemDragStart');
if(handler)
{
handler(this,new $ADC.DataListItemDragStartEventArgs(item));}},
_raiseItemDropped:function(item,oldIndex,newIndex)
{
var handler=this.get_events().getHandler('itemDropped');
if(handler)
{
handler(this,new $ADC.DataListItemDroppedEventArgs(item,oldIndex,newIndex));}},
_raiseCommand:function(e,context)
{
var commandName='';
var commandArgument='';
if(e.target.commandName)
{
commandName=e.target.commandName;}
else
{
var commandNameAttribute=e.target.attributes['commandName'];
if(commandNameAttribute)
{
if(commandNameAttribute.value)
{
commandName=commandNameAttribute.value;}
else if(commandNameAttribute.nodeValue)
{
commandName=commandNameAttribute.nodeValue;}}}
if(e.target.commandArgument)
{
commandArgument=e.target.commandArgument;}
else
{
var commandArgumentAttribute=e.target.attributes['commandArgument'];
if(commandArgumentAttribute)
{
if(commandArgumentAttribute.value)
{
commandArgument=commandArgumentAttribute.value;}
else if(commandArgumentAttribute.nodeValue)
{
commandArgument=commandArgumentAttribute.nodeValue;}}}
if((commandName.length>0)&&(context.item.get_isDataItemType()))
{
var handler;
if(commandName===context.sender.SelectCommandName)
{
context.sender.set_selectedIndex(context.item.get_itemIndex());}
else if(commandName===context.sender.EditCommandName)
{
handler=context.sender.get_events().getHandler('editCommand');}
else if(commandName===context.sender.UpdateCommandName)
{
handler=context.sender.get_events().getHandler('updateCommand');}
else if(commandName===context.sender.CancelCommandName)
{
handler=context.sender.get_events().getHandler('cancelCommand');}
else if(commandName===context.sender.DeleteCommandName)
{
handler=context.sender.get_events().getHandler('deleteCommand');}
if(handler)
{
handler(context.sender,new $ADC.DataListCommandEventArgs(commandName,commandArgument,e.target,context.item));}
handler=context.sender.get_events().getHandler('itemCommand');
if(handler)
{
handler(context.sender,new $ADC.DataListCommandEventArgs(commandName,commandArgument,e.target,context.item));}}},
_cleanupItems:function()
{
if(this._items.length>0)
{
for(var i=this._items.length-1;i>-1;i--)
{
this._items[i].dispose();
delete this._items[i];}}
Array.clear(this._items);},
_makeUnselectable:function(element)
{
if(Sys.Browser.agent==Sys.Browser.InternetExplorer)
{
element.style.userSelect='none';}
else if(Sys.Browser.agent==Sys.Browser.Safari)
{
element.style.KhtmlUserSelect='none';}
else
{
element.style.MozUserSelect='none';}},
_canAnimate:function()
{
var canAnimate=this.get_animate();
if(canAnimate)
{
canAnimate=$ADC.Util.hasAnimationSupport();}
return canAnimate;}}
$ADC.DataList.registerClass('AjaxDataControls.DataList',Sys.UI.Control);
if(typeof(Sys)!='undefined')
{
Sys.Application.notifyScriptLoaded();}