package controls.buttons {
  import assets.button.button_def_DOWN_CENTER;
  import assets.button.button_def_DOWN_LEFT;
  import assets.button.button_def_DOWN_RIGHT;
  import assets.button.button_def_OVER_CENTER;
  import assets.button.button_def_OVER_LEFT;
  import assets.button.button_def_OVER_RIGHT;
  import assets.button.button_def_UP_CENTER;
  import assets.button.button_def_UP_LEFT;
  import assets.button.button_def_UP_RIGHT;
  import controls.buttons.h30px.GreenMediumButtonSkin;
  import controls.buttons.h30px.H30ButtonSkin;
  import flash.display.BitmapData;

  public class CategoryButtonSkin extends FixedHeightButtonSkin {
    public function CategoryButtonSkin() {
      super(createStateSkinByBitmaps(new button_def_UP_LEFT(1,1),new button_def_UP_CENTER(1,1),new button_def_UP_RIGHT(1,1)),createStateSkinByBitmaps(new button_def_OVER_LEFT(1,1),new button_def_OVER_CENTER(1,1),new button_def_OVER_RIGHT(1,1)),createStateSkinByBitmaps(new button_def_DOWN_LEFT(1,1),new button_def_DOWN_CENTER(1,1),new button_def_DOWN_RIGHT(1,1)),createStateSkin(GreenMediumButtonSkin.leftDownClass,GreenMediumButtonSkin.middleDownClass,GreenMediumButtonSkin.rightDownClass));
    }

    private static function createStateSkinByBitmaps(param1:BitmapData, param2:BitmapData, param3:BitmapData) : FixedHeightRectangleSkin {
      return FixedHeightRectangleSkin.createSkin(param1,param2,param3);
    }

    private static function createStateSkin(param1:Class, param2:Class, param3:Class) : FixedHeightRectangleSkin {
      return new FixedHeightRectangleSkin(param1,param2,param3);
    }

    public static function createDisableButtonSkin() : H30ButtonSkin {
      return new H30ButtonSkin(createStateSkinByBitmaps(new button_def_UP_LEFT(1,1),new button_def_UP_CENTER(1,1),new button_def_UP_RIGHT(1,1)),createStateSkinByBitmaps(new button_def_OVER_LEFT(1,1),new button_def_OVER_CENTER(1,1),new button_def_OVER_RIGHT(1,1)),createStateSkinByBitmaps(new button_def_DOWN_LEFT(1,1),new button_def_DOWN_CENTER(1,1),new button_def_DOWN_RIGHT(1,1)));
    }
  }
}
