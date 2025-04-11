package alternativa.tanks.view.mainview.button {
  import controls.buttons.FixedHeightRectangleSkin;

  public class DisabledButtonSkin extends FixedHeightRectangleSkin {
    private static const leftClass:Class = DisabledButtonSkin_leftClass;
    private static const middleClass:Class = DisabledButtonSkin_middleClass;
    private static const rightClass:Class = DisabledButtonSkin_rightClass;

    public function DisabledButtonSkin() {
      super(leftClass,middleClass,rightClass);
    }
  }
}
