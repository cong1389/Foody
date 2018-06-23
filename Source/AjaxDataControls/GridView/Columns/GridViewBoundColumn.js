
Type.registerNamespace('AjaxDataControls');
$ADC.GridViewBoundColumn=function()
{
this._applyFormatInEditMode=false;
this._dataField='';
this._dataFormatString='';
this._nullDisplayText='';
this._readOnly=false;
$ADC.GridViewBoundColumn.initializeBase(this);}
$ADC.GridViewBoundColumn.prototype=
{
get_applyFormatInEditMode:function()
{
if(arguments.length!==0)throw Error.parameterCount();
return this._applyFormatInEditMode;},
set_applyFormatInEditMode:function(value)
{
var e=Function._validateParams(arguments,[{name:'value',type:Boolean}]);
if(e)throw e;
if(this._applyFormatInEditMode!=value)
{
this._applyFormatInEditMode=value;
this.raisePropertyChanged('applyFormatInEditMode');}},
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
get_dataFormatString:function()
{
if(arguments.length!==0)throw Error.parameterCount();
return this._dataFormatString;},
set_dataFormatString:function(value)
{
var e=Function._validateParams(arguments,[{name:'value',type:String}]);
if(e)throw e;
if(this._dataFormatString!=value)
{
this._dataFormatString=value;
this.raisePropertyChanged('dataFormatString');}},
get_nullDisplayText:function()
{
if(arguments.length!==0)throw Error.parameterCount();
return this._nullDisplayText;},
set_nullDisplayText:function(value)
{
var e=Function._validateParams(arguments,[{name:'value',type:String}]);
if(e)throw e;
if(this._nullDisplayText!=value)
{
this._nullDisplayText=value;
this.raisePropertyChanged('nullDisplayText');}},
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
initialize:function()
{
$ADC.GridViewBoundColumn.callBaseMethod(this,'initialize');},
dispose:function()
{
$ADC.GridViewBoundColumn.callBaseMethod(this,'dispose');},
renderData:function(dataRow,row,container)
{
var e=Function._validateParams(arguments,[{name:'dataRow',type:Object},{name:'row',type:$ADC.GridViewRow},{name:'container',type:Object}]);
if(e)throw e;
var value=null;
var dataField=this.get_dataField();
var dataFormatString=this.get_dataFormatString();
if(!$ADC.Util.isEmptyString(dataField))
{
value=dataRow[dataField];}
if((row.get_rowType()==$ADC.GridViewRowType.EditRow)&&(this.get_readOnly()==false))
{
if(this.get_applyFormatInEditMode()==true)
{
if(!$ADC.Util.isEmptyString(dataFormatString))
{
value=value.localeFormat(dataFormatString);}}
if(value==null)
{
value='';}
var textbox=document.createElement('input');
textbox.setAttribute('type','text');
textbox.setAttribute('value',value);
container.appendChild(textbox);
if(this.get_controlStyle()!=null)
{
this.get_controlStyle().apply(textbox);}}
else
{
if(value==null)
{
var nullDisplayText=this.get_nullDisplayText();
if(!$ADC.Util.isEmptyString(nullDisplayText))
{
value=nullDisplayText;}}
else
{
if(!$ADC.Util.isEmptyString(dataFormatString))
{
value=value.localeFormat(dataFormatString);}}
if(value==null)
{
value='';}
container.appendChild(document.createTextNode(value));}
if(this.get_itemStyle()!=null)
{
this.get_itemStyle().apply(container);}}}
$ADC.GridViewBoundColumn.registerClass('AjaxDataControls.GridViewBoundColumn',$ADC.GridViewBaseColumn);
if(typeof(Sys)!='undefined')
{
Sys.Application.notifyScriptLoaded();}