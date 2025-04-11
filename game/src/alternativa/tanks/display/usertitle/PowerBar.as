package alternativa.tanks.display.usertitle {
  public class PowerBar extends ArtilleryBar {
    public function PowerBar() {
      super();
    }

    public function setPower(param1:Number, param2:Number) : void {
      radialBar.setValue(param1);
      label.text = Math.min(param2 * 100,100).toFixed() + "%";
      this.resize();
    }

    override protected function resize() : void {
      label.x = -(label.width >> 1) + X_OFFSET;
      label.y = (label.height >> 1) - Y_OFFSET;
    }
  }
}
