package alternativa.tanks.service.settings.keybinding {
  import alternativa.tanks.AbstractEnum;

  public class GameActionEnum extends AbstractEnum {
    private static var _values:Vector.<GameActionEnum> = new Vector.<GameActionEnum>();

    public static const ROTATE_TURRET_LEFT:GameActionEnum = create("ROTATE_TURRET_LEFT");
    public static const ROTATE_TURRET_RIGHT:GameActionEnum = create("ROTATE_TURRET_RIGHT");
    public static const CENTER_TURRET:GameActionEnum = create("CENTER_TURRET");
    public static const CHASSIS_LEFT_MOVEMENT:GameActionEnum = create("CHASSIS_LEFT_MOVEMENT");
    public static const CHASSIS_RIGHT_MOVEMENT:GameActionEnum = create("CHASSIS_RIGHT_MOVEMENT");
    public static const CHASSIS_FORWARD_MOVEMENT:GameActionEnum = create("CHASSIS_FORWARD_MOVEMENT");
    public static const CHASSIS_BACKWARD_MOVEMENT:GameActionEnum = create("CHASSIS_BACKWARD_MOVEMENT");
    public static const FOLLOW_CAMERA_UP:GameActionEnum = create("FOLLOW_CAMERA_UP");
    public static const FOLLOW_CAMERA_DOWN:GameActionEnum = create("FOLLOW_CAMERA_DOWN");
    public static const DROP_FLAG:GameActionEnum = create("DROP_FLAG");
    public static const BATTLE_PAUSE:GameActionEnum = create("BATTLE_PAUSE");
    public static const BATTLE_VIEW_INCREASE:GameActionEnum = create("BATTLE_VIEW_INCREASE");
    public static const BATTLE_VIEW_DECREASE:GameActionEnum = create("BATTLE_VIEW_DECREASE");
    public static const FULL_SCREEN:GameActionEnum = create("FULL_SCREEN");
    public static const SUICIDE:GameActionEnum = create("SUICIDE");
    public static const SHOW_TANK_PARAMETERS:GameActionEnum = create("SHOW_TANK_PARAMETERS");
    public static const USE_FIRS_AID:GameActionEnum = create("USE_FIRS_AID");
    public static const USE_DOUBLE_ARMOR:GameActionEnum = create("USE_DOUBLE_ARMOR");
    public static const USE_DOUBLE_DAMAGE:GameActionEnum = create("USE_DOUBLE_DAMAGE");
    public static const USE_NITRO:GameActionEnum = create("USE_NITRO");
    public static const USE_MINE:GameActionEnum = create("USE_MINE");
    public static const DROP_GOLD_BOX:GameActionEnum = create("DROP_GOLD_BOX");
    public static const SHOT:GameActionEnum = create("SHOT");
    public static const ULTIMATE:GameActionEnum = create("ULTIMATE");
    public static const OPEN_GARAGE:GameActionEnum = create("OPEN_GARAGE");
    public static const SHOW_BATTLE_STATS_TABLE:GameActionEnum = create("SHOW_BATTLE_STATS_TABLE");
    public static const LOOK_AROUND:GameActionEnum = create("LOOK_AROUND");

    public function GameActionEnum(param1:int, param2:String) {
      super(param1,param2);
    }

    private static function create(param1:String) : GameActionEnum {
      var local2:GameActionEnum = new GameActionEnum(_values.length,param1);
      _values.push(local2);
      return local2;
    }

    public static function get values() : Vector.<GameActionEnum> {
      return _values;
    }
  }
}
