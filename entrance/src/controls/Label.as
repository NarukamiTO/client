package controls {
  import flash.text.AntiAliasType;
  import flash.text.GridFitType;
  import flash.text.TextField;
  import flash.text.TextFieldAutoSize;
  import flash.text.TextFormat;
  import fonts.TanksFontService;

  public class Label extends TextField {
    private var format:TextFormat;

    public function Label() {
      super();
      this.format = TanksFontService.getTextFormat(12);
      this.format.color = 16777215;
      this.selectable = false;
      this.embedFonts = TanksFontService.isEmbedFonts();
      this.antiAliasType = AntiAliasType.ADVANCED;
      this.gridFitType = GridFitType.SUBPIXEL;
      this.width = 10;
      this.height = 12;
      this.autoSize = TextFieldAutoSize.LEFT;
      this.defaultTextFormat = this.format;
      this.size = 12;
    }

    private function updateformat() : void {
      this.defaultTextFormat = this.format;
      this.setTextFormat(this.format);
    }

    public function set size(param1:Number) : void {
      this.format.size = param1;
      this.updateformat();
    }

    public function set bold(param1:Boolean) : void {
      this.format.bold = param1;
      this.updateformat();
    }

    public function set color(param1:uint) : void {
      this.format.color = param1;
      this.updateformat();
    }

    public function set align(param1:String) : void {
      this.format.align = param1;
      this.updateformat();
    }

    override public function set x(param1:Number) : void {
      super.x = int(param1);
    }

    override public function set y(param1:Number) : void {
      super.y = int(param1);
    }

    override public function set height(param1:Number) : void {
      super.height = Math.ceil(param1);
    }

    override public function set width(param1:Number) : void {
      super.width = Math.ceil(param1);
    }
  }
}
