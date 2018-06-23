
Type.registerNamespace('AjaxDataControls');
var $ADC=AjaxDataControls;
$ADC.FontInfo=function(family,size,weight,style,textDecoration)
{
if(arguments.length!==5)throw Error.parameterCount();
this._family=family;
this._size=size;
this._weight=weight;
this._style=style;
this._textDecoration=textDecoration;}
$ADC.FontInfo.prototype=
{
get_family:function()
{
if(arguments.length!==0)throw Error.parameterCount();
return this._family;},
set_family:function(value)
{
var e=Function._validateParams(arguments,[{name:'value',type:String}]);
if(e)throw e;
if(this._family!=value)
{
this._family=value;}},
get_size:function()
{
if(arguments.length!==0)throw Error.parameterCount();
return this._size;},
set_size:function(value)
{
var e=Function._validateParams(arguments,[{name:'value',type:String}]);
if(e)throw e;
if(this._size!=value)
{
this._size=value;}},
get_weight:function()
{
if(arguments.length!==0)throw Error.parameterCount();
return this._weight;},
set_weight:function(value)
{
var e=Function._validateParams(arguments,[{name:'value',type:String}]);
if(e)throw e;
if(this._weight!=value)
{
this._weight=value;}},
get_style:function()
{
if(arguments.length!==0)throw Error.parameterCount();
return this._style;},
set_style:function(value)
{
var e=Function._validateParams(arguments,[{name:'value',type:String}]);
if(e)throw e;
if(this._style!=value)
{
this._style=value;}},
get_textDecoration:function()
{
if(arguments.length!==0)throw Error.parameterCount();
return this._textDecoration;},
set_textDecoration:function(value)
{
var e=Function._validateParams(arguments,[{name:'value',type:String}]);
if(e)throw e;
if(this._textDecoration!=value)
{
this._textDecoration=value;}}}
$ADC.FontInfo.registerClass('AjaxDataControls.FontInfo');
$ADC.Style=function(backColor,borderColor,borderStyle,borderWidth,cssClass,font,foreColor,height,width)
{
if(arguments.length!==9)throw Error.parameterCount();
this._backColor=backColor;
this._borderColor=borderColor;
this._borderStyle=borderStyle;
this._borderWidth=borderWidth;
this._cssClass=cssClass
this._font=font;
this._foreColor=foreColor;
this._height=height;
this._width=width;}
$ADC.Style.prototype=
{
get_backColor:function()
{
if(arguments.length!==0)throw Error.parameterCount();
return this._backColor;},
set_backColor:function(value)
{
var e=Function._validateParams(arguments,[{name:'value',type:String}]);
if(e)throw e;
if(this._backColor!=value)
{
this._backColor=value;}},
get_borderColor:function()
{
if(arguments.length!==0)throw Error.parameterCount();
return this._borderColor;},
set_borderColor:function(value)
{
var e=Function._validateParams(arguments,[{name:'value',type:String}]);
if(e)throw e;
if(this._borderColor!=value)
{
this._borderColor=value;}},
get_borderStyle:function()
{
if(arguments.length!==0)throw Error.parameterCount();
return this._borderStyle;},
set_borderStyle:function(value)
{
var e=Function._validateParams(arguments,[{name:'value',type:String}]);
if(e)throw e;
if(this._borderStyle!=value)
{
this._borderStyle=value;}},
get_borderWidth:function()
{
if(arguments.length!==0)throw Error.parameterCount();
return this._borderStyle;},
set_borderWidth:function(value)
{
var e=Function._validateParams(arguments,[{name:'value',type:String}]);
if(e)throw e;
if(this._borderWidth!=value)
{
this._borderWidth=value;}},
get_cssClass:function()
{
if(arguments.length!==0)throw Error.parameterCount();
return this._cssClass;},
set_cssClass:function(value)
{
var e=Function._validateParams(arguments,[{name:'value',type:String}]);
if(e)throw e;
if(this._cssClass!=value)
{
this._cssClass=value;}},
get_font:function()
{
if(arguments.length!==0)throw Error.parameterCount();
return this._font;},
set_font:function(value)
{
var e=Function._validateParams(arguments,[{name:'value',type:AjaxDataControls.FontInfo}]);
if(e)throw e;
if(this._font!=value)
{
this._font=value;}},
get_foreColor:function()
{
if(arguments.length!==0)throw Error.parameterCount();
return this._foreColor;},
set_foreColor:function(value)
{
var e=Function._validateParams(arguments,[{name:'value',type:String}]);
if(e)throw e;
if(this._foreColor!=value)
{
this._foreColor=value;}},
get_height:function()
{
if(arguments.length!==0)throw Error.parameterCount();
return this._height;},
set_height:function(value)
{
var e=Function._validateParams(arguments,[{name:'value',type:String}]);
if(e)throw e;
if(this._height!=value)
{
this._height=value;}},
get_width:function()
{
if(arguments.length!==0)throw Error.parameterCount();
return this._width;},
set_width:function(value)
{
var e=Function._validateParams(arguments,[{name:'value',type:String}]);
if(e)throw e;
if(this._width!=value)
{
this._width=value;}},
apply:function(element)
{
var e=Function._validateParams(arguments,[{name:'element',type:Object}]);
if(e)throw e;
if(!$ADC.Util.isEmptyString(this.get_backColor()))
{
element.style.backColor=this.get_backColor();}
if(!$ADC.Util.isEmptyString(this.get_borderColor()))
{
element.style.borderColor=this.get_borderColor();}
if(!$ADC.Util.isEmptyString(this.get_borderStyle()))
{
element.style.borderStyle=this.get_borderStyle();}
if(!$ADC.Util.isEmptyString(this.get_borderWidth()))
{
element.style.borderWidth=this.get_borderWidth();}
if(!$ADC.Util.isEmptyString(this.get_cssClass()))
{
element.className=this.get_cssClass();}
var font=this.get_font();
if(font!=null)
{
if(!$ADC.Util.isEmptyString(font.get_family()))
{
element.style.fontFamily=font.get_family();}
if(!$ADC.Util.isEmptyString(font.get_size()))
{
element.style.fontSize=font.get_size();}
if(!$ADC.Util.isEmptyString(font.get_weight()))
{
element.style.fontWeight=font.get_weight();}
if(!$ADC.Util.isEmptyString(font.get_style()))
{
element.style.fontStyle=font.get_style();}
if(!$ADC.Util.isEmptyString(font.get_textDecoration()))
{
element.style.textDecoration=font.get_textDecoration();}}
if(!$ADC.Util.isEmptyString(this.get_foreColor()))
{
element.style.color=this.get_foreColor();}
if(!$ADC.Util.isEmptyString(this.get_height()))
{
element.style.height=this.get_height();}
if(!$ADC.Util.isEmptyString(this.get_width()))
{
element.style.width=this.get_width();}}}
$ADC.Style.registerClass('AjaxDataControls.Style');
$ADC.Style.getStyleValue=function(element,attribute,defaultValue)
{
var currentValue=null;
if(element)
{
if(element.currentStyle)
{
currentValue=element.currentStyle[attribute];}
else if(document.defaultView&&document.defaultView.getComputedStyle)
{
var style=document.defaultView.getComputedStyle(element,null);
if(style)
{
currentValue=style[attribute];}}
if(!currentValue&&element.style.getPropertyValue)
{
currentValue=element.style.getPropertyValue(attribute);}
else if(!currentValue&&element.style.getAttribute)
{
currentValue=element.style.getAttribute(attribute);}}
if((!currentValue||currentValue==''||typeof(currentValue)==='undefined'))
{
if(typeof(defaultValue)!='undefined')
{
currentValue=defaultValue;}
else
{
currentValue=null;}}
return currentValue;}
$ADC.Style.getInheritedBackgroundColor=function(element)
{
var defaultColor='#FFFFFF';
if(!element)
{
return defaultColor;}
var background=$ADC.Style.getStyleValue(element,'backgroundColor');
try
{
while(!background||background==''||background=='transparent'||background=='rgba(0, 0, 0, 0)')
{
element=element.parentNode;
if(!element)
{
background=defaultColor;}
else
{
background=$ADC.Style.getStyleValue(element,'backgroundColor');}}}
catch(ex)
{
background=defaultColor;}
return background;}
$ADC.TableItemStyle=function(backColor,borderColor,borderStyle,borderWidth,cssClass,font,foreColor,height,width,horizontalAlign,verticalAlign,wrap)
{
if(arguments.length!==12)throw Error.parameterCount();
$ADC.TableItemStyle.initializeBase(this,[backColor,borderColor,borderStyle,borderWidth,cssClass,font,foreColor,height,width]);
this._horizontalAlign=horizontalAlign;
this._verticalAlign=verticalAlign;
this._wrap=wrap;}
$ADC.TableItemStyle.prototype=
{
get_horizontalAlign:function()
{
if(arguments.length!==0)throw Error.parameterCount();
return this._horizontalAlign;},
set_horizontalAlign:function(value)
{
var e=Function._validateParams(arguments,[{name:'value',type:String}]);
if(e)throw e;
if(this._horizontalAlign!=value)
{
this._horizontalAlign=value;}},
get_verticalAlign:function()
{
if(arguments.length!==0)throw Error.parameterCount();
return this._verticalAlign;},
set_verticalAlign:function(value)
{
var e=Function._validateParams(arguments,[{name:'value',type:String}]);
if(e)throw e;
if(this._verticalAlign!=value)
{
this._verticalAlign=value;}},
get_wrap:function()
{
if(arguments.length!==0)throw Error.parameterCount();
return this._wrap;},
set_wrap:function(value)
{
var e=Function._validateParams(arguments,[{name:'value',type:Boolean}]);
if(e)throw e;
if(this._wrap!=value)
{
this._wrap=value;}},
apply:function(element)
{
var e=Function._validateParams(arguments,[{name:'element',type:Object}]);
if(e)throw e;
AjaxDataControls.TableItemStyle.callBaseMethod(this,'apply',[element]);
if(!$ADC.Util.isEmptyString(this.get_horizontalAlign()))
{
element.style.textAlign=this.get_horizontalAlign();}
if(!$ADC.Util.isEmptyString(this.get_verticalAlign()))
{
element.style.verticalAlign=this.get_verticalAlign();}
if(this.get_wrap()==false)
{
element.style.whiteSpace='nowrap';}}}
$ADC.TableItemStyle.registerClass('AjaxDataControls.TableItemStyle',AjaxDataControls.Style);
$ADC.Util=function()
{}
$ADC.Util.isEmptyString=function(s)
{
if(typeof s!='string')
{
return true;}
return((s==null)||(s.trim().length<1));}
$ADC.Util.clearContent=function(e)
{
if(e.firstChild)
{
while(e.firstChild)
{
e.removeChild(e.firstChild);}}}
$ADC.Util.setText=function(e,t)
{
if(typeof e.textContent!='undefined')
{
e.textContent=t;}
else if(typeof e.innerText!='undefined')
{
e.innerText=t;}}
$ADC.Util.hasDragNDropSupport=function()
{
var hasSupport=(
(typeof(Sys.Preview)!='undefined')&&
(typeof(Sys.Preview.UI)!='undefined')&&
(typeof(Sys.Preview.UI.DragDropManager)!='undefined'));
return hasSupport;}
$ADC.Util.hasAnimationSupport=function()
{
var hasSupport=(
(typeof(Sys.Preview)!='undefined')&&
(typeof(Sys.Preview.UI)!='undefined')&&
(typeof(Sys.Preview.UI.Effects)!='undefined')&&
(typeof(Sys.Preview.UI.Effects.FadeAnimation)!='undefined'));
return hasSupport;}
$ADC.Util.createDataBindAnimation=function(duration,fps,target)
{
return $create(Sys.Preview.UI.Effects.FadeAnimation,{'duration':duration,'fps':fps,'effect':Sys.Preview.UI.Effects.FadeEffect.FadeIn,'target':target});}
$ADC.Util.registerClass('AjaxDataControls.Util');
if(typeof(Sys)!='undefined')
{
Sys.Application.notifyScriptLoaded();}