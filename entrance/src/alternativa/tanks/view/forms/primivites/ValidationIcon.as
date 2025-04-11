package alternativa.tanks.view.forms.primivites {
  import assets.icons.InputCheckIcon;

  public class ValidationIcon extends InputCheckIcon {
    private static const OFF:int = 0;
    private static const PROGRESS:int = 1;
    private static const VALID:int = 2;
    private static const INVALID:int = 3;

    public function ValidationIcon() {
      super();
      this.turnOff();
    }

    public function startProgress() : void {
      this.visible = true;
      gotoAndStop(PROGRESS);
    }

    public function turnOff() : void {
      this.visible = false;
      gotoAndStop(OFF);
    }

    public function markAsValid() : void {
      this.visible = true;
      gotoAndStop(VALID);
    }

    public function markAsInvalid() : void {
      this.visible = true;
      gotoAndStop(INVALID);
    }
  }
}
