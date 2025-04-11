package alternativa.tanks.battle.objects.tank.controllers {
  import alternativa.tanks.service.settings.keybinding.GameActionEnum;
  import flash.utils.Dictionary;

  public class TurretActions {
    public static const LEFT:int = 1;
    public static const RIGHT:int = 2;
    public static const CENTER:int = 4;
    public static const UP:int = 8;
    public static const DOWN:int = 16;
    public static const DEFAULT:TurretActions = createDefault();

    private var mappings:Dictionary = new Dictionary();

    public function TurretActions() {
      super();
    }

    private static function createDefault() : TurretActions {
      var local1:TurretActions = new TurretActions();
      local1.setMapping(GameActionEnum.ROTATE_TURRET_LEFT,LEFT);
      local1.setMapping(GameActionEnum.ROTATE_TURRET_RIGHT,RIGHT);
      local1.setMapping(GameActionEnum.CENTER_TURRET,CENTER);
      return local1;
    }

    public function setMapping(param1:GameActionEnum, param2:int) : void {
      this.mappings[param1] = param2;
    }

    public function getTurretAction(param1:GameActionEnum) : int {
      return this.mappings[param1];
    }
  }
}
