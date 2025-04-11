package projects.tanks.clients.fp10.models.tankspartnersmodel.guestform {
  import flash.display.Bitmap;
  import flash.display.Sprite;
  import flash.events.MouseEvent;
  import flash.filters.DropShadowFilter;
  import flash.text.TextField;
  import flash.text.TextFormat;

  public class Button extends Sprite {
    private var normal:Bitmap;
    private var over:Bitmap;
    private var button:Sprite;
    private var label:TextField;
    private var onClickHandler:Function;

    public function Button(param1:Bitmap, param2:Bitmap, param3:Function) {
      super();
      this.onClickHandler = param3;
      this.normal = param1;
      this.normal.visible = true;
      this.over = param2;
      this.over.visible = false;
      this.label = this.createStartText();
      this.label.visible = true;
      this.label.filters = [new DropShadowFilter(1,45,10223390,1,2,2,1.5)];
      this.button = new Sprite();
      this.button.visible = true;
      this.button.buttonMode = true;
      this.button.useHandCursor = true;
      this.button.tabEnabled = false;
      this.button.graphics.beginFill(16711680,0);
      this.button.graphics.drawRect(this.normal.x,this.normal.y,this.normal.width,this.normal.height);
      this.button.addEventListener(MouseEvent.MOUSE_OVER,this.onButtonOver);
      this.button.addEventListener(MouseEvent.MOUSE_OUT,this.onButtonOut);
      this.button.addEventListener(MouseEvent.MOUSE_DOWN,this.onButtonDown);
      this.button.addEventListener(MouseEvent.MOUSE_UP,this.onButtonUp);
      this.button.addEventListener(MouseEvent.CLICK,this.onButtonClick);
      addChild(this.normal);
      addChild(this.over);
      addChild(this.button);
      addChild(this.label);
    }

    private function createStartText() : TextField {
      var local1:TextField = new TextField();
      local1.selectable = false;
      local1.multiline = false;
      local1.mouseEnabled = false;
      local1.autoSize = "center";
      local1.antiAliasType = "advanced";
      local1.sharpness = 0;
      local1.thickness = 0;
      local1.defaultTextFormat = new TextFormat("Quadrat",28,1121280,null,null,null,null,null,"center");
      local1.embedFonts = true;
      local1.x = 105;
      local1.y = 3;
      local1.text = "START";
      return local1;
    }

    private function onButtonUp(param1:MouseEvent) : void {
      this.label.y = 0 + 3;
      this.over.y = 0;
    }

    private function onButtonOver(param1:MouseEvent) : void {
      this.normal.alpha = 0;
      this.over.visible = true;
    }

    private function onButtonOut(param1:MouseEvent) : void {
      this.label.y = 0 + 3;
      this.over.y = 0;
      this.normal.alpha = 1;
      this.over.visible = false;
    }

    private function onButtonDown(param1:MouseEvent) : void {
      this.label.y = 0 + 3 + 1;
      this.over.y = 0 + 1;
    }

    private function onButtonClick(param1:MouseEvent) : void {
      this.label.y = 3;
      this.over.y = 0;
      this.button.buttonMode = false;
      this.button.useHandCursor = false;
      this.onClickHandler();
    }

    public function reposition(param1:int, param2:int) : void {
      x = 5 + (param1 - this.button.width) >> 1;
      y = 150 + (param2 - this.button.height) >> 1;
    }
  }
}
