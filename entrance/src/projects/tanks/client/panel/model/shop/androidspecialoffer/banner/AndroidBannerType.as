package projects.tanks.client.panel.model.shop.androidspecialoffer.banner {
  public class AndroidBannerType {
    public static const BEGINNER_QUEST:AndroidBannerType = new AndroidBannerType(0,"BEGINNER_QUEST");
    public static const BATTLE_PASS:AndroidBannerType = new AndroidBannerType(1,"BATTLE_PASS");
    public static const BEGINNER_STARTER_PACK:AndroidBannerType = new AndroidBannerType(2,"BEGINNER_STARTER_PACK");
    public static const PREMIUM_SPECIAL_OFFER:AndroidBannerType = new AndroidBannerType(3,"PREMIUM_SPECIAL_OFFER");
    public static const MEDIUM_TIME_PACK:AndroidBannerType = new AndroidBannerType(4,"MEDIUM_TIME_PACK");
    public static const KIT_FULL_OFFER:AndroidBannerType = new AndroidBannerType(5,"KIT_FULL_OFFER");
    public static const PROGRESS_OFFER:AndroidBannerType = new AndroidBannerType(6,"PROGRESS_OFFER");

    private var _value:int;
    private var _name:String;

    public function AndroidBannerType(param1:int, param2:String) {
      super();
      this._value = param1;
      this._name = param2;
    }

    public static function get values() : Vector.<AndroidBannerType> {
      var local1:Vector.<AndroidBannerType> = new Vector.<AndroidBannerType>();
      local1.push(BEGINNER_QUEST);
      local1.push(BATTLE_PASS);
      local1.push(BEGINNER_STARTER_PACK);
      local1.push(PREMIUM_SPECIAL_OFFER);
      local1.push(MEDIUM_TIME_PACK);
      local1.push(KIT_FULL_OFFER);
      local1.push(PROGRESS_OFFER);
      return local1;
    }

    public function toString() : String {
      return "AndroidBannerType [" + this._name + "]";
    }

    public function get value() : int {
      return this._value;
    }

    public function get name() : String {
      return this._name;
    }
  }
}
