package controls.buttons.h50px {
  import controls.buttons.FixedHeightRectangleSkin;
  import controls.buttons.H50ButtonSkin;

  public class GreyBigButtonSkin extends H50ButtonSkin {
    private static const leftUpClass:Class = GreyBigButtonSkin_leftUpClass;
    private static const middleUpClass:Class = GreyBigButtonSkin_middleUpClass;
    private static const rightUpClass:Class = GreyBigButtonSkin_rightUpClass;
    private static const leftOverClass:Class = GreyBigButtonSkin_leftOverClass;
    private static const middleOverClass:Class = GreyBigButtonSkin_middleOverClass;
    private static const rightOverClass:Class = GreyBigButtonSkin_rightOverClass;
    private static const leftDownClass:Class = GreyBigButtonSkin_leftDownClass;
    private static const middleDownClass:Class = GreyBigButtonSkin_middleDownClass;
    private static const rightDownClass:Class = GreyBigButtonSkin_rightDownClass;

    public static const GREY_SKIN:GreyBigButtonSkin = new GreyBigButtonSkin();

    public function GreyBigButtonSkin() {
      super(this.createStateSkin(leftUpClass,middleUpClass,rightUpClass),this.createStateSkin(leftOverClass,middleOverClass,rightOverClass),this.createStateSkin(leftDownClass,middleDownClass,rightDownClass));
    }

    private function createStateSkin(param1:Class, param2:Class, param3:Class) : FixedHeightRectangleSkin {
      return new FixedHeightRectangleSkin(param1,param2,param3);
    }
  }
}
