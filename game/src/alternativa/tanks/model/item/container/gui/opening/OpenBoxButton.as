package alternativa.tanks.model.item.container.gui.opening {
  import controls.buttons.h50px.GreyBigButton;

  public class OpenBoxButton extends GreyBigButton {
    public var count:int;
    public var mode:int;

    public function OpenBoxButton(param1:String, param2:int, param3:int) {
      super();
      this.label = param1;
      this.count = param2;
      this.mode = param3;
      this.width = 130;
    }
  }
}
