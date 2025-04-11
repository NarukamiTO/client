package alternativa.tanks.models.weapons.targeting.debug {
  import alternativa.engine3d.primitives.Box;
  import alternativa.math.Matrix3;
  import alternativa.math.Vector3;
  import alternativa.osgi.service.console.variables.ConsoleVarInt;
  import alternativa.tanks.battle.BattleService;
  import alternativa.tanks.models.weapon.AllGlobalGunParams;

  public class TargetingVisualDebug {
    [Inject]
    public static var battleService:BattleService;

    private static var targetingDebug:ConsoleVarInt = new ConsoleVarInt("targeting_debug",0,0,1);

    private var boxes:Vector.<Box> = new Vector.<Box>();
    private var xAxis:Vector3 = new Vector3();
    private var zAxis:Vector3 = new Vector3();
    private var rotationMatrix:Matrix3 = new Matrix3();

    public function TargetingVisualDebug() {
      super();
    }

    public function reset() : void {
    }

    public function addRay(param1:AllGlobalGunParams, param2:Vector3, param3:Number, param4:Vector3 = null) : void {
    }

    private function createBox(param1:Number, param2:Number, param3:Number, param4:uint = 65535) : Box {
      return null;
    }
  }
}
