
Type.registerNamespace('AjaxDataControls');
$ADC.RepeaterItemType=function()
{
throw Error.notImplemented();}
$ADC.RepeaterItemType.prototype=
{
NotSet:0,
Header:1,
Footer:2,
Item:3,
AlternatingItem:4,
Separator:5}
$ADC.RepeaterItemType.registerEnum('AjaxDataControls.RepeaterItemType');
$ADC.RepeaterItem=function(owner,namingContainer,itemIndex,itemType,dataItem)
{
var e=Function._validateParams(arguments,[{name:'owner',type:$ADC.Repeater},{name:'namingContainer',type:String},{name:'itemIndex',type:Number},{name:'itemType',type:$ADC.RepeaterItemType},{name:'dataItem',mayBeNull:true}]);
if(e)throw e;
this._owner=owner;
this._namingContainer=namingContainer;
this._itemIndex=itemIndex;
this._itemType=itemType;
this._dataItem=dataItem;
this._controls=new Array();
this._containers=new Array();
this._commandHandlers=new Array();}
$ADC.RepeaterItem.prototype=
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
(itemType==$ADC.RepeaterItemType.Item)||
(itemType==$ADC.RepeaterItemType.AlternatingItem));},
dispose:function()
{
if(arguments.length!==0)throw Error.parameterCount();
var i=0;
for(i=this._controls.length-1;i>-1;i--)
{
delete this._controls[i];}
Array.clear(this._controls);
if((this._containers.length>0)&&(this._commandHandlers.length>0))
{
for(i=this._containers.length-1;i>-1;i--)
{
$removeHandler(this._containers[i],'click',this._commandHandlers[i]);
delete this._containers[i];
delete this._commandHandlers[i];}}
else
{
if(this._containers.length>0)
{
for(i=this._containers.length-1;i>-1;i--)
{
delete this._containers[i];}}}
Array.clear(this._containers);
Array.clear(this._commandHandlers);
delete this._controls;
delete this._containers;
delete this._commandHandlers;
delete this._owner;},
addControl:function(parentControl,childControl)
{
var e=Function._validateParams(arguments,[{name:'parentControl',type:Object},{name:'childControl',type:Object}]);
if(e)throw e;
this._addControl(childControl);
parentControl.appendChild(childControl);},
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
_addControl:function(childControl)
{
if((childControl.id!=null)&&(childControl.id.length>0))
{
var targetId=(this._namingContainer+'$'+childControl.id);
if(Array.contains(this._controls,targetId))
{
throw Error.invalidOperation('Control of the same id already exists.');}
childControl.id=targetId;
Array.add(this._controls,childControl.id);}}}
$ADC.RepeaterItem.registerClass('AjaxDataControls.RepeaterItem',null,Sys.IDisposable);
$ADC.RepeaterItemEventArgs=function(item)
{
var e=Function._validateParams(arguments,[{name:'item',type:$ADC.RepeaterItem}]);
if(e)throw e;
$ADC.RepeaterItemEventArgs.initializeBase(this);
this._item=item;}
$ADC.RepeaterItemEventArgs.prototype=
{
get_item:function()
{
if(arguments.length!==0)throw Error.parameterCount();
return this._item;}}
$ADC.RepeaterItemEventArgs.registerClass('AjaxDataControls.RepeaterItemEventArgs',Sys.EventArgs);
$ADC.RepeaterCommandEventArgs=function(commandName,commandArgument,commandSource,item)
{
var e=Function._validateParams(arguments,[{name:'commandName',type:String},{name:'commandArgument'},{name:'commandSource',type:Object},{name:'item',type:$ADC.RepeaterItem}]);
if(e)throw e;
$ADC.RepeaterCommandEventArgs.initializeBase(this);
this._commandName=commandName;
this._commandArgument=commandArgument;
this._commandSource=commandSource;
this._item=item;}
$ADC.RepeaterCommandEventArgs.prototype=
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
$ADC.RepeaterCommandEventArgs.registerClass('AjaxDataControls.RepeaterCommandEventArgs',Sys.EventArgs);
$ADC.Repeater=function(element)
{
this._headerTemplate='';
this._itemTemplate='';
this._separatorTemplate='';
this._alternatingItemTemplate='';
this._footerTemplate='';
this._dataSource=null;
this._items=new Array();
this._animate=true
this._animationDuration=0.2;
this._animationFps=20;
this._animation=null;
$ADC.Repeater.initializeBase(this,[element]);}
$ADC.Repeater.prototype=
{
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
this.raisePropertyChanged('dataSource');}},
get_items:function()
{
if(arguments.length!==0)throw Error.parameterCount();
return this._items;},
initialize:function()
{
$ADC.Repeater.callBaseMethod(this,'initialize');},
dispose:function()
{
if(this._animation!=null)
{
this._animation.dispose();}
delete this._animation;
this._clearItems();
delete this._items;
$ADC.Repeater.callBaseMethod(this,'dispose');},
dataBind:function()
{
if(arguments.length!==0)throw Error.parameterCount();
if($ADC.Util.isEmptyString(this.get_itemTemplate()))
{
throw Error.invalidOperation('ItemTemplate must be set before calling this method.');}
var target=this.get_element();
target.style.visibility='hidden';
this._clearItems();
$ADC.Util.clearContent(target);
var headerTemplate=this.get_headerTemplate();
if(!$ADC.Util.isEmptyString(headerTemplate))
{
this._addTemplate(headerTemplate,-1,$ADC.RepeaterItemType.Header,null);}
var dataSource=this.get_dataSource();
if((dataSource!=null)&&(dataSource.length>0))
{
var itemTemplate=this.get_itemTemplate();
var alternatingItemTemplate=this.get_alternatingItemTemplate();
var hasAlternatingItemTemplate=!$ADC.Util.isEmptyString(alternatingItemTemplate);
var separatorTemplate=this.get_separatorTemplate();
var hasSeparatorTemplate=!$ADC.Util.isEmptyString(separatorTemplate);
var isAlt=false;
var itemType=$ADC.RepeaterItemType.Item;
var template;
var length=dataSource.length;
for(var i=0;i<length;i++)
{
var dataItem=dataSource[i];
template=itemTemplate;
if(hasAlternatingItemTemplate)
{
if(isAlt)
{
template=alternatingItemTemplate;
itemType=$ADC.RepeaterItemType.AlternatingItem;}
else
{
itemType=$ADC.RepeaterItemType.Item;}}
this._addTemplate(template,i,itemType,dataItem);
isAlt=!isAlt;
if((hasSeparatorTemplate)&&(i!=(length-1)))
{
this._addTemplate(separatorTemplate,i,$ADC.RepeaterItemType.Separator,null);}}}
var footerTemplate=this.get_footerTemplate();
if(!$ADC.Util.isEmptyString(footerTemplate))
{
this._addTemplate(footerTemplate,-1,$ADC.RepeaterItemType.Footer,null);}
target.style.visibility='visible';
if(this._canAnimate())
{
if(this._animation==null)
{
this._animation=$ADC.Util.createDataBindAnimation(this.get_animationDuration(),this.get_animationFps(),this);}
if(Sys.Browser.agent==Sys.Browser.InternetExplorer)
{
var backColor=$ADC.Style.getStyleValue(target,'backgroundColor');
if((!backColor)||(backColor=='')||(backColor=='transparent')||(backColor=='rgba(0, 0, 0, 0)'))
{
target.style.backgroundColor=$ADC.Style.getInheritedBackgroundColor(target);}}
this._animation.play();}},
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
_addTemplate:function(template,index,itemType,dataItem)
{
var controlElement=this.get_element();
var namingContainer=controlElement.id+'$'+itemType+'$'+index;
var item=new $ADC.RepeaterItem(this,namingContainer,index,itemType,dataItem);
var tempElement=document.createElement(controlElement.tagName);
tempElement.innerHTML=template;
var length=tempElement.childNodes.length;
for(i=0;i<length;i++)
{
this._iterateElements(tempElement.childNodes[i],item);}
var clickHandler;
var firstChild;
var isDataItemType=item.get_isDataItemType();
if(tempElement.firstChild)
{
while(tempElement.firstChild)
{
firstChild=tempElement.firstChild;
controlElement.appendChild(firstChild);
if(isDataItemType)
{
clickHandler=Function.createCallback(this._raiseCommand,{sender:this,item:item});
$addHandler(firstChild,'click',clickHandler);
Array.add(item._containers,firstChild);
Array.add(item._commandHandlers,clickHandler);}}}
if(isDataItemType)
{
this.get_items().push(item);}
var handler;
handler=this.get_events().getHandler('itemCreated');
if(handler)
{
handler(this,new $ADC.RepeaterItemEventArgs(item));}
handler=this.get_events().getHandler('itemDataBound');
if(handler)
{
handler(this,new $ADC.RepeaterItemEventArgs(item));}},
_iterateElements:function(element,item)
{
item._addControl(element);
var length=element.childNodes.length;
for(var i=0;i<length;i++)
{
this._iterateElements(element.childNodes[i],item);}},
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
var handler=context.sender.get_events().getHandler('itemCommand');
if(handler)
{
handler(context.sender,new $ADC.RepeaterCommandEventArgs(commandName,commandArgument,e.target,context.item));}}},
_clearItems:function()
{
if(this._items.length>0)
{
for(var i=this._items.length-1;i>-1;i--)
{
this._items[i].dispose();
delete this._items[i];}}
Array.clear(this._items);},
_canAnimate:function()
{
var canAnimate=this.get_animate();
if(canAnimate)
{
canAnimate=$ADC.Util.hasAnimationSupport();}
return canAnimate;}}
$ADC.Repeater.registerClass('AjaxDataControls.Repeater',Sys.UI.Control);
if(typeof(Sys)!='undefined')
{
Sys.Application.notifyScriptLoaded();}