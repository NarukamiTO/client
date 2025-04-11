package controls.buttons.h30px {
  import controls.buttons.FixedHeightRectangleSkin;

  public class GreenMediumButtonSkin extends H30ButtonSkin {
    public static const leftUpClass:Class = GreenMediumButtonSkin_leftUpClass;
    public static const middleUpClass:Class = GreenMediumButtonSkin_middleUpClass;
    public static const rightUpClass:Class = GreenMediumButtonSkin_rightUpClass;

    private static const leftOverClass:Class = GreenMediumButtonSkin_leftOverClass;
    private static const middleOverClass:Class = GreenMediumButtonSkin_middleOverClass;
    private static const rightOverClass:Class = GreenMediumButtonSkin_rightOverClass;

    public static const leftDownClass:Class = GreenMediumButtonSkin_leftDownClass;
    public static const middleDownClass:Class = GreenMediumButtonSkin_middleDownClass;
    public static const rightDownClass:Class = GreenMediumButtonSkin_rightDownClass;

    public function GreenMediumButtonSkin() {
      super(createStateSkin(leftUpClass,middleUpClass,rightUpClass),createStateSkin(leftOverClass,middleOverClass,rightOverClass),createStateSkin(leftDownClass,middleDownClass,rightDownClass));
    }

    private static function createStateSkin(param1:Class, param2:Class, param3:Class) : FixedHeightRectangleSkin {
      return new FixedHeightRectangleSkin(param1,param2,param3);
    }
  }
}
