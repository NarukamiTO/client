package _codec.projects.tanks.client.tanksservices.model.logging.gamescreen {
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import projects.tanks.client.tanksservices.model.logging.gamescreen.GameScreen;

  public class CodecGameScreen implements ICodec {
    public function CodecGameScreen() {
      super();
    }

    public function init(param1:IProtocol) : void {
    }

    public function decode(param1:ProtocolBuffer) : Object {
      var local2:GameScreen = null;
      var local3:int = int(param1.reader.readInt());
      switch(local3) {
        case 0:
          local2 = GameScreen.PAYMENT;
          break;
        case 1:
          local2 = GameScreen.QUESTS;
          break;
        case 2:
          local2 = GameScreen.BATTLE_SELECT;
          break;
        case 3:
          local2 = GameScreen.GARAGE;
          break;
        case 4:
          local2 = GameScreen.FRIENDS;
          break;
        case 5:
          local2 = GameScreen.SETTINGS;
          break;
        case 6:
          local2 = GameScreen.BATTLE;
          break;
        case 7:
          local2 = GameScreen.STATISTICS;
          break;
        case 8:
          local2 = GameScreen.EXIT_GAME;
          break;
        case 9:
          local2 = GameScreen.CLAN;
          break;
        case 10:
          local2 = GameScreen.MATCHMAKING;
          break;
        case 11:
          local2 = GameScreen.ANDROID_SCREEN_HOME;
          break;
        case 12:
          local2 = GameScreen.ANDROID_SCREEN_BATTLES;
          break;
        case 13:
          local2 = GameScreen.ANDROID_SCREEN_QUEST;
          break;
        case 14:
          local2 = GameScreen.ANDROID_SCREEN_WEEKLY_REWARDS;
          break;
        case 15:
          local2 = GameScreen.ANDROID_SCREEN_BEGINNER_QUEST;
          break;
        case 16:
          local2 = GameScreen.ANDROID_SCREEN_COMMUNICATOR_NEWS;
          break;
        case 17:
          local2 = GameScreen.ANDROID_SCREEN_UNKNOWN;
          break;
        case 18:
          local2 = GameScreen.ANDROID_SCREEN_SETTINGS_ACCOUNT;
          break;
        case 19:
          local2 = GameScreen.ANDROID_SCREEN_SETTINGS_GRAPHIC;
          break;
        case 20:
          local2 = GameScreen.ANDROID_SCREEN_SETTINGS_SOUND;
          break;
        case 21:
          local2 = GameScreen.ANDROID_SCREEN_SETTINGS_GAME;
          break;
        case 22:
          local2 = GameScreen.ANDROID_SCREEN_SETTINGS_CONTROL;
          break;
        case 23:
          local2 = GameScreen.ANDROID_SCREEN_SETTINGS_HUD;
          break;
        case 24:
          local2 = GameScreen.ANDROID_SCREEN_GARAGE_WEAPON;
          break;
        case 25:
          local2 = GameScreen.ANDROID_SCREEN_GARAGE_ARMOR;
          break;
        case 26:
          local2 = GameScreen.ANDROID_SCREEN_GARAGE_PAINT;
          break;
        case 27:
          local2 = GameScreen.ANDROID_SCREEN_GARAGE_INVENTORY;
          break;
        case 28:
          local2 = GameScreen.ANDROID_SCREEN_GARAGE_KIT;
          break;
        case 29:
          local2 = GameScreen.ANDROID_SCREEN_GARAGE_SPECIAL;
          break;
        case 30:
          local2 = GameScreen.ANDROID_SCREEN_GARAGE_GIVEN_PRESENTS;
          break;
        case 31:
          local2 = GameScreen.ANDROID_SCREEN_GARAGE_RESISTANCE;
          break;
        case 32:
          local2 = GameScreen.ANDROID_SCREEN_GARAGE_DRONE;
          break;
        case 33:
          local2 = GameScreen.ANDROID_SCREEN_GARAGE_SKINS;
          break;
        case 34:
          local2 = GameScreen.ANDROID_SCREEN_SHOP_CRYSTALS;
          break;
        case 35:
          local2 = GameScreen.ANDROID_SCREEN_SHOP_PREMIUM;
          break;
        case 36:
          local2 = GameScreen.ANDROID_SCREEN_SHOP_GOLD_BOXES;
          break;
        case 37:
          local2 = GameScreen.ANDROID_SCREEN_SHOP_PAINTS;
          break;
        case 38:
          local2 = GameScreen.ANDROID_SCREEN_SHOP_KITS;
          break;
        case 39:
          local2 = GameScreen.ANDROID_SCREEN_SHOP_OTHERS;
          break;
        case 40:
          local2 = GameScreen.ANDROID_SCREEN_SHOP_LOOT_BOXES;
          break;
        case 41:
          local2 = GameScreen.ANDROID_SCREEN_SHOP_NO_CATEGORY;
      }
      return local2;
    }

    public function encode(param1:ProtocolBuffer, param2:Object) : void {
      if(param2 == null) {
        throw new Error("Object is null. Use @ProtocolOptional annotation.");
      }
      var local3:int = int(param2.value);
      param1.writer.writeInt(local3);
    }
  }
}
