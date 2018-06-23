
Type.registerNamespace('AjaxDataControls');
$ADC.GridViewHyperLinkColumn=function()
{
this._dataTextField='';
this._dataTextFormatString='';
this._dataNavigateUrlFields='';
this._dataNavigateUrlFormatString='';
this._target='';
this._navigateUrl='';
this._text='';
$ADC.GridViewHyperLinkColumn.initializeBase(this);}
$ADC.GridViewHyperLinkColumn.prototype=
{
get_dataTextField:function()
{
if(arguments.length!==0)throw Error.parameterCount();
return this._dataTextField;},
set_dataTextField:function(value)
{
var e=Function._validateParams(arguments,[{name:'value',type:String}]);
if(e)throw e;
if(this._dataTextField!=value)
{
this._dataTextField=value;
this.raisePropertyChanged('dataTextField');}},
get_dataTextFormatString:function()
{
if(arguments.length!==0)throw Error.parameterCount();
return this._dataFormatString;},
set_dataTextFormatString:function(value)
{
var e=Function._validateParams(arguments,[{name:'value',type:String}]);
if(e)throw e;
if(this._dataTextFormatString!=value)
{
this._dataTextFormatString=value;
this.raisePropertyChanged('dataTextFormatString');}},
get_dataNavigateUrlFields:function()
{
if(arguments.length!==0)throw Error.parameterCount();
return this._dataNavigateUrlFields;},
set_dataNavigateUrlFields:function(value)
{
var e=Function._validateParams(arguments,[{name:'value',type:String}]);
if(e)throw e;
if(this._dataNavigateUrlFields!=value)
{
this._dataNavigateUrlFields=value;
this.raisePropertyChanged('dataNavigateUrlFields');}},
get_dataNavigateUrlFormatString:function()
{
if(arguments.length!==0)throw Error.parameterCount();
return this._dataNavigateUrlFormatString;},
set_dataNavigateUrlFormatString:function(value)
{
var e=Function._validateParams(arguments,[{name:'value',type:String}]);
if(e)throw e;
if(this._dataNavigateUrlFormatString!=value)
{
this._dataNavigateUrlFormatString=value;
this.raisePropertyChanged('dataNavigateUrlFormatString');}},
get_target:function()
{
if(arguments.length!==0)throw Error.parameterCount();
return this._target;},
set_target:function(value)
{
var e=Function._validateParams(arguments,[{name:'value',type:String}]);
if(e)throw e;
if(this._target!=value)
{
this._target=value;
this.raisePropertyChanged('target');}},
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
get_navigateUrl:function()
{
if(arguments.length!==0)throw Error.parameterCount();
return this._navigateUrl;},
set_navigateUrl:function(value)
{
var e=Function._validateParams(arguments,[{name:'value',type:String}]);
if(e)throw e;
if(this._navigateUrl!=value)
{
this._navigateUrl=value;
this.raisePropertyChanged('navigateUrl');}},
initialize:function()
{
$ADC.GridViewHyperLinkColumn.callBaseMethod(this,'initialize');},
dispose:function()
{
$ADC.GridViewHyperLinkColumn.callBaseMethod(this,'dispose');},
renderData:function(dataRow,row,container)
{
var e=Function._validateParams(arguments,[{name:'dataRow',type:Object},{name:'row',type:$ADC.GridViewRow},{name:'container',type:Object}]);
if(e)throw e;
var value=null;
var dataField=this.get_dataTextField();
var dataFormatString=this.get_dataTextFormatString();
if(!$ADC.Util.isEmptyString(dataField))
{
value=dataRow[dataField];}
if(value==null)
{
var text=this.get_text();
if(!$ADC.Util.isEmptyString(text))
{
value=text;}
else
{
value='';}}
else
{
if(!$ADC.Util.isEmptyString(dataFormatString))
{
value=value.localeFormat(dataFormatString);}}
var url=null;
var dataNavigateUrlFields=this.get_dataNavigateUrlFields();
if((dataNavigateUrlFields!=null)&&(dataNavigateUrlFields.length>0))
{
var fields=dataNavigateUrlFields.split(',');
if((fields!=null)&&(fields.length>0))
{
var values=new Array();
var field;
for(var j=0;j<fields.length;j++)
{
field=fields[j].trim();
if(field.length>0)
{
Array.add(values,dataRow[field]);}}
if(values.length>0)
{
url=String.format(this.get_dataNavigateUrlFormatString(),values);}}}
else
{
var navigateUrl=this.get_navigateUrl();
if(!$ADC.Util.isEmptyString(navigateUrl))
{
url=navigateUrl;}}
if(url==null)
{
url='';}
var link=document.createElement('a');
link.appendChild(document.createTextNode(value));
link.setAttribute('href',url);
var target=this.get_target();
if(!$ADC.Util.isEmptyString(target))
{
link.setAttribute('target',target);}
container.appendChild(link);
if(this.get_controlStyle()!=null)
{
this.get_controlStyle().apply(link);}
if(this.get_itemStyle()!=null)
{
this.get_itemStyle().apply(container);}}}
$ADC.GridViewHyperLinkColumn.registerClass('AjaxDataControls.GridViewHyperLinkColumn',$ADC.GridViewBaseColumn);
if(typeof(Sys)!='undefined')
{
Sys.Application.notifyScriptLoaded();}