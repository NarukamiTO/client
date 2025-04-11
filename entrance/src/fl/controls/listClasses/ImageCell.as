package fl.controls.listClasses {
  import fl.containers.UILoader;
  import flash.display.Graphics;
  import flash.display.Shape;
  import flash.events.IOErrorEvent;

  [Style(name="textOverlayAlpha",type="Number",format="Length")]
  [Style(name="imagePadding",type="Number",format="Length")]
  [Style(name="textPadding",type="Number",format="Length")]
  [Style(name="selectedSkin",type="Class")]
  public class ImageCell extends CellRenderer implements ICellRenderer {
    private static var defaultStyles:Object = {
      "imagePadding":1,
      "textOverlayAlpha":0.7
    };

    protected var textOverlay:Shape;
    protected var loader:UILoader;

    public function ImageCell() {
      super();
      loader = new UILoader();
      loader.addEventListener(IOErrorEvent.IO_ERROR,handleErrorEvent,false,0,true);
      loader.autoLoad = true;
      loader.scaleContent = true;
      addChild(loader);
    }

    public static function getStyleDefinition() : Object {
      return mergeStyles(defaultStyles,CellRenderer.getStyleDefinition());
    }

    protected function handleErrorEvent(param1:IOErrorEvent) : void {
      dispatchEvent(param1);
    }

    override protected function draw() : void {
      super.draw();
    }

    override public function get listData() : ListData {
      return _listData;
    }

    override protected function drawLayout() : void {
      var local4:Number = NaN;
      var local1:Number = getStyleValue("imagePadding") as Number;
      loader.move(local1,local1);
      var local2:Number = width - local1 * 2;
      var local3:Number = height - local1 * 2;
      if(loader.width != local2 && loader.height != local3) {
        loader.setSize(local2,local3);
      }
      loader.drawNow();
      if(_label == "" || _label == null) {
        if(contains(textField)) {
          removeChild(textField);
        }
        if(contains(textOverlay)) {
          removeChild(textOverlay);
        }
      } else {
        local4 = getStyleValue("textPadding") as Number;
        textField.width = Math.min(width - local4 * 2,textField.textWidth + 5);
        textField.height = textField.textHeight + 5;
        textField.x = Math.max(local4,width / 2 - textField.width / 2);
        textField.y = height - textField.height - local4;
        textOverlay.x = local1;
        textOverlay.height = textField.height + local4 * 2;
        textOverlay.y = height - textOverlay.height - local1;
        textOverlay.width = width - local1 * 2;
        textOverlay.alpha = getStyleValue("textOverlayAlpha") as Number;
        addChild(textOverlay);
        addChild(textField);
      }
      background.width = width;
      background.height = height;
    }

    override public function set listData(param1:ListData) : void {
      _listData = param1;
      label = _listData.label;
      var local2:Object = (_listData as TileListData).source;
      if(source != local2) {
        source = local2;
      }
    }

    public function set source(param1:Object) : void {
      loader.source = param1;
    }

    public function get source() : Object {
      return loader.source;
    }

    override protected function configUI() : void {
      super.configUI();
      textOverlay = new Shape();
      var local1:Graphics = textOverlay.graphics;
      local1.beginFill(16777215);
      local1.drawRect(0,0,100,100);
      local1.endFill();
    }
  }
}
