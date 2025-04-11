package projects.tanks.clients.fp10.models.tankspartnersmodel.guestform {
  import flash.display.Bitmap;
  import flash.display.BitmapData;
  import flash.display.Sprite;
  import flash.events.Event;
  import flash.geom.Point;

  public class TankiLogo extends Sprite {
    private var logo:Bitmap;
    private var logoDiffuse:BitmapData;
    private var logoAlpha:BitmapData;

    public function TankiLogo(param1:BitmapData, param2:BitmapData) {
      super();
      this.logoDiffuse = param1;
      this.logoAlpha = param2;
      if(this.logo == null && this.logoDiffuse != null && this.logoAlpha != null) {
        this.logo = new Bitmap();
        this.logo.bitmapData = new BitmapData(this.logoDiffuse.width,this.logoDiffuse.height,true,0);
        this.logo.bitmapData.copyPixels(this.logoDiffuse,this.logoDiffuse.rect,new Point());
        this.logo.bitmapData.copyChannel(this.logoAlpha,this.logoAlpha.rect,new Point(),1,8);
        this.logo.alpha = 0;
        addChild(this.logo);
      }
      addChild(this.logo);
      addEventListener(Event.ENTER_FRAME,this.onEnterFrame);
    }

    private function onEnterFrame(param1:Event) : void {
      if(this.logo != null) {
        if(this.logo.alpha < 1) {
          this.logo.alpha += 0.025;
          if(this.logo.alpha > 1) {
            this.logo.alpha = 1;
          }
        }
      }
    }

    public function reposition(param1:int, param2:int) : void {
      this.logo.x = param1 - this.logo.width >> 1;
      this.logo.y = -150 + (param2 - this.logo.height) >> 1;
    }
  }
}
