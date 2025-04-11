package controls.buttons.h30px {
  import controls.buttons.FixedHeightButton;

  public class OrangeMediumButton extends FixedHeightButton {
    public function OrangeMediumButton() {
      super(new OrangeMediumButtonSkin());
      this.correctPositionX();
    }

    private function correctPositionX() : void {
      upState.x = -1;
      overState.x = -1;
      downState.x = -1;
      disabledState.x = -1;
    }
  }
}
