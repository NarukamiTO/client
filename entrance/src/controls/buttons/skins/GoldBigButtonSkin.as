package controls.buttons.skins {
  import controls.buttons.FixedHeightRectangleSkin;
  import controls.buttons.H50ButtonSkin;

  public class GoldBigButtonSkin extends H50ButtonSkin {
    private static const leftUpClass:Class = GoldBigButtonSkin_leftUpClass;
    private static const middleUpClass:Class = GoldBigButtonSkin_middleUpClass;
    private static const rightUpClass:Class = GoldBigButtonSkin_rightUpClass;
    private static const leftOverClass:Class = GoldBigButtonSkin_leftOverClass;
    private static const middleOverClass:Class = GoldBigButtonSkin_middleOverClass;
    private static const rightOverClass:Class = GoldBigButtonSkin_rightOverClass;
    private static const leftDownClass:Class = GoldBigButtonSkin_leftDownClass;
    private static const middleDownClass:Class = GoldBigButtonSkin_middleDownClass;
    private static const rightDownClass:Class = GoldBigButtonSkin_rightDownClass;

    public static const GOLD_SKIN:GoldBigButtonSkin = new GoldBigButtonSkin();

    public function GoldBigButtonSkin() {
      super(this.createStateSkin(leftUpClass,middleUpClass,rightUpClass),this.createStateSkin(leftOverClass,middleOverClass,rightOverClass),this.createStateSkin(leftDownClass,middleDownClass,rightDownClass));
    }

    private function createStateSkin(param1:Class, param2:Class, param3:Class) : FixedHeightRectangleSkin {
      return new FixedHeightRectangleSkin(param1,param2,param3);
    }
  }
}
