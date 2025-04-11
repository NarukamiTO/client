package controls.buttons {
  public class H50ButtonSkin extends FixedHeightButtonSkin {
    private static const leftClass:Class = H50ButtonSkin_leftClass;
    private static const rightClass:Class = H50ButtonSkin_rightClass;
    private static const middleClass:Class = H50ButtonSkin_middleClass;
    private static const fixedHeightRectangleSkin:FixedHeightRectangleSkin = new FixedHeightRectangleSkin(leftClass,middleClass,rightClass);

    public function H50ButtonSkin(param1:FixedHeightRectangleSkin, param2:FixedHeightRectangleSkin, param3:FixedHeightRectangleSkin) {
      super(param1,param2,param3,fixedHeightRectangleSkin);
    }
  }
}
