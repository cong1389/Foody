
Type.registerNamespace('AjaxDataControls');
$ADC.PagerPageChangedEventArgs=function(newPageIndex)
{
var e=Function._validateParams(arguments,[{name:"newPageIndex",type:Number}]);
if(e)throw e;
this._newPageIndex=newPageIndex;
$ADC.PagerPageChangedEventArgs.initializeBase(this);}
$ADC.PagerPageChangedEventArgs.prototype=
{
get_newPageIndex:function()
{
if(arguments.length!==0)throw Error.parameterCount();
return this._newPageIndex;}}
$ADC.PagerPageChangedEventArgs.registerClass('AjaxDataControls.PagerPageChangedEventArgs',Sys.EventArgs);
$ADC.Pager=function(element)
{
this._infoStyle=null;
this._pageIndexStyle=null;
this._otherPageStyle=null;
this._firstPageText='<<';
this._lastPageText='>>';
this._previousPageText='<';
this._nextPageText='>';
this._showInfo=false;
this._showFirstAndLast=true;
this._showPreviousAndNext=false;
this._showNumeric=true;
this._pageSize=10;
this._recordCount=0;
this._pageIndex=0;
this._useSlider=true;
this._sliderSize=8;
this._hideOnSinglePage=true;
this._links=new Array();
this._callbacks=new Array();
$ADC.Pager.initializeBase(this,[element]);}
$ADC.Pager.prototype=
{
get_pageCount:function()
{
if(arguments.length!==0)throw Error.parameterCount();
var recordCount=this.get_recordCount();
var pageSize=this.get_pageSize();
if((recordCount==0)||(pageSize==0))
{
return 0;}
if((recordCount%pageSize)==0)
{
return(recordCount/pageSize);}
else
{
var result=(recordCount/pageSize);
result=Math.floor(result)+1;
return result;}},
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
get_infoStyle:function()
{
if(arguments.length!==0)throw Error.parameterCount();
return this._infoStyle;},
set_infoStyle:function(value)
{
var e=Function._validateParams(arguments,[{name:'value',type:$ADC.Style}]);
if(e)throw e;
if(this._infoStyle!=value)
{
this._infoStyle=value;
this.raisePropertyChanged('infoStyle');}},
get_currentPageStyle:function()
{
if(arguments.length!==0)throw Error.parameterCount();
return this._currentPageStyle;},
set_currentPageStyle:function(value)
{
var e=Function._validateParams(arguments,[{name:'value',type:$ADC.Style}]);
if(e)throw e;
if(this._currentPageStyle!=value)
{
this._currentPageStyle=value;
this.raisePropertyChanged('currentPageStyle');}},
get_otherPageStyle:function()
{
if(arguments.length!==0)throw Error.parameterCount();
return this._otherPageStyle;},
set_otherPageStyle:function(value)
{
var e=Function._validateParams(arguments,[{name:'value',type:$ADC.Style}]);
if(e)throw e;
if(this._otherPageStyle!=value)
{
this._otherPageStyle=value;
this.raisePropertyChanged('otherPageStyle');}},
get_showInfo:function()
{
if(arguments.length!==0)throw Error.parameterCount();
return this._showInfo;},
set_showInfo:function(value)
{
var e=Function._validateParams(arguments,[{name:'value',type:Boolean}]);
if(e)throw e;
if(this._showInfo!=value)
{
this._showInfo=value;
this.raisePropertyChanged('showInfo');
this._render();}},
get_showFirstAndLast:function()
{
if(arguments.length!==0)throw Error.parameterCount();
return this._showFirstAndLast;},
set_showFirstAndLast:function(value)
{
var e=Function._validateParams(arguments,[{name:'value',type:Boolean}]);
if(e)throw e;
if(this._showFirstAndLast!=value)
{
this._showFirstAndLast=value;
this.raisePropertyChanged('showFirstAndLast');
this._render();}},
get_firstPageText:function()
{
if(arguments.length!==0)throw Error.parameterCount();
return this._firstPageText;},
set_firstPageText:function(value)
{
var e=Function._validateParams(arguments,[{name:'value',type:String}]);
if(e)throw e;
if(this._firstPageText!=value)
{
this._firstPageText=value;
this.raisePropertyChanged('firstPageText');
this._render();}},
get_lastPageText:function()
{
if(arguments.length!==0)throw Error.parameterCount();
return this._lastPageText;},
set_lastPageText:function(value)
{
var e=Function._validateParams(arguments,[{name:'value',type:String}]);
if(e)throw e;
if(this._lastPageText!=value)
{
this._lastPageText=value;
this.raisePropertyChanged('lastPageText');
this._render();}},
get_showPreviousAndNext:function()
{
if(arguments.length!==0)throw Error.parameterCount();
return this._showPreviousAndNext;},
set_showPreviousAndNext:function(value)
{
var e=Function._validateParams(arguments,[{name:'value',type:Boolean}]);
if(e)throw e;
if(this._showPreviousAndNext!=value)
{
this._showPreviousAndNext=value;
this.raisePropertyChanged('showPreviousAndNext');
this._render();}},
get_previousPageText:function()
{
if(arguments.length!==0)throw Error.parameterCount();
return this._previousPageText;},
set_previousPageText:function(value)
{
var e=Function._validateParams(arguments,[{name:'value',type:String}]);
if(e)throw e;
if(this._previousPageText!=value)
{
this._previousPageText=value;
this.raisePropertyChanged('previousPageText');
this._render();}},
get_nextPageText:function()
{
if(arguments.length!==0)throw Error.parameterCount();
return this._nextPageText;},
set_nextPageText:function(value)
{
var e=Function._validateParams(arguments,[{name:'value',type:String}]);
if(e)throw e;
if(this._nextPageText!=value)
{
this._nextPageText=value;
this.raisePropertyChanged('nextPageText');
this._render();}},
get_showNumeric:function()
{
if(arguments.length!==0)throw Error.parameterCount();
return this._showNumeric;},
set_showNumeric:function(value)
{
var e=Function._validateParams(arguments,[{name:'value',type:Boolean}]);
if(e)throw e;
if(this._showNumeric!=value)
{
this._showNumeric=value;
this.raisePropertyChanged('showNumeric');
this._render();}},
get_pageSize:function()
{
if(arguments.length!==0)throw Error.parameterCount();
return this._pageSize;},
set_pageSize:function(value)
{
var e=Function._validateParams(arguments,[{name:'value',type:Number}]);
if(e)throw e;
if(value<1)
{
throw Error.argument('value','pageSize must be a positive integer.');}
if(this._pageSize!=value)
{
this._pageSize=value;
this.raisePropertyChanged('pageSize');
this._render();}},
get_recordCount:function()
{
if(arguments.length!==0)throw Error.parameterCount();
return this._recordCount;},
set_recordCount:function(value)
{
var e=Function._validateParams(arguments,[{name:'value',type:Number}]);
if(e)throw e;
if(value<0)
{
throw Error.argument('value','recordCount must be a positive integer.');}
if(this._recordCount!=value)
{
this._recordCount=value;
this.raisePropertyChanged('recordCount');
this._render();}},
get_pageIndex:function()
{
if(arguments.length!==0)throw Error.parameterCount();
return this._pageIndex;},
set_pageIndex:function(value)
{
var e=Function._validateParams(arguments,[{name:'value',type:Number}]);
if(e)throw e;
if(value<0)
{
throw Error.argument('value','pageIndex must be a positive integer.');}
if(this._pageIndex!=value)
{
this._pageIndex=value;
this.raisePropertyChanged('pageIndex');
this._render();}},
get_useSlider:function()
{
if(arguments.length!==0)throw Error.parameterCount();
return this._useSlider;},
set_useSlider:function(value)
{
var e=Function._validateParams(arguments,[{name:'value',type:Boolean}]);
if(e)throw e;
if(this._useSlider!=value)
{
this._useSlider=value;
this.raisePropertyChanged('useSlider');
this._render();}},
get_sliderSize:function()
{
if(arguments.length!==0)throw Error.parameterCount();
return this._sliderSize;},
set_sliderSize:function(value)
{
var e=Function._validateParams(arguments,[{name:'value',type:Number}]);
if(e)throw e;
if(value<1)
{
throw Error.argument('value','sliderSize must be a positive integer.');}
if(this._sliderSize!=value)
{
this._sliderSize=value;
this.raisePropertyChanged('sliderSize');
this._render();}},
get_hideOnSinglePage:function()
{
if(arguments.length!==0)throw Error.parameterCount();
return this._hideOnSinglePage;},
set_hideOnSinglePage:function(value)
{
var e=Function._validateParams(arguments,[{name:'value',type:Boolean}]);
if(e)throw e;
if(this._hideOnSinglePage!=value)
{
this._hideOnSinglePage=value;
this.raisePropertyChanged('hideOnSinglePage');
this._render()}},
initialize:function()
{
$ADC.Pager.callBaseMethod(this,'initialize');
this._render();},
dispose:function()
{
this._clearLinkHandlers();
delete this._callbacks;
delete this._links;
delete this._infoStyle;
delete this._currentPageStyle;
delete this._otherPageStyle;
$ADC.Pager.callBaseMethod(this,'dispose');},
add_pageChanged:function(handler)
{
var e=Function._validateParams(arguments,[{name:'handler',type:Function}]);
if(e)throw e;
this.get_events().addHandler('pageChanged',handler);},
remove_pageChanged:function(handler)
{
var e=Function._validateParams(arguments,[{name:'handler',type:Function}]);
if(e)throw e;
this.get_events().removeHandler('pageChanged',handler);},
_raisePageChange:function(e,context)
{
var handler=context.sender.get_events().getHandler('pageChanged');
if(handler)
{
handler(context.sender,new $ADC.PagerPageChangedEventArgs(context.page));}},
_clearLinkHandlers:function()
{
for(var i=this._links.length-1;i>-1;i--)
{
$removeHandler(this._links[i],'click',this._callbacks[i]);
delete this._links[i];
delete this._callbacks[i];}
Array.clear(this._links);
Array.clear(this._callbacks);},
_render:function()
{
var div=this.get_element();
this._clearLinkHandlers();
$ADC.Util.clearContent(div);
if(this.get_pageSize==0)
{
return;}
var recordCount=this.get_recordCount();
if(recordCount==0)
{
return;}
var pageIndex=this.get_pageIndex();
if(pageIndex<0)
{
return;}
var pageCount=this.get_pageCount();
var currentPage=(pageIndex+1);
if(this.get_hideOnSinglePage()&&(pageCount==1))
{
div.style.display='none';}
else
{
div.style.visibility='hidden';
var otherPageStyle=this.get_otherPageStyle();
if(this.get_showInfo())
{
var span=document.createElement('span');
if(this.get_infoStyle()!=null)
{
this.get_infoStyle().apply(span);}
var info=String.format('Page {0} of {1}',currentPage.toString(),pageCount.toString());
$ADC.Util.setText(span,info);
div.appendChild(span);}
if((this.get_showFirstAndLast())&&(currentPage>1))
{
div.appendChild(this._createOther(0,this.get_firstPageText(),otherPageStyle));}
if((this.get_showPreviousAndNext())&&(currentPage>1))
{
div.appendChild(this._createOther((pageIndex-1),this.get_previousPageText(),otherPageStyle));}
if(this.get_showNumeric())
{
var start=1;
var end=pageCount;
var sliderSize=this.get_sliderSize();
if((this.get_useSlider())&&(sliderSize>0))
{
var half=Math.floor(((sliderSize-1)/2));
var above=(currentPage+half)+((sliderSize-1)%2);
var below=(currentPage-half);
if(below<1)
{
above+=(1-below);
below=1;}
if(above>pageCount)
{
below-=(above-pageCount);
if(below<1)
{
below=1;}
above=pageCount;}
start=below;
end=above;}
for(var i=start;i<=end;i++)
{
if(i==currentPage)
{
div.appendChild(this._createCurrent());}
else
{
div.appendChild(this._createOther((i-1),i.toString(),otherPageStyle));}}}
if((this.get_showPreviousAndNext())&&(currentPage<pageCount))
{
div.appendChild(this._createOther((pageIndex+1),this.get_nextPageText(),otherPageStyle));}
if((this.get_showFirstAndLast())&&(currentPage<pageCount))
{
div.appendChild(this._createOther((pageCount-1),this.get_lastPageText(),otherPageStyle));}
div.style.display='';
div.style.visibility='visible';}},
_createOther:function(pageIndex,pageText,style)
{
var span=document.createElement('span');
var a=this._createLink(pageIndex,pageText);
if(style!=null)
{
style.apply(span);}
span.appendChild(a);
return span;},
_createCurrent:function()
{
var span=document.createElement('span');
var currentPage=(this.get_pageIndex()+1)
$ADC.Util.setText(span,currentPage.toString());
if(this.get_currentPageStyle()!=null)
{
this.get_currentPageStyle().apply(span);}
return span;},
_createLink:function(page,text)
{
var a=document.createElement('a');
a.appendChild(document.createTextNode(text));
a.href='javascript:void(0)';
var clickCallback=Function.createCallback(this._raisePageChange,{sender:this,page:page});
$addHandler(a,'click',clickCallback);
this._links.push(a);
this._callbacks.push(clickCallback);
return a;}}
$ADC.Pager.registerClass('AjaxDataControls.Pager',Sys.UI.Control);
if(typeof(Sys)!='undefined')
{
Sys.Application.notifyScriptLoaded();}