
Type.registerNamespace('AjaxDataControls');
$ADC.GridViewImageColumn=function()
{
this._alternateText='';
this._dataAlternateTextField='';
this._dataImageUrlField='';
this._dataImageUrlFormatString='';
this._dataAlternateTextFormatString='';
this._nullDisplayText='';
this._nullImageUrl='';
$ADC.GridViewImageColumn.initializeBase(this);}
$ADC.GridViewImageColumn.prototype=
{
get_alternateText:function()
{
if(arguments.length!==0)throw Error.parameterCount();
return this._alternateText;},
set_alternateText:function(value)
{
var e=Function._validateParams(arguments,[{name:'value',type:String}]);
if(e)throw e;
if(this._alternateText!=value)
{
this._alternateText=value;
this.raisePropertyChanged('alternateText');}},
get_dataAlternateTextField:function()
{
if(arguments.length!==0)throw Error.parameterCount();
return this._dataAlternateTextField;},
set_dataAlternateTextField:function(value)
{
var e=Function._validateParams(arguments,[{name:'value',type:String}]);
if(e)throw e;
if(this._dataAlternateTextField!=value)
{
this._dataAlternateTextField=value;
this.raisePropertyChanged('dataAlternateTextField');}},
get_dataAlternateTextFormatString:function()
{
if(arguments.length!==0)throw Error.parameterCount();
return this._dataAlternateTextFormatString;},
set_dataAlternateTextFormatString:function(value)
{
var e=Function._validateParams(arguments,[{name:'value',type:String}]);
if(e)throw e;
if(this._dataAlternateTextFormatString!=value)
{
this._dataAlternateTextFormatString=value;
this.raisePropertyChanged('dataAlternateTextFormatString');}},
get_dataImageUrlField:function()
{
if(arguments.length!==0)throw Error.parameterCount();
return this._dataImageUrlField;},
set_dataImageUrlField:function(value)
{
var e=Function._validateParams(arguments,[{name:'value',type:String}]);
if(e)throw e;
if(this._dataImageUrlField!=value)
{
this._dataImageUrlField=value;
this.raisePropertyChanged('dataImageUrlField');}},
get_dataImageUrlFormatString:function()
{
if(arguments.length!==0)throw Error.parameterCount();
return this._dataImageUrlFormatString;},
set_dataImageUrlFormatString:function(value)
{
var e=Function._validateParams(arguments,[{name:'value',type:String}]);
if(e)throw e;
if(this._dataImageUrlFormatString!=value)
{
this._dataImageUrlFormatString=value;
this.raisePropertyChanged('dataImageUrlFormatString');}},
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
get_nullImageUrl:function()
{
if(arguments.length!==0)throw Error.parameterCount();
return this._nullImageUrl;},
set_nullImageUrl:function(value)
{
var e=Function._validateParams(arguments,[{name:'value',type:String}]);
if(e)throw e;
if(this._nullImageUrl!=value)
{
this._nullImageUrl=value;
this.raisePropertyChanged('nullImageUrl');}},
initialize:function()
{
$ADC.GridViewImageColumn.callBaseMethod(this,'initialize');},
dispose:function()
{
$ADC.GridViewImageColumn.callBaseMethod(this,'dispose');},
renderData:function(dataRow,row,container)
{
var e=Function._validateParams(arguments,[{name:'dataRow',type:Object},{name:'row',type:$ADC.GridViewRow},{name:'container',type:Object}]);
if(e)throw e;
var value=null;
var dataField=this.get_dataImageUrlField();
if(!$ADC.Util.isEmptyString(dataField))
{
value=dataRow[dataField];}
if(value!=null)
{
var dataFormatString=this.get_dataImageUrlFormatString();
if(!$ADC.Util.isEmptyString(dataFormatString))
{
value=value.format(dataFormatString);}}
else
{
var nullImageUrl=this.get_nullImageUrl;
if(!$ADC.Util.isEmptyString(nullImageUrl))
{
value=nullImageUrl;}}
if(value==null)
{
var nullDisplayText=get_nullDisplayText();
if(!$ADC.Util.isEmptyString(nullDisplayText))
{
container.appendChild(document.createTextNode(nullDisplayText));}}
else
{
var alt=null;
var alternateTextField=this.get_dataAlternateTextField();
if(!$ADC.Util.isEmptyString(alternateTextField))
{
alt=dataRow[alternateTextField];}
if(alt!=null)
{
var alternateTextFormatString=this.get_dataAlternateTextFormatString();
if(!$ADC.Util.isEmptyString(alternateTextFormatString))
{
alt=alt.format(alternateTextFormatString);}}
else
{
var alternateText=this.get_alternateText();
if(!$ADC.Util.isEmptyString(alternateText))
{
alt=alternateText;}}
if(value==null)
{
value='';}
if(alt==null)
{
alt='';}
var img=document.createElement('img');
img.setAttribute('alt',alt);
img.setAttribute('src',value);
container.appendChild(img);
if(this.get_controlStyle()!=null)
{
this.get_controlStyle().apply(img);}}
if(this.get_itemStyle()!=null)
{
this.get_itemStyle().apply(container);}}}
$ADC.GridViewImageColumn.registerClass('AjaxDataControls.GridViewImageColumn',$ADC.GridViewBaseColumn);
if(typeof(Sys)!='undefined')
{
Sys.Application.notifyScriptLoaded();}