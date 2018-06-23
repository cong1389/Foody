
Type.registerNamespace('AjaxDataControls');
$ADC.GridViewRadioButtonColumn=function()
{
this._groupName='';
this._text='';
$ADC.GridViewRadioButtonColumn.initializeBase(this);
$ADC.GridViewRadioButtonColumn.callBaseMethod(this,'set_allowDragAndDrop',[false]);}
$ADC.GridViewRadioButtonColumn.prototype=
{
get_groupName:function()
{
if(arguments.length!==0)throw Error.parameterCount();
return this._groupName;},
set_groupName:function(value)
{
var e=Function._validateParams(arguments,[{name:'value',type:String}]);
if(e)throw e;
if(this._groupName!=value)
{
this._groupName=value;
this.raisePropertyChanged('groupName');}},
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
get_sortField:function()
{
if(arguments.length!==0)throw Error.parameterCount();
return'';},
set_sortField:function(value)
{},
initialize:function()
{
$ADC.GridViewRadioButtonColumn.callBaseMethod(this,'initialize');},
dispose:function()
{
$ADC.GridViewRadioButtonColumn.callBaseMethod(this,'dispose');},
renderData:function(dataRow,row,container)
{
var e=Function._validateParams(arguments,[{name:'dataRow',type:Object},{name:'row',type:$ADC.GridViewRow},{name:'container',type:Object}]);
if(e)throw e;
var groupName=this.get_groupName();
if($ADC.Util.isEmptyString(groupName))
{
throw Error.invalidOperation('Group name must be set for the column.');}
groupName=this.get_owner().get_id()+groupName;
var radioButton;
if(Sys.Browser.agent==Sys.Browser.InternetExplorer)
{
radioButton=document.createElement('<input name=\"'+groupName+'\">');}
else
{
radioButton=document.createElement('input');
radioButton.setAttribute('name',groupName);}
radioButton.setAttribute('type','radio');
var text=this.get_text();
if(!$ADC.Util.isEmptyString(groupName))
{
var lbl=document.createElement('label');
lbl.appendChild(radioButton);
lbl.appendChild(document.createTextNode(text));
container.appendChild(lbl);}
else
{
container.appendChild(radioButton);}
if(this.get_controlStyle()!=null)
{
this.get_controlStyle().apply(radioButton);}
if(this.get_itemStyle()!=null)
{
this.get_itemStyle().apply(container);}}}
$ADC.GridViewRadioButtonColumn.registerClass('AjaxDataControls.GridViewRadioButtonColumn',$ADC.GridViewBaseColumn);
if(typeof(Sys)!='undefined')
{
Sys.Application.notifyScriptLoaded();}