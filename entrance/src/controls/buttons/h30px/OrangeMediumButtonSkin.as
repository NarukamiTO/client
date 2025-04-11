package controls.buttons.h30px {
  import controls.buttons.FixedHeightButtonSkin;
  import controls.buttons.FixedHeightRectangleSkin;

  public class OrangeMediumButtonSkin extends FixedHeightButtonSkin {
    private static const leftUpClass:Class = OrangeMediumButtonSkin_leftUpClass;
    private static const middleUpClass:Class = OrangeMediumButtonSkin_middleUpClass;
    private static const rightUpClass:Class = OrangeMediumButtonSkin_rightUpClass;
    private static const leftOverClass:Class = OrangeMediumButtonSkin_leftOverClass;
    private static const middleOverClass:Class = OrangeMediumButtonSkin_middleOverClass;
    private static const rightOverClass:Class = OrangeMediumButtonSkin_rightOverClass;
    private static const leftDownClass:Class = OrangeMediumButtonSkin_leftDownClass;
    private static const middleDownClass:Class = OrangeMediumButtonSkin_middleDownClass;
    private static const rightDownClass:Class = OrangeMediumButtonSkin_rightDownClass;

    public function OrangeMediumButtonSkin() {
      super(createStateSkin(leftUpClass,middleUpClass,rightUpClass),createStateSkin(leftOverClass,middleOverClass,rightOverClass),createStateSkin(leftDownClass,middleDownClass,rightDownClass),createStateSkin(leftUpClass,middleUpClass,rightUpClass));
    }

    private static function createStateSkin(param1:Class, param2:Class, param3:Class) : FixedHeightRectangleSkin {
      return new FixedHeightRectangleSkin(param1,param2,param3);
    }
  }
}
