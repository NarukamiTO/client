package controls.buttons.h30px {
  import controls.buttons.FixedHeightRectangleSkin;

  public class GrayFrameMediumLabelSkin extends H30ButtonSkin {
    public static const left:Class = GrayFrameMediumLabelSkin_left;
    public static const middle:Class = GrayFrameMediumLabelSkin_middle;
    public static const right:Class = GrayFrameMediumLabelSkin_right;

    public function GrayFrameMediumLabelSkin() {
      super(createStateSkin(left,middle,right),createStateSkin(left,middle,right),createStateSkin(left,middle,right));
    }

    private static function createStateSkin(param1:Class, param2:Class, param3:Class) : FixedHeightRectangleSkin {
      return new FixedHeightRectangleSkin(param1,param2,param3);
    }
  }
}
