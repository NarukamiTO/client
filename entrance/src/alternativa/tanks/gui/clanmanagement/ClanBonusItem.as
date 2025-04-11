package alternativa.tanks.gui.clanmanagement {
  import base.DiscreteSprite;
  import controls.base.LabelBase;
  import flash.display.Bitmap;
  import flash.display.Shape;
  import flash.display.StageQuality;
  import flash.events.Event;
  import flash.text.TextFormatAlign;

  public class ClanBonusItem extends DiscreteSprite {
    private static const WIDTH:Number = 120;
    private static const HEIGHT:Number = 100;

    private var image:Bitmap;
    private var textLabel:LabelBase;
    private var valueLabel:LabelBase;
    private var stageQuality:String;

    public function ClanBonusItem(param1:Bitmap, param2:String, param3:String) {
      super();
      this.image = param1;
      this.textLabel = new LabelBase();
      this.textLabel.align = TextFormatAlign.CENTER;
      this.textLabel.wordWrap = true;
      this.textLabel.multiline = true;
      this.valueLabel = new LabelBase();
      this.valueLabel.size = 16;
      this.valueLabel.bold = true;
      this.image.x = WIDTH - this.image.bitmapData.width >> 1;
      this.image.y = HEIGHT - this.image.bitmapData.height >> 1;
      this.textLabel.text = param2;
      this.textLabel.width = WIDTH;
      this.textLabel.y = 5;
      this.setValue(param3);
      var local4:Shape = new Shape();
      local4.graphics.beginFill(676609,1);
      local4.graphics.lineStyle(0,5177127,1);
      local4.graphics.drawRoundRect(0,0,WIDTH,HEIGHT,6,6);
      local4.graphics.endFill();
      addChild(local4);
      addChild(this.image);
      addChild(this.textLabel);
      addChild(this.valueLabel);
      addEventListener(Event.ADDED_TO_STAGE,this.addedToStage);
    }

    private function addedToStage(param1:Event) : void {
      removeEventListener(Event.ADDED_TO_STAGE,this.addedToStage);
      this.stageQuality = stage.quality;
      stage.quality = StageQuality.MEDIUM;
      addEventListener(Event.REMOVED_FROM_STAGE,this.removedFromStage);
    }

    private function removedFromStage(param1:Event) : void {
      removeEventListener(Event.REMOVED_FROM_STAGE,this.removedFromStage);
      stage.quality = this.stageQuality;
    }

    public function setValue(param1:String) : void {
      this.valueLabel.text = param1;
      this.valueLabel.x = WIDTH - this.valueLabel.width >> 1;
      this.valueLabel.y = HEIGHT - 5 - this.valueLabel.height;
    }
  }
}
