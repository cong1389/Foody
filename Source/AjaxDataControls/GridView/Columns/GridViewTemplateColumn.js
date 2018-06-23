
Type.registerNamespace('AjaxDataControls');
$ADC.GridViewTemplateColumn=function()
{
this._headerTemplate='';
this._itemTemplate='';
this._alternatingItemTemplate='';
this._footerTemplate='';
this._editItemTemplate='';
this._cells=new Array();
this._clickHandlers=new Array();
$ADC.GridViewTemplateColumn.initializeBase(this);}
$ADC.GridViewTemplateColumn.prototype=
{
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
initialize:function()
{
$ADC.GridViewTemplateColumn.callBaseMethod(this,'initialize');},
dispose:function()
{
$ADC.GridViewTemplateColumn.callBaseMethod(this,'dispose');
delete this._cells;
delete this._clickHandlers;},
renderHeader:function(row)
{
var e=Function._validateParams(arguments,[{name:'row',type:$ADC.GridViewRow}]);
if(e)throw e;
var headerTemplate=this.get_headerTemplate();
if(!$ADC.Util.isEmptyString(headerTemplate))
{
var container=this.get_headerContainer();
if(container==null)
{
throw Error.invalidOperation('Header container must be set before calling this method.');}
this._addTemplate(container,headerTemplate,row);
if(this.get_headerStyle()!=null)
{
this.get_headerStyle().apply(container);}}
else
{
$ADC.GridViewTemplateColumn.callBaseMethod(this,'renderHeader',[row]);}},
renderData:function(dataRow,row,container)
{
var e=Function._validateParams(arguments,[{name:'dataRow',type:Object},{name:'row',type:$ADC.GridViewRow},{name:'container',type:Object}]);
if(e)throw e;
var owner=this.get_owner();
if(owner==null)
{
throw Error.invalidOperation('Owner must be set before calling this method.');}
var template=null;
if(row.get_rowType()==$ADC.GridViewRowType.AlternatingRow)
{
template=this.get_alternatingItemTemplate();}
else if(row.get_rowType()==$ADC.GridViewRowType.EditRow)
{
template=this.get_editItemTemplate();}
if($ADC.Util.isEmptyString(template))
{
template=this.get_itemTemplate();}
if(!$ADC.Util.isEmptyString(template))
{
this._addTemplate(container,template,row);
var clickHandler=Function.createCallback(owner._raiseCommand,{sender:owner,row:row});
$addHandler(container,'click',clickHandler);
Array.add(this._cells,container);
Array.add(this._clickHandlers,clickHandler);}
if(this.get_itemStyle()!=null)
{
this.get_itemStyle().apply(container);}},
renderFooter:function(row)
{
var e=Function._validateParams(arguments,[{name:'row',type:$ADC.GridViewRow}]);
if(e)throw e;
var footerTemplate=this.get_footerTemplate();
if(!$ADC.Util.isEmptyString(footerTemplate))
{
var container=this.get_footerContainer();
if(container==null)
{
throw Error.invalidOperation('Footer container must be set before calling this method.');}
this._addTemplate(container,footerTemplate,row);
if(this.get_footerStyle()!=null)
{
this.get_footerStyle().apply(container);}}
else
{
$ADC.GridViewTemplateColumn.callBaseMethod(this,'renderFooter',[row]);}},
releaseResource:function()
{
$ADC.GridViewTemplateColumn.callBaseMethod(this,'releaseResource');
if((this._cells.length>0)&&(this._clickHandlers.length>0))
{
for(var i=this._cells.length-1;i>-1;i--)
{
$removeHandler(this._cells[i],'click',this._clickHandlers[i]);
delete this._cells[i];
delete this._clickHandlers[i];}}
Array.clear(this._cells);
Array.clear(this._clickHandlers);},
_addTemplate:function(container,template,row)
{
var tempElement=document.createElement(container.tagName);
tempElement.innerHTML=template;
var i;
var length=tempElement.childNodes.length;
for(i=0;i<length;i++)
{
this._iterateElements(tempElement.childNodes[i],row);}
if(tempElement.firstChild)
{
while(tempElement.firstChild)
{
container.appendChild(tempElement.firstChild);}}},
_iterateElements:function(element,row)
{
row._addControl(element);
var length=element.childNodes.length;
for(var i=0;i<length;i++)
{
this._iterateElements(element.childNodes[i],row);}}}
$ADC.GridViewTemplateColumn.registerClass('AjaxDataControls.GridViewTemplateColumn',$ADC.GridViewBaseColumn);
if(typeof(Sys)!='undefined')
{
Sys.Application.notifyScriptLoaded();}