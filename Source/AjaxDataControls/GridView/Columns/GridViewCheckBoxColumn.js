
Type.registerNamespace('AjaxDataControls');
$ADC.GridViewCheckBoxColumn=function()
{
this._text='';
this._dataField='';
this._readOnly=false;
$ADC.GridViewCheckBoxColumn.initializeBase(this);
$ADC.GridViewCheckBoxColumn.callBaseMethod(this,'set_allowDragAndDrop',[false]);}
$ADC.GridViewCheckBoxColumn.prototype=
{
get_dataField:function()
{
if(arguments.length!==0)throw Error.parameterCount();
return this._dataField;},
set_dataField:function(value)
{
var e=Function._validateParams(arguments,[{name:'value',type:String}]);
if(e)throw e;
if(this._dataField!=value)
{
this._dataField=value;
this.raisePropertyChanged('dataField');}},
get_readOnly:function()
{
if(arguments.length!==0)throw Error.parameterCount();
return this._readOnly;},
set_readOnly:function(value)
{
var e=Function._validateParams(arguments,[{name:'value',type:Boolean}]);
if(e)throw e;
if(this._readOnly!=value)
{
this._readOnly=value;
this.raisePropertyChanged('readOnly');}},
get_text:function()
{
if(arguments.length!==0)throw Error.parameterCount();
return this._text;},
set_text:function(value)
{
var e=Function._validateParams(arguments,[{name:'value',type:String}]);
if(e)throw e;
if(this._text!=value)
{
this._text=value;
this.raisePropertyChanged('text');}},
initialize:function()
{
$ADC.GridViewCheckBoxColumn.callBaseMethod(this,'initialize');},
dispose:function()
{
$ADC.GridViewCheckBoxColumn.callBaseMethod(this,'dispose');},
renderData:function(dataRow,row,container)
{
var e=Function._validateParams(arguments,[{name:'dataRow',type:Object},{name:'row',type:$ADC.GridViewRow},{name:'container',type:Object}]);
if(e)throw e;
var value=null;
var dataField=this.get_dataField();
if(!$ADC.Util.isEmptyString(dataField))
{
value=dataRow[dataField];}
if(value!=null)
{
var checkbox=document.createElement('input');
checkbox.setAttribute('type','checkbox');
if((row.get_rowType()==$ADC.GridViewRowType.EditRow)&&(this.get_readOnly()==false))
{}
else
{
checkbox.setAttribute('disabled','true');}
var text=this.get_text();
if(!$ADC.Util.isEmptyString(text))
{
var lbl=document.createElement('label');
lbl.appendChild(checkbox);
lbl.appendChild(document.createTextNode(text));
container.appendChild(lbl);}
else
{
container.appendChild(checkbox);}
if(value==true)
{
checkbox.setAttribute('checked','true');}
if(this.get_controlStyle()!=null)
{
this.get_controlStyle().apply(checkbox);}}
if(this.get_itemStyle()!=null)
{
this.get_itemStyle().apply(container);}}}
$ADC.GridViewCheckBoxColumn.registerClass('AjaxDataControls.GridViewCheckBoxColumn',$ADC.GridViewBaseColumn);
if(typeof(Sys)!='undefined')
{
Sys.Application.notifyScriptLoaded();}