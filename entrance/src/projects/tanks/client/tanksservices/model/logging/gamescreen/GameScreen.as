package projects.tanks.client.tanksservices.model.logging.gamescreen {
  public class GameScreen {
    public static const PAYMENT:GameScreen = new GameScreen(0,"PAYMENT");
    public static const QUESTS:GameScreen = new GameScreen(1,"QUESTS");
    public static const BATTLE_SELECT:GameScreen = new GameScreen(2,"BATTLE_SELECT");
    public static const GARAGE:GameScreen = new GameScreen(3,"GARAGE");
    public static const FRIENDS:GameScreen = new GameScreen(4,"FRIENDS");
    public static const SETTINGS:GameScreen = new GameScreen(5,"SETTINGS");
    public static const BATTLE:GameScreen = new GameScreen(6,"BATTLE");
    public static const STATISTICS:GameScreen = new GameScreen(7,"STATISTICS");
    public static const EXIT_GAME:GameScreen = new GameScreen(8,"EXIT_GAME");
    public static const CLAN:GameScreen = new GameScreen(9,"CLAN");
    public static const MATCHMAKING:GameScreen = new GameScreen(10,"MATCHMAKING");
    public static const ANDROID_SCREEN_HOME:GameScreen = new GameScreen(11,"ANDROID_SCREEN_HOME");
    public static const ANDROID_SCREEN_BATTLES:GameScreen = new GameScreen(12,"ANDROID_SCREEN_BATTLES");
    public static const ANDROID_SCREEN_QUEST:GameScreen = new GameScreen(13,"ANDROID_SCREEN_QUEST");
    public static const ANDROID_SCREEN_WEEKLY_REWARDS:GameScreen = new GameScreen(14,"ANDROID_SCREEN_WEEKLY_REWARDS");
    public static const ANDROID_SCREEN_BEGINNER_QUEST:GameScreen = new GameScreen(15,"ANDROID_SCREEN_BEGINNER_QUEST");
    public static const ANDROID_SCREEN_COMMUNICATOR_NEWS:GameScreen = new GameScreen(16,"ANDROID_SCREEN_COMMUNICATOR_NEWS");
    public static const ANDROID_SCREEN_UNKNOWN:GameScreen = new GameScreen(17,"ANDROID_SCREEN_UNKNOWN");
    public static const ANDROID_SCREEN_SETTINGS_ACCOUNT:GameScreen = new GameScreen(18,"ANDROID_SCREEN_SETTINGS_ACCOUNT");
    public static const ANDROID_SCREEN_SETTINGS_GRAPHIC:GameScreen = new GameScreen(19,"ANDROID_SCREEN_SETTINGS_GRAPHIC");
    public static const ANDROID_SCREEN_SETTINGS_SOUND:GameScreen = new GameScreen(20,"ANDROID_SCREEN_SETTINGS_SOUND");
    public static const ANDROID_SCREEN_SETTINGS_GAME:GameScreen = new GameScreen(21,"ANDROID_SCREEN_SETTINGS_GAME");
    public static const ANDROID_SCREEN_SETTINGS_CONTROL:GameScreen = new GameScreen(22,"ANDROID_SCREEN_SETTINGS_CONTROL");
    public static const ANDROID_SCREEN_SETTINGS_HUD:GameScreen = new GameScreen(23,"ANDROID_SCREEN_SETTINGS_HUD");
    public static const ANDROID_SCREEN_GARAGE_WEAPON:GameScreen = new GameScreen(24,"ANDROID_SCREEN_GARAGE_WEAPON");
    public static const ANDROID_SCREEN_GARAGE_ARMOR:GameScreen = new GameScreen(25,"ANDROID_SCREEN_GARAGE_ARMOR");
    public static const ANDROID_SCREEN_GARAGE_PAINT:GameScreen = new GameScreen(26,"ANDROID_SCREEN_GARAGE_PAINT");
    public static const ANDROID_SCREEN_GARAGE_INVENTORY:GameScreen = new GameScreen(27,"ANDROID_SCREEN_GARAGE_INVENTORY");
    public static const ANDROID_SCREEN_GARAGE_KIT:GameScreen = new GameScreen(28,"ANDROID_SCREEN_GARAGE_KIT");
    public static const ANDROID_SCREEN_GARAGE_SPECIAL:GameScreen = new GameScreen(29,"ANDROID_SCREEN_GARAGE_SPECIAL");
    public static const ANDROID_SCREEN_GARAGE_GIVEN_PRESENTS:GameScreen = new GameScreen(30,"ANDROID_SCREEN_GARAGE_GIVEN_PRESENTS");
    public static const ANDROID_SCREEN_GARAGE_RESISTANCE:GameScreen = new GameScreen(31,"ANDROID_SCREEN_GARAGE_RESISTANCE");
    public static const ANDROID_SCREEN_GARAGE_DRONE:GameScreen = new GameScreen(32,"ANDROID_SCREEN_GARAGE_DRONE");
    public static const ANDROID_SCREEN_GARAGE_SKINS:GameScreen = new GameScreen(33,"ANDROID_SCREEN_GARAGE_SKINS");
    public static const ANDROID_SCREEN_SHOP_CRYSTALS:GameScreen = new GameScreen(34,"ANDROID_SCREEN_SHOP_CRYSTALS");
    public static const ANDROID_SCREEN_SHOP_PREMIUM:GameScreen = new GameScreen(35,"ANDROID_SCREEN_SHOP_PREMIUM");
    public static const ANDROID_SCREEN_SHOP_GOLD_BOXES:GameScreen = new GameScreen(36,"ANDROID_SCREEN_SHOP_GOLD_BOXES");
    public static const ANDROID_SCREEN_SHOP_PAINTS:GameScreen = new GameScreen(37,"ANDROID_SCREEN_SHOP_PAINTS");
    public static const ANDROID_SCREEN_SHOP_KITS:GameScreen = new GameScreen(38,"ANDROID_SCREEN_SHOP_KITS");
    public static const ANDROID_SCREEN_SHOP_OTHERS:GameScreen = new GameScreen(39,"ANDROID_SCREEN_SHOP_OTHERS");
    public static const ANDROID_SCREEN_SHOP_LOOT_BOXES:GameScreen = new GameScreen(40,"ANDROID_SCREEN_SHOP_LOOT_BOXES");
    public static const ANDROID_SCREEN_SHOP_NO_CATEGORY:GameScreen = new GameScreen(41,"ANDROID_SCREEN_SHOP_NO_CATEGORY");

    private var _value:int;
    private var _name:String;

    public function GameScreen(param1:int, param2:String) {
      super();
      this._value = param1;
      this._name = param2;
    }

    public static function get values() : Vector.<GameScreen> {
      var local1:Vector.<GameScreen> = new Vector.<GameScreen>();
      local1.push(PAYMENT);
      local1.push(QUESTS);
      local1.push(BATTLE_SELECT);
      local1.push(GARAGE);
      local1.push(FRIENDS);
      local1.push(SETTINGS);
      local1.push(BATTLE);
      local1.push(STATISTICS);
      local1.push(EXIT_GAME);
      local1.push(CLAN);
      local1.push(MATCHMAKING);
      local1.push(ANDROID_SCREEN_HOME);
      local1.push(ANDROID_SCREEN_BATTLES);
      local1.push(ANDROID_SCREEN_QUEST);
      local1.push(ANDROID_SCREEN_WEEKLY_REWARDS);
      local1.push(ANDROID_SCREEN_BEGINNER_QUEST);
      local1.push(ANDROID_SCREEN_COMMUNICATOR_NEWS);
      local1.push(ANDROID_SCREEN_UNKNOWN);
      local1.push(ANDROID_SCREEN_SETTINGS_ACCOUNT);
      local1.push(ANDROID_SCREEN_SETTINGS_GRAPHIC);
      local1.push(ANDROID_SCREEN_SETTINGS_SOUND);
      local1.push(ANDROID_SCREEN_SETTINGS_GAME);
      local1.push(ANDROID_SCREEN_SETTINGS_CONTROL);
      local1.push(ANDROID_SCREEN_SETTINGS_HUD);
      local1.push(ANDROID_SCREEN_GARAGE_WEAPON);
      local1.push(ANDROID_SCREEN_GARAGE_ARMOR);
      local1.push(ANDROID_SCREEN_GARAGE_PAINT);
      local1.push(ANDROID_SCREEN_GARAGE_INVENTORY);
      local1.push(ANDROID_SCREEN_GARAGE_KIT);
      local1.push(ANDROID_SCREEN_GARAGE_SPECIAL);
      local1.push(ANDROID_SCREEN_GARAGE_GIVEN_PRESENTS);
      local1.push(ANDROID_SCREEN_GARAGE_RESISTANCE);
      local1.push(ANDROID_SCREEN_GARAGE_DRONE);
      local1.push(ANDROID_SCREEN_GARAGE_SKINS);
      local1.push(ANDROID_SCREEN_SHOP_CRYSTALS);
      local1.push(ANDROID_SCREEN_SHOP_PREMIUM);
      local1.push(ANDROID_SCREEN_SHOP_GOLD_BOXES);
      local1.push(ANDROID_SCREEN_SHOP_PAINTS);
      local1.push(ANDROID_SCREEN_SHOP_KITS);
      local1.push(ANDROID_SCREEN_SHOP_OTHERS);
      local1.push(ANDROID_SCREEN_SHOP_LOOT_BOXES);
      local1.push(ANDROID_SCREEN_SHOP_NO_CATEGORY);
      return local1;
    }

    public function toString() : String {
      return "GameScreen [" + this._name + "]";
    }

    public function get value() : int {
      return this._value;
    }

    public function get name() : String {
      return this._name;
    }
  }
}
