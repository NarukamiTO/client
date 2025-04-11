package projects.tanks.clients.tankslauncershared.dishonestprogressbar {
  import flash.display.BitmapData;
  import projects.tanks.clients.tankslauncershared.service.Locale;

  public class LoadingLabel {
    private static const loadingLabelRuClass:Class = LoadingLabel_loadingLabelRuClass;
    private static const loadingLabelEnClass:Class = LoadingLabel_loadingLabelEnClass;
    private static const loadingLabelDeClass:Class = LoadingLabel_loadingLabelDeClass;
    private static const loadingLabelCnClass:Class = LoadingLabel_loadingLabelCnClass;
    private static const loadingLabelBrClass:Class = LoadingLabel_loadingLabelBrClass;
    private static const loadingLabelPlClass:Class = LoadingLabel_loadingLabelPlClass;
    private static const loadingLabelEsClass:Class = LoadingLabel_loadingLabelEsClass;

    public function LoadingLabel() {
      super();
    }

    public static function getLocalizedBitmapData(param1:String) : BitmapData {
      switch(param1) {
        case Locale.RU:
          return new loadingLabelRuClass().bitmapData;
        case Locale.DE:
          return new loadingLabelDeClass().bitmapData;
        case Locale.CN:
          return new loadingLabelCnClass().bitmapData;
        case Locale.PT_BR:
          return new loadingLabelBrClass().bitmapData;
        case Locale.PL:
          return new loadingLabelPlClass().bitmapData;
        case Locale.ES:
          return new loadingLabelEsClass().bitmapData;
        default:
          return new loadingLabelEnClass().bitmapData;
      }
    }
  }
}
