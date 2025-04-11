package alternativa.tanks.model.quest.common.gui.window.buttons.skin {
  import controls.buttons.FixedHeightRectangleSkin;
  import controls.buttons.H50ButtonSkin;

  public class GreenBigButtonSkin extends H50ButtonSkin {
    private static const leftUpClass:Class = GreenBigButtonSkin_leftUpClass;
    private static const middleUpClass:Class = GreenBigButtonSkin_middleUpClass;
    private static const rightUpClass:Class = GreenBigButtonSkin_rightUpClass;
    private static const leftOverClass:Class = GreenBigButtonSkin_leftOverClass;
    private static const middleOverClass:Class = GreenBigButtonSkin_middleOverClass;
    private static const rightOverClass:Class = GreenBigButtonSkin_rightOverClass;
    private static const leftDownClass:Class = GreenBigButtonSkin_leftDownClass;
    private static const middleDownClass:Class = GreenBigButtonSkin_middleDownClass;
    private static const rightDownClass:Class = GreenBigButtonSkin_rightDownClass;

    public static const GREEN_SKIN:GreenBigButtonSkin = new GreenBigButtonSkin();

    public function GreenBigButtonSkin() {
      super(this.createStateSkin(leftUpClass,middleUpClass,rightUpClass),this.createStateSkin(leftOverClass,middleOverClass,rightOverClass),this.createStateSkin(leftDownClass,middleDownClass,rightDownClass));
    }

    private function createStateSkin(param1:Class, param2:Class, param3:Class) : FixedHeightRectangleSkin {
      return new FixedHeightRectangleSkin(param1,param2,param3);
    }
  }
}
