package assets.combo {
  public class ComboUpButton extends ComboButtonState {
    public function ComboUpButton() {
      super();
      bmpLeft = new combo_UP_LEFT(1,1);
      bmpCenter = new combo_UP_CENTER(1,1);
      bmpRight = new combo_UP_RIGHT(1,1);
      draw();
    }
  }
}
