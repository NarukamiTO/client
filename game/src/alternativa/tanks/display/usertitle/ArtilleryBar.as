package alternativa.tanks.display.usertitle {
  import controls.base.LabelBase;
  import filters.Filters;
  import flash.display.Sprite;

  public class ArtilleryBar extends Sprite {
    public static const ARTILLERY_BAR_COLOR:uint = 8252719;
    public static const ARTILLERY_BAR_BACK_COLOR:uint = 3635477;

    protected static const X_OFFSET:int = 12;
    protected static const Y_OFFSET:int = 27;

    private static const RADIAL_BAR_RADIUS:int = 43;

    protected var radialBar:RadialBar;
    protected var label:LabelBase = new LabelBase();

    public function ArtilleryBar() {
      super();
      mouseEnabled = false;
      mouseChildren = false;
      this.radialBar = new RadialBar(ARTILLERY_BAR_COLOR,ARTILLERY_BAR_BACK_COLOR,RADIAL_BAR_RADIUS,4,this is PowerBar);
      this.label.bold = true;
      this.label.size = 13;
      this.label.color = ARTILLERY_BAR_COLOR;
      this.label.filters = Filters.SHADOW_FILTERS;
      addChild(this.radialBar);
      addChild(this.label);
      this.resize();
    }

    protected function resize() : void {
    }
  }
}
