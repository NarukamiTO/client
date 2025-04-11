package fl.containers {
  import fl.controls.ScrollBar;
  import fl.controls.ScrollBarDirection;
  import fl.controls.ScrollPolicy;
  import fl.core.InvalidationType;
  import fl.core.UIComponent;
  import fl.events.ScrollEvent;
  import flash.display.DisplayObject;
  import flash.display.Graphics;
  import flash.display.Shape;
  import flash.events.MouseEvent;
  import flash.geom.Rectangle;

  [Style(name="disabledAlpha",type="Number",format="Length")]
  [Style(name="contentPadding",type="Number",format="Length")]
  [Style(name="skin",type="Class")]
  [Style(name="repeatInterval",type="Number",format="Time")]
  [Style(name="repeatDelay",type="Number",format="Time")]
  [Style(name="thumbIcon",type="Class")]
  [Style(name="upArrowUpSkin",type="Class")]
  [Style(name="upArrowOverSkin",type="Class")]
  [Style(name="upArrowDownSkin",type="Class")]
  [Style(name="upArrowDisabledSkin",type="Class")]
  [Style(name="trackUpSkin",type="Class")]
  [Style(name="trackOverSkin",type="Class")]
  [Style(name="trackDownSkin",type="Class")]
  [Style(name="trackDisabledSkin",type="Class")]
  [Style(name="thumbUpSkin",type="Class")]
  [Style(name="thumbOverSkin",type="Class")]
  [Style(name="thumbDownSkin",type="Class")]
  [Style(name="thumbDisabledSkin",type="Class")]
  [Style(name="downArrowUpSkin",type="Class")]
  [Style(name="downArrowOverSkin",type="Class")]
  [Style(name="downArrowDownSkin",type="Class")]
  [Style(name="downArrowDisabledSkin",type="Class")]
  [Event(name="scroll",type="fl.events.ScrollEvent")]
  public class BaseScrollPane extends UIComponent {
    private static var defaultStyles:Object = {
      "repeatDelay":500,
      "repeatInterval":35,
      "skin":"ScrollPane_upSkin",
      "contentPadding":0,
      "disabledAlpha":0.5
    };

    protected static const SCROLL_BAR_STYLES:Object = {
      "upArrowDisabledSkin":"upArrowDisabledSkin",
      "upArrowDownSkin":"upArrowDownSkin",
      "upArrowOverSkin":"upArrowOverSkin",
      "upArrowUpSkin":"upArrowUpSkin",
      "downArrowDisabledSkin":"downArrowDisabledSkin",
      "downArrowDownSkin":"downArrowDownSkin",
      "downArrowOverSkin":"downArrowOverSkin",
      "downArrowUpSkin":"downArrowUpSkin",
      "thumbDisabledSkin":"thumbDisabledSkin",
      "thumbDownSkin":"thumbDownSkin",
      "thumbOverSkin":"thumbOverSkin",
      "thumbUpSkin":"thumbUpSkin",
      "thumbIcon":"thumbIcon",
      "trackDisabledSkin":"trackDisabledSkin",
      "trackDownSkin":"trackDownSkin",
      "trackOverSkin":"trackOverSkin",
      "trackUpSkin":"trackUpSkin",
      "repeatDelay":"repeatDelay",
      "repeatInterval":"repeatInterval"
    };

    protected var contentHeight:Number = 0;
    protected var _horizontalScrollBar:ScrollBar;
    protected var _horizontalPageScrollSize:Number = 0;
    protected var _verticalPageScrollSize:Number = 0;
    protected var _maxHorizontalScrollPosition:Number = 0;
    protected var defaultLineScrollSize:Number = 4;
    protected var vOffset:Number = 0;
    protected var contentScrollRect:Rectangle;
    protected var background:DisplayObject;
    protected var _verticalScrollBar:ScrollBar;
    protected var disabledOverlay:Shape;
    protected var vScrollBar:Boolean;
    protected var _horizontalScrollPolicy:String;
    protected var useFixedHorizontalScrolling:Boolean = false;
    protected var contentWidth:Number = 0;
    protected var availableHeight:Number;
    protected var _verticalScrollPolicy:String;
    protected var contentPadding:Number = 0;
    protected var _useBitmpScrolling:Boolean = false;
    protected var availableWidth:Number;
    protected var hScrollBar:Boolean;

    public function BaseScrollPane() {
      super();
    }

    public static function getStyleDefinition() : Object {
      return mergeStyles(defaultStyles,ScrollBar.getStyleDefinition());
    }

    [Inspectable(defaultValue="true",verbose="1")]
    override public function set enabled(param1:Boolean) : void {
      if(enabled == param1) {
        return;
      }
      _verticalScrollBar.enabled = param1;
      _horizontalScrollBar.enabled = param1;
      super.enabled = param1;
    }

    public function set useBitmapScrolling(param1:Boolean) : void {
      _useBitmpScrolling = param1;
      invalidate(InvalidationType.STATE);
    }

    public function set horizontalLineScrollSize(param1:Number) : void {
      _horizontalScrollBar.lineScrollSize = param1;
    }

    protected function drawLayout() : void {
      calculateAvailableSize();
      calculateContentWidth();
      background.width = width;
      background.height = height;
      if(vScrollBar) {
        _verticalScrollBar.visible = true;
        _verticalScrollBar.x = width - ScrollBar.WIDTH - contentPadding;
        _verticalScrollBar.y = contentPadding;
        _verticalScrollBar.height = availableHeight;
      } else {
        _verticalScrollBar.visible = false;
      }
      _verticalScrollBar.setScrollProperties(availableHeight,0,contentHeight - availableHeight,verticalPageScrollSize);
      setVerticalScrollPosition(_verticalScrollBar.scrollPosition,false);
      if(hScrollBar) {
        _horizontalScrollBar.visible = true;
        _horizontalScrollBar.x = contentPadding;
        _horizontalScrollBar.y = height - ScrollBar.WIDTH - contentPadding;
        _horizontalScrollBar.width = availableWidth;
      } else {
        _horizontalScrollBar.visible = false;
      }
      _horizontalScrollBar.setScrollProperties(availableWidth,0,useFixedHorizontalScrolling ? _maxHorizontalScrollPosition : contentWidth - availableWidth,horizontalPageScrollSize);
      setHorizontalScrollPosition(_horizontalScrollBar.scrollPosition,false);
      drawDisabledOverlay();
    }

    protected function handleWheel(param1:MouseEvent) : void {
      if(!enabled || !_verticalScrollBar.visible || contentHeight <= availableHeight) {
        return;
      }
      _verticalScrollBar.scrollPosition -= param1.delta * verticalLineScrollSize;
      setVerticalScrollPosition(_verticalScrollBar.scrollPosition);
      dispatchEvent(new ScrollEvent(ScrollBarDirection.VERTICAL,param1.delta,horizontalScrollPosition));
    }

    protected function handleScroll(param1:ScrollEvent) : void {
      if(param1.target == _verticalScrollBar) {
        setVerticalScrollPosition(param1.position);
      } else {
        setHorizontalScrollPosition(param1.position);
      }
    }

    [Inspectable(defaultValue="4")]
    public function get verticalLineScrollSize() : Number {
      return _verticalScrollBar.lineScrollSize;
    }

    protected function drawBackground() : void {
      var local1:DisplayObject = background;
      background = getDisplayObjectInstance(getStyleValue("skin"));
      background.width = width;
      background.height = height;
      addChildAt(background,0);
      if(local1 != null && local1 != background) {
        removeChild(local1);
      }
    }

    protected function calculateAvailableSize() : void {
      var local1:Number = ScrollBar.WIDTH;
      var local2:Number = contentPadding = Number(getStyleValue("contentPadding"));
      var local3:Number = height - 2 * local2 - vOffset;
      vScrollBar = _verticalScrollPolicy == ScrollPolicy.ON || _verticalScrollPolicy == ScrollPolicy.AUTO && contentHeight > local3;
      var local4:Number = width - (vScrollBar ? local1 : 0) - 2 * local2;
      var local5:Number = useFixedHorizontalScrolling ? _maxHorizontalScrollPosition : contentWidth - local4;
      hScrollBar = _horizontalScrollPolicy == ScrollPolicy.ON || _horizontalScrollPolicy == ScrollPolicy.AUTO && local5 > 0;
      if(hScrollBar) {
        local3 -= local1;
      }
      if(hScrollBar && !vScrollBar && _verticalScrollPolicy == ScrollPolicy.AUTO && contentHeight > local3) {
        vScrollBar = true;
        local4 -= local1;
      }
      availableHeight = local3 + vOffset;
      availableWidth = local4;
    }

    public function get verticalScrollPosition() : Number {
      return _verticalScrollBar.scrollPosition;
    }

    [Inspectable(defaultValue="auto",enumeration="on,off,auto")]
    public function get horizontalScrollPolicy() : String {
      return _horizontalScrollPolicy;
    }

    protected function setVerticalScrollPosition(param1:Number, param2:Boolean = false) : void {
    }

    [Inspectable(defaultValue="0")]
    public function get horizontalPageScrollSize() : Number {
      if(isNaN(availableWidth)) {
        drawNow();
      }
      return _horizontalPageScrollSize == 0 && !isNaN(availableWidth) ? availableWidth : _horizontalPageScrollSize;
    }

    public function set horizontalScrollPosition(param1:Number) : void {
      drawNow();
      _horizontalScrollBar.scrollPosition = param1;
      setHorizontalScrollPosition(_horizontalScrollBar.scrollPosition,false);
    }

    public function set verticalLineScrollSize(param1:Number) : void {
      _verticalScrollBar.lineScrollSize = param1;
    }

    public function get maxVerticalScrollPosition() : Number {
      drawNow();
      return Math.max(0,contentHeight - availableHeight);
    }

    public function set horizontalPageScrollSize(param1:Number) : void {
      _horizontalPageScrollSize = param1;
      invalidate(InvalidationType.SIZE);
    }

    override protected function draw() : void {
      if(isInvalid(InvalidationType.STYLES)) {
        setStyles();
        drawBackground();
        if(contentPadding != getStyleValue("contentPadding")) {
          invalidate(InvalidationType.SIZE,false);
        }
      }
      if(isInvalid(InvalidationType.SIZE,InvalidationType.STATE)) {
        drawLayout();
      }
      updateChildren();
      super.draw();
    }

    public function get horizontalScrollBar() : ScrollBar {
      return _horizontalScrollBar;
    }

    protected function calculateContentWidth() : void {
    }

    public function set horizontalScrollPolicy(param1:String) : void {
      _horizontalScrollPolicy = param1;
      invalidate(InvalidationType.SIZE);
    }

    override protected function configUI() : void {
      super.configUI();
      contentScrollRect = new Rectangle(0,0,85,85);
      _verticalScrollBar = new ScrollBar();
      _verticalScrollBar.addEventListener(ScrollEvent.SCROLL,handleScroll,false,0,true);
      _verticalScrollBar.visible = false;
      _verticalScrollBar.lineScrollSize = defaultLineScrollSize;
      addChild(_verticalScrollBar);
      copyStylesToChild(_verticalScrollBar,SCROLL_BAR_STYLES);
      _horizontalScrollBar = new ScrollBar();
      _horizontalScrollBar.direction = ScrollBarDirection.HORIZONTAL;
      _horizontalScrollBar.addEventListener(ScrollEvent.SCROLL,handleScroll,false,0,true);
      _horizontalScrollBar.visible = false;
      _horizontalScrollBar.lineScrollSize = defaultLineScrollSize;
      addChild(_horizontalScrollBar);
      copyStylesToChild(_horizontalScrollBar,SCROLL_BAR_STYLES);
      disabledOverlay = new Shape();
      var local1:Graphics = disabledOverlay.graphics;
      local1.beginFill(16777215);
      local1.drawRect(0,0,width,height);
      local1.endFill();
      addEventListener(MouseEvent.MOUSE_WHEEL,handleWheel,false,0,true);
    }

    protected function drawDisabledOverlay() : void {
      if(enabled) {
        if(contains(disabledOverlay)) {
          removeChild(disabledOverlay);
        }
      } else {
        disabledOverlay.x = disabledOverlay.y = contentPadding;
        disabledOverlay.width = availableWidth;
        disabledOverlay.height = availableHeight;
        disabledOverlay.alpha = getStyleValue("disabledAlpha") as Number;
        addChild(disabledOverlay);
      }
    }

    public function get horizontalScrollPosition() : Number {
      return _horizontalScrollBar.scrollPosition;
    }

    public function get verticalScrollBar() : ScrollBar {
      return _verticalScrollBar;
    }

    [Inspectable(defaultValue="4")]
    public function get horizontalLineScrollSize() : Number {
      return _horizontalScrollBar.lineScrollSize;
    }

    public function set verticalScrollPosition(param1:Number) : void {
      drawNow();
      _verticalScrollBar.scrollPosition = param1;
      setVerticalScrollPosition(_verticalScrollBar.scrollPosition,false);
    }

    protected function setHorizontalScrollPosition(param1:Number, param2:Boolean = false) : void {
    }

    protected function setStyles() : void {
      copyStylesToChild(_verticalScrollBar,SCROLL_BAR_STYLES);
      copyStylesToChild(_horizontalScrollBar,SCROLL_BAR_STYLES);
    }

    public function set verticalPageScrollSize(param1:Number) : void {
      _verticalPageScrollSize = param1;
      invalidate(InvalidationType.SIZE);
    }

    protected function setContentSize(param1:Number, param2:Number) : void {
      if((contentWidth == param1 || useFixedHorizontalScrolling) && contentHeight == param2) {
        return;
      }
      contentWidth = param1;
      contentHeight = param2;
      invalidate(InvalidationType.SIZE);
    }

    public function set verticalScrollPolicy(param1:String) : void {
      _verticalScrollPolicy = param1;
      invalidate(InvalidationType.SIZE);
    }

    public function get maxHorizontalScrollPosition() : Number {
      drawNow();
      return Math.max(0,contentWidth - availableWidth);
    }

    protected function updateChildren() : void {
      _verticalScrollBar.enabled = _horizontalScrollBar.enabled = enabled;
      _verticalScrollBar.drawNow();
      _horizontalScrollBar.drawNow();
    }

    [Inspectable(defaultValue="0")]
    public function get verticalPageScrollSize() : Number {
      if(isNaN(availableHeight)) {
        drawNow();
      }
      return _verticalPageScrollSize == 0 && !isNaN(availableHeight) ? availableHeight : _verticalPageScrollSize;
    }

    [Inspectable(defaultValue="auto",enumeration="on,off,auto")]
    public function get verticalScrollPolicy() : String {
      return _verticalScrollPolicy;
    }

    public function get useBitmapScrolling() : Boolean {
      return _useBitmpScrolling;
    }
  }
}
