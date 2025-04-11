package fl.controls {
  import fl.core.InvalidationType;
  import fl.core.UIComponent;
  import fl.events.ScrollEvent;
  import flash.events.Event;
  import flash.events.TextEvent;
  import flash.text.TextField;

  [Embed(source="/_assets/assets.swf", symbol="symbol1147")]
  public class UIScrollBar extends ScrollBar {
    private static var defaultStyles:Object = {};

    protected var inEdit:Boolean = false;
    protected var inScroll:Boolean = false;
    protected var _scrollTarget:TextField;

    public function UIScrollBar() {
      super();
    }

    public static function getStyleDefinition() : Object {
      return UIComponent.mergeStyles(defaultStyles,ScrollBar.getStyleDefinition());
    }

    protected function updateScrollTargetProperties() : void {
      var local1:Boolean = false;
      var local2:Number = NaN;
      if(_scrollTarget == null) {
        setScrollProperties(pageSize,minScrollPosition,maxScrollPosition,pageScrollSize);
        scrollPosition = 0;
      } else {
        local1 = direction == ScrollBarDirection.HORIZONTAL;
        local2 = local1 ? _scrollTarget.width : 10;
        setScrollProperties(local2,local1 ? 0 : 1,local1 ? _scrollTarget.maxScrollH : _scrollTarget.maxScrollV,pageScrollSize);
        scrollPosition = local1 ? _scrollTarget.scrollH : _scrollTarget.scrollV;
      }
    }

    override public function setScrollProperties(param1:Number, param2:Number, param3:Number, param4:Number = 0) : void {
      var local5:Number = param3;
      var local6:Number = param2 < 0 ? 0 : param2;
      if(_scrollTarget != null) {
        if(direction == ScrollBarDirection.HORIZONTAL) {
          local5 = param3 > _scrollTarget.maxScrollH ? _scrollTarget.maxScrollH : local5;
        } else {
          local5 = param3 > _scrollTarget.maxScrollV ? _scrollTarget.maxScrollV : local5;
        }
      }
      super.setScrollProperties(param1,local6,local5,param4);
    }

    protected function handleTargetScroll(param1:Event) : void {
      if(inDrag) {
        return;
      }
      if(!enabled) {
        return;
      }
      inEdit = true;
      updateScrollTargetProperties();
      scrollPosition = direction == ScrollBarDirection.HORIZONTAL ? _scrollTarget.scrollH : _scrollTarget.scrollV;
      inEdit = false;
    }

    override public function setScrollPosition(param1:Number, param2:Boolean = true) : void {
      super.setScrollPosition(param1,param2);
      if(!_scrollTarget) {
        inScroll = false;
        return;
      }
      updateTargetScroll();
    }

    [Inspectable]
    public function get scrollTargetName() : String {
      return _scrollTarget.name;
    }

    override protected function draw() : void {
      if(isInvalid(InvalidationType.DATA)) {
        updateScrollTargetProperties();
      }
      super.draw();
    }

    override public function set direction(param1:String) : void {
      if(isLivePreview) {
        return;
      }
      super.direction = param1;
      updateScrollTargetProperties();
    }

    protected function updateTargetScroll(param1:ScrollEvent = null) : void {
      if(inEdit) {
        return;
      }
      if(direction == ScrollBarDirection.HORIZONTAL) {
        _scrollTarget.scrollH = scrollPosition;
      } else {
        _scrollTarget.scrollV = scrollPosition;
      }
    }

    override public function set minScrollPosition(param1:Number) : void {
      super.minScrollPosition = param1 < 0 ? 0 : param1;
    }

    override public function set maxScrollPosition(param1:Number) : void {
      var local2:Number = param1;
      if(_scrollTarget != null) {
        if(direction == ScrollBarDirection.HORIZONTAL) {
          local2 = local2 > _scrollTarget.maxScrollH ? _scrollTarget.maxScrollH : local2;
        } else {
          local2 = local2 > _scrollTarget.maxScrollV ? _scrollTarget.maxScrollV : local2;
        }
      }
      super.maxScrollPosition = local2;
    }

    protected function handleTargetChange(param1:Event) : void {
      inEdit = true;
      setScrollPosition(direction == ScrollBarDirection.HORIZONTAL ? _scrollTarget.scrollH : _scrollTarget.scrollV,true);
      updateScrollTargetProperties();
      inEdit = false;
    }

    public function update() : void {
      inEdit = true;
      updateScrollTargetProperties();
      inEdit = false;
    }

    public function set scrollTargetName(param1:String) : void {
      var target:String = param1;
      try {
        scrollTarget = parent.getChildByName(target) as TextField;
      }
      catch(error:Error) {
        throw new Error("ScrollTarget not found, or is not a TextField");
      }
    }

    public function set scrollTarget(param1:TextField) : void {
      if(_scrollTarget != null) {
        _scrollTarget.removeEventListener(Event.CHANGE,handleTargetChange,false);
        _scrollTarget.removeEventListener(TextEvent.TEXT_INPUT,handleTargetChange,false);
        _scrollTarget.removeEventListener(Event.SCROLL,handleTargetScroll,false);
        removeEventListener(ScrollEvent.SCROLL,updateTargetScroll,false);
      }
      _scrollTarget = param1;
      if(_scrollTarget != null) {
        _scrollTarget.addEventListener(Event.CHANGE,handleTargetChange,false,0,true);
        _scrollTarget.addEventListener(TextEvent.TEXT_INPUT,handleTargetChange,false,0,true);
        _scrollTarget.addEventListener(Event.SCROLL,handleTargetScroll,false,0,true);
        addEventListener(ScrollEvent.SCROLL,updateTargetScroll,false,0,true);
      }
      invalidate(InvalidationType.DATA);
    }

    public function get scrollTarget() : TextField {
      return _scrollTarget;
    }

    [Inspectable(defaultValue="vertical",type="list",enumeration="vertical,horizontal")]
    override public function get direction() : String {
      return super.direction;
    }
  }
}
