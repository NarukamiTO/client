package controls.buttons.h30px {
  import controls.buttons.FixedHeightButtonSkin;
  import controls.buttons.FixedHeightRectangleSkin;

  public class H30ButtonSkin extends FixedHeightButtonSkin {
    public static const DEFAULT_LABEL_SIZE:int = 12;
    public static const DEFAULT_LABEL_HEIGHT:int = 22;
    public static const DEFAULT_LABEL_Y:int = 6;
    public static const DEFAULT_BUTTON_WIDTH:int = 96;

    private static const disableLeftClass:Class = H30ButtonSkin_disableLeftClass;
    private static const disableMiddleClass:Class = H30ButtonSkin_disableMiddleClass;
    private static const disableRightClass:Class = H30ButtonSkin_disableRightClass;

    public static const fixedHeightRectangleSkin:FixedHeightRectangleSkin = new FixedHeightRectangleSkin(disableLeftClass,disableMiddleClass,disableRightClass);

    public function H30ButtonSkin(param1:FixedHeightRectangleSkin, param2:FixedHeightRectangleSkin, param3:FixedHeightRectangleSkin) {
      super(param1,param2,param3,fixedHeightRectangleSkin);
    }
  }
}
