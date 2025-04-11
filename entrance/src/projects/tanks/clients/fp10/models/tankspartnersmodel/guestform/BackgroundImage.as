package projects.tanks.clients.fp10.models.tankspartnersmodel.guestform {
  import flash.display.Bitmap;
  import flash.display.Sprite;
  import flash.events.Event;
  import flash.geom.ColorTransform;

  public class BackgroundImage extends Sprite {
    private var background:Sprite;
    private var bg:Bitmap;
    private var colorTransform:ColorTransform = new ColorTransform(0,0,0);

    public function BackgroundImage(param1:Bitmap) {
      super();
      this.background = new Sprite();
      addChild(this.background);
      this.bg = param1;
      this.background.addChild(this.bg);
      this.background.transform.colorTransform = this.colorTransform;
      addEventListener(Event.ENTER_FRAME,this.onEnterFrame);
    }

    private function onEnterFrame(param1:Event) : void {
      if(this.colorTransform.redMultiplier < 1) {
        this.colorTransform.redMultiplier += 0.025;
        this.colorTransform.greenMultiplier += 0.025;
        this.colorTransform.blueMultiplier += 0.025;
        if(this.colorTransform.redMultiplier > 1) {
          this.colorTransform.redMultiplier = 1;
          this.colorTransform.greenMultiplier = 1;
          this.colorTransform.blueMultiplier = 1;
        }
        this.background.transform.colorTransform = this.colorTransform;
      }
    }

    public function resposition(param1:int, param2:int) : void {
      this.bg.x = param1 - this.bg.width >> 1;
      this.bg.y = param2 - this.bg.height >> 1;
    }
  }
}
