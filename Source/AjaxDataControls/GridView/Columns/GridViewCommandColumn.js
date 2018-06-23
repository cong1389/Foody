
Type.registerNamespace('AjaxDataControls');
$ADC.GridViewCommandColumn=function()
{
this._buttonType=$ADC.GridViewColumnButtonType.Link;
this._cancelImageUrl='';
this._cancelText='Cancel';
this._deleteImageUrl='';
this._deleteText='Delete';
this._editImageUrl='';
this._editText='Edit';
this._selectImageUrl='';
this._selectText='Select';
this._updateImageUrl='';
this._updateText='Update';
this._showCancelButton=true;
this._showDeleteButton=false;
this._showEditButton=false;
this._showSelectButton=false;
this._cancelButtons=new Array();
this._cancelClickHandlers=new Array();
this._deleteButtons=new Array();
this._deleteClickHandlers=new Array();
this._editButtons=new Array();
this._editClickHandlers=new Array();
this._selectButtons=new Array();
this._selectClickHandlers=new Array();
this._updateButtons=new Array();
this._updateClickHandlers=new Array();
$ADC.GridViewCommandColumn.initializeBase(this);
$ADC.GridViewCommandColumn.callBaseMethod(this,'set_allowDragAndDrop',[false]);}
$ADC.GridViewCommandColumn.prototype=
{
get_buttonType:function()
{
if(arguments.length!==0)throw Error.parameterCount();
return this._buttonType;},
set_buttonType:function(value)
{
var e=Function._validateParams(arguments,[{name:'value',type:$ADC.GridViewColumnButtonType}]);
if(e)throw e;
if(this._buttonType!=value)
{
this._buttonType=value;
this.raisePropertyChanged('buttonType');}},
get_cancelImageUrl:function()
{
if(arguments.length!==0)throw Error.parameterCount();
return this._cancelImageUrl;},
set_cancelImageUrl:function(value)
{
var e=Function._validateParams(arguments,[{name:'value',type:String}]);
if(e)throw e;
if(this._cancelImageUrl!=value)
{
this._cancelImageUrl=value;
this.raisePropertyChanged('cancelImageUrl');}},
get_cancelText:function()
{
if(arguments.length!==0)throw Error.parameterCount();
return this._cancelText;},
set_cancelText:function(value)
{
var e=Function._validateParams(arguments,[{name:'value',type:String}]);
if(e)throw e;
if(this._cancelText!=value)
{
this._cancelText=value;
this.raisePropertyChanged('cancelText');}},
get_deleteImageUrl:function()
{
if(arguments.length!==0)throw Error.parameterCount();
return this._deleteImageUrl;},
set_deleteImageUrl:function(value)
{
var e=Function._validateParams(arguments,[{name:'value',type:String}]);
if(e)throw e;
if(this._deleteImageUrl!=value)
{
this._deleteImageUrl=value;
this.raisePropertyChanged('deleteImageUrl');}},
get_deleteText:function()
{
if(arguments.length!==0)throw Error.parameterCount();
return this._deleteText;},
set_deleteText:function(value)
{
var e=Function._validateParams(arguments,[{name:'value',type:String}]);
if(e)throw e;
if(this._deleteText!=value)
{
this._deleteText=value;
this.raisePropertyChanged('deleteText');}},
get_editImageUrl:function()
{
if(arguments.length!==0)throw Error.parameterCount();
return this._editImageUrl;},
set_editImageUrl:function(value)
{
var e=Function._validateParams(arguments,[{name:'value',type:String}]);
if(e)throw e;
if(this._editImageUrl!=value)
{
this._editImageUrl=value;
this.raisePropertyChanged('editImageUrl');}},
get_editText:function()
{
if(arguments.length!==0)throw Error.parameterCount();
return this._editText;},
set_editText:function(value)
{
var e=Function._validateParams(arguments,[{name:'value',type:String}]);
if(e)throw e;
if(this._editText!=value)
{
this._editText=value;
this.raisePropertyChanged('editText');}},
get_selectImageUrl:function()
{
if(arguments.length!==0)throw Error.parameterCount();
return this._selectImageUrl;},
set_selectImageUrl:function(value)
{
var e=Function._validateParams(arguments,[{name:'value',type:String}]);
if(e)throw e;
if(this._selectImageUrl!=value)
{
this._selectImageUrl=value;
this.raisePropertyChanged('selectImageUrl');}},
get_selectText:function()
{
if(arguments.length!==0)throw Error.parameterCount();
return this._selectText;},
set_selectText:function(value)
{
var e=Function._validateParams(arguments,[{name:'value',type:String}]);
if(e)throw e;
if(this._selectText!=value)
{
this._selectText=value;
this.raisePropertyChanged('selectText');}},
get_updateImageUrl:function()
{
if(arguments.length!==0)throw Error.parameterCount();
return this._updateImageUrl;},
set_updateImageUrl:function(value)
{
var e=Function._validateParams(arguments,[{name:'value',type:String}]);
if(e)throw e;
if(this._updateImageUrl!=value)
{
this._updateImageUrl=value;
this.raisePropertyChanged('updateImageUrl');}},
get_updateText:function()
{
if(arguments.length!==0)throw Error.parameterCount();
return this._updateText;},
set_updateText:function(value)
{
var e=Function._validateParams(arguments,[{name:'value',type:String}]);
if(e)throw e;
if(this._updateText!=value)
{
this._updateText=value;
this.raisePropertyChanged('updateText');}},
get_showCancelButton:function()
{
if(arguments.length!==0)throw Error.parameterCount();
return this._showCancelButton;},
set_showCancelButton:function(value)
{
var e=Function._validateParams(arguments,[{name:'value',type:Boolean}]);
if(e)throw e;
if(this._showCancelButton!=value)
{
this._showCancelButton=value;
this.raisePropertyChanged('showCancelButton');}},
get_showDeleteButton:function()
{
if(arguments.length!==0)throw Error.parameterCount();
return this._showDeleteButton;},
set_showDeleteButton:function(value)
{
var e=Function._validateParams(arguments,[{name:'value',type:Boolean}]);
if(e)throw e;
if(this._showDeleteButton!=value)
{
this._showDeleteButton=value;
this.raisePropertyChanged('showDeleteButton');}},
get_showEditButton:function()
{
if(arguments.length!==0)throw Error.parameterCount();
return this._showEditButton;},
set_showEditButton:function(value)
{
var e=Function._validateParams(arguments,[{name:'value',type:Boolean}]);
if(e)throw e;
if(this._showEditButton!=value)
{
this._showEditButton=value;
this.raisePropertyChanged('showEditButton');}},
get_showSelectButton:function()
{
if(arguments.length!==0)throw Error.parameterCount();
return this._showSelectButton;},
set_showSelectButton:function(value)
{
var e=Function._validateParams(arguments,[{name:'value',type:Boolean}]);
if(e)throw e;
if(this._showSelectButton!=value)
{
this._showSelectButton=value;
this.raisePropertyChanged('showSelectButton');}},
initialize:function()
{
$ADC.GridViewCommandColumn.callBaseMethod(this,'initialize');},
dispose:function()
{
$ADC.GridViewCommandColumn.callBaseMethod(this,'dispose');
delete this._cancelButtons;
delete this._cancelClickHandlers;
delete this._deleteButtons;
delete this._deleteClickHandlers;
delete this._editButtons;
delete this._editClickHandlers;
delete this._selectButtons;
delete this._selectClickHandlers;
delete this._updateButtons;
delete this._updateClickHandlers;},
renderData:function(dataRow,row,container)
{
var e=Function._validateParams(arguments,[{name:'dataRow',type:Object},{name:'row',type:$ADC.GridViewRow},{name:'container',type:Object}]);
if(e)throw e;
var owner=this.get_owner();
var buttonType=this.get_buttonType();
var controlStyle=this.get_controlStyle();
var button;
var clickHandler;
if((row.get_rowType()==$ADC.GridViewRowType.EditRow))
{
if(this.get_showEditButton()==true)
{
button=this._createButton(buttonType,this.get_updateText(),this.get_updateImageUrl(),controlStyle);
button.commandName=owner.UpdateCommandName;
button.commandArgument=row.get_rowIndex();
container.appendChild(button);
clickHandler=Function.createCallback(owner._raiseCommand,{sender:owner,row:row});
$addHandler(button,'click',clickHandler);
Array.add(this._updateButtons,button);
Array.add(this._updateClickHandlers,clickHandler);
if(this.get_showCancelButton()==true)
{
button=this._createButton(buttonType,this.get_cancelText(),this.get_cancelImageUrl(),controlStyle);
button.commandName=owner.CancelCommandName;
button.commandArgument=row.get_rowIndex();
container.appendChild(document.createTextNode(' '));
container.appendChild(button);
clickHandler=Function.createCallback(owner._raiseCommand,{sender:owner,row:row});
$addHandler(button,'click',clickHandler);
Array.add(this._cancelButtons,button);
Array.add(this._cancelClickHandlers,clickHandler);}}}
else
{
var addSpace=false;
if(this.get_showEditButton()==true)
{
button=this._createButton(buttonType,this.get_editText(),this.get_editImageUrl(),controlStyle);
button.commandName=owner.EditCommandName;
button.commandArgument=row.get_rowIndex();
container.appendChild(button);
clickHandler=Function.createCallback(owner._raiseCommand,{sender:owner,row:row});
$addHandler(button,'click',clickHandler);
Array.add(this._editButtons,button);
Array.add(this._editClickHandlers,clickHandler);
addSpace=true;}
if(this.get_showDeleteButton()==true)
{
button=this._createButton(buttonType,this.get_deleteText(),this.get_deleteImageUrl(),controlStyle);
button.commandName=owner.DeleteCommandName;
button.commandArgument=row.get_rowIndex();
if(addSpace)
{
container.appendChild(document.createTextNode(' '));}
container.appendChild(button);
clickHandler=Function.createCallback(owner._raiseCommand,{sender:owner,row:row});
$addHandler(button,'click',clickHandler);
Array.add(this._deleteButtons,button);
Array.add(this._deleteClickHandlers,clickHandler);
addSpace=true;}
if(this.get_showSelectButton()==true)
{
button=this._createButton(buttonType,this.get_selectText(),this.get_selectImageUrl(),controlStyle);
button.commandName=owner.SelectCommandName;
button.commandArgument=row.get_rowIndex();
if(addSpace)
{
container.appendChild(document.createTextNode(' '));}
container.appendChild(button);
clickHandler=Function.createCallback(owner._raiseCommand,{sender:owner,row:row});
$addHandler(button,'click',clickHandler);
Array.add(this._selectButtons,button);
Array.add(this._selectClickHandlers,clickHandler);}}
if(this.get_itemStyle()!=null)
{
this.get_itemStyle().apply(container);}},
releaseResource:function()
{
$ADC.GridViewCommandColumn.callBaseMethod(this,'releaseResource');
var i=0;
if((this._cancelButtons.length>0)&&(this._cancelClickHandlers.length>0))
{
for(i=this._cancelButtons.length-1;i>-1;i--)
{
$removeHandler(this._cancelButtons[i],'click',this._cancelClickHandlers[i]);
delete this._cancelButtons[i];
delete this._cancelClickHandlers[i];}}
Array.clear(this._cancelButtons);
Array.clear(this._cancelClickHandlers);
if((this._deleteButtons.length>0)&&(this._deleteClickHandlers.length>0))
{
for(i=this._deleteButtons.length-1;i>-1;i--)
{
$removeHandler(this._deleteButtons[i],'click',this._deleteClickHandlers[i]);
delete this._deleteButtons[i];
delete this._deleteClickHandlers[i];}}
Array.clear(this._deleteButtons);
Array.clear(this._deleteClickHandlers);
if((this._editButtons.length>0)&&(this._editClickHandlers.length>0))
{
for(i=this._editButtons.length-1;i>-1;i--)
{
$removeHandler(this._editButtons[i],'click',this._editClickHandlers[i]);
delete this._editButtons[i];
delete this._editClickHandlers[i];}}
Array.clear(this._editButtons);
Array.clear(this._editClickHandlers);
if((this._selectButtons.length>0)&&(this._selectClickHandlers.length>0))
{
for(i=this._selectButtons.length-1;i>-1;i--)
{
$removeHandler(this._selectButtons[i],'click',this._selectClickHandlers[i]);
delete this._selectButtons[i];
delete this._selectClickHandlers[i];}}
Array.clear(this._selectButtons);
Array.clear(this._selectClickHandlers);
if((this._updateButtons.length>0)&&(this._updateClickHandlers.length>0))
{
for(i=this._updateButtons.length-1;i>-1;i--)
{
$removeHandler(this._updateButtons[i],'click',this._updateClickHandlers[i]);
delete this._updateButtons[i];
delete this._updateClickHandlers[i];}}
Array.clear(this._updateButtons);
Array.clear(this._updateClickHandlers);},
_createButton:function(buttonType,text,imageUrl,style)
{
if($ADC.Util.isEmptyString(text))
{
text='';}
if($ADC.Util.isEmptyString(imageUrl))
{
imageUrl='';}
var button;
if(buttonType==$ADC.GridViewColumnButtonType.Link)
{
button=document.createElement('a');
button.appendChild(document.createTextNode(text));
button.setAttribute('href','javascript:void(0)');}
else if(buttonType==$ADC.GridViewColumnButtonType.Image)
{
button=document.createElement('img');
button.setAttribute('alt',text);
if((imageUrl!=null)&&(imageUrl.length>0))
{
button.setAttribute('src',imageUrl);}
button.style.cursor='pointer';}
else
{
button=document.createElement('input');
button.setAttribute('type','button');
button.setAttribute('value',text);}
if(style!=null)
{
style.apply(button);}
return button;}}
$ADC.GridViewCommandColumn.registerClass('AjaxDataControls.GridViewCommandColumn',$ADC.GridViewBaseColumn);
if(typeof(Sys)!='undefined')
{
Sys.Application.notifyScriptLoaded();}