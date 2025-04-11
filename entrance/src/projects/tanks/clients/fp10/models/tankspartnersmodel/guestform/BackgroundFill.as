package projects.tanks.clients.fp10.models.tankspartnersmodel.guestform {
  import flash.display.Shape;
  import flash.display.Sprite;

  public class BackgroundFill extends Sprite {
    private var bgShape:Shape;

    public function BackgroundFill() {
      super();
      this.bgShape = new Shape();
      addChild(this.bgShape);
    }

    public function redraw(param1:int, param2:int) : void {
      this.bgShape.graphics.clear();
      this.bgShape.graphics.beginFill(0);
      this.bgShape.graphics.drawRect(0,0,param1,param2);
    }
  }
}
