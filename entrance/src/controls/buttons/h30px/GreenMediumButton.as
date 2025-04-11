package controls.buttons.h30px {
  import controls.buttons.FixedHeightButton;

  public class GreenMediumButton extends FixedHeightButton {
    public function GreenMediumButton() {
      super(new GreenMediumButtonSkin());
      labelSize = H30ButtonSkin.DEFAULT_LABEL_SIZE;
      labelHeight = H30ButtonSkin.DEFAULT_LABEL_HEIGHT;
      labelPositionY = H30ButtonSkin.DEFAULT_LABEL_Y;
      width = H30ButtonSkin.DEFAULT_BUTTON_WIDTH;
      enabled = true;
    }
  }
}
