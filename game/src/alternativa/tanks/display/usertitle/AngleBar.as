package alternativa.tanks.display.usertitle {
  public class AngleBar extends ArtilleryBar {
    public function AngleBar() {
      super();
    }

    public function setAngle(param1:Number) : void {
      radialBar.setValue(param1 / 90);
      label.text = param1.toFixed() + "°";
      this.resize();
    }

    override protected function resize() : void {
      label.x = -(label.width >> 1) - X_OFFSET;
      label.y = (label.height >> 1) - Y_OFFSET;
    }
  }
}
