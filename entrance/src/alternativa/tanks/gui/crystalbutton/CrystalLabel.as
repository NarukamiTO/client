package alternativa.tanks.gui.crystalbutton {
  import alternativa.tanks.gui.icons.CrystalIcon;
  import controls.Money;
  import controls.labels.MouseDisabledLabel;
  import flash.display.Bitmap;
  import flash.display.Graphics;
  import flash.display.Shape;
  import flash.display.Sprite;

  public class CrystalLabel extends Sprite {
    private var crystalIcon:Bitmap;
    private var label:MouseDisabledLabel;
    private var color:uint = 16777215;
    private var strikeColor:uint = 11645361;
    private var line:Shape = new Shape();
    private var isStrike:Boolean = false;

    public function CrystalLabel(param1:int = 0) {
      super();
      mouseEnabled = false;
      this.label = new MouseDisabledLabel();
      this.crystalIcon = CrystalIcon.createSmallInstance();
      addChild(this.label);
      addChild(this.crystalIcon);
      this.crystalIcon.y = 4;
      this.setCost(param1);
    }

    public function setText(param1:String) : void {
      this.label.text = param1;
      this.crystalIcon.x = this.label.x + this.label.textWidth + 5;
    }

    public function setCost(param1:int) : void {
      this.label.text = Money.numToString(param1,false);
      this.crystalIcon.x = this.label.x + this.label.textWidth + 5;
      this.setStrike(false);
    }

    public function setColor(param1:int) : void {
      this.color = param1;
      if(!this.isStrike) {
        this.label.textColor = param1;
      }
    }

    public function setSharpness(param1:int) : void {
      this.label.sharpness = param1;
    }

    public function setThickness(param1:int) : void {
      this.label.thickness = param1;
    }

    public function setStrikeColor(param1:int) : void {
      this.strikeColor = param1;
    }

    public function setStrike(param1:Boolean) : void {
      var local2:Graphics = null;
      var local3:int = 0;
      this.isStrike = param1;
      if(param1) {
        this.label.textColor = this.strikeColor;
        local2 = this.line.graphics;
        local2.clear();
        local2.lineStyle(1,this.strikeColor);
        local3 = int(this.label.y + this.label.height * 0.5) + 1;
        local2.moveTo(0,local3);
        local2.lineTo(0 + width + 2,local3);
        if(!contains(this.line)) {
          addChild(this.line);
        }
      } else {
        this.label.textColor = this.color;
        if(contains(this.line)) {
          removeChild(this.line);
        }
      }
    }
  }
}
