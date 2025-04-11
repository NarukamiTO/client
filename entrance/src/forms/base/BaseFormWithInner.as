package forms.base {
  import controls.TankWindowInner;

  public class BaseFormWithInner extends BaseForm {
    private static const BORDER:int = 12;

    private var downHeight:int;

    public var inner:TankWindowInner;

    public function BaseFormWithInner(param1:int, param2:int, param3:int) {
      super(param1 + BORDER * 2,param2 + param3 + BORDER * 3);
      this.downHeight = param3;
      this.inner = new TankWindowInner(param1,param2,TankWindowInner.GREEN);
      this.inner.x = BORDER;
      this.inner.y = BORDER;
      this.inner.showBlink = true;
      window.addChild(this.inner);
    }

    public function setHeight(param1:int) : void {
      this.inner.height = param1;
      window.height = param1 + this.downHeight + BORDER * 3;
    }
  }
}
