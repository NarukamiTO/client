package controls.buttons.h71px {
  import controls.buttons.FixedHeightButtonSkin;
  import controls.buttons.FixedHeightRectangleSkin;

  public class GreyHugeButtonSkin extends FixedHeightButtonSkin {
    private static const leftUpClass:Class = GreyHugeButtonSkin_leftUpClass;
    private static const middleUpClass:Class = GreyHugeButtonSkin_middleUpClass;
    private static const rightUpClass:Class = GreyHugeButtonSkin_rightUpClass;
    private static const leftOverClass:Class = GreyHugeButtonSkin_leftOverClass;
    private static const middleOverClass:Class = GreyHugeButtonSkin_middleOverClass;
    private static const rightOverClass:Class = GreyHugeButtonSkin_rightOverClass;
    private static const leftDownClass:Class = GreyHugeButtonSkin_leftDownClass;
    private static const middleDownClass:Class = GreyHugeButtonSkin_middleDownClass;
    private static const rightDownClass:Class = GreyHugeButtonSkin_rightDownClass;
    private static const leftOffClass:Class = GreyHugeButtonSkin_leftOffClass;
    private static const middleOffClass:Class = GreyHugeButtonSkin_middleOffClass;
    private static const rightOffClass:Class = GreyHugeButtonSkin_rightOffClass;

    public function GreyHugeButtonSkin() {
      super(createStateSkin(leftUpClass,middleUpClass,rightUpClass),createStateSkin(leftOverClass,middleOverClass,rightOverClass),createStateSkin(leftDownClass,middleDownClass,rightDownClass),createStateSkin(leftOffClass,middleOffClass,rightOffClass));
    }

    private static function createStateSkin(param1:Class, param2:Class, param3:Class) : FixedHeightRectangleSkin {
      return new FixedHeightRectangleSkin(param1,param2,param3);
    }
  }
}
