package alternativa.tanks.models.battle.debug {
  import alternativa.tanks.battle.BattleService;
  import projects.tanks.client.battlefield.models.battle.battlefield.debug.BattleDebugModelBase;
  import projects.tanks.client.battlefield.models.battle.battlefield.debug.IBattleDebugModelBase;
  import projects.tanks.client.battlefield.types.Vector3d;

  [ModelInfo]
  public class BattleDebugModel extends BattleDebugModelBase implements IBattleDebugModelBase {
    [Inject]
    public static var battleService:BattleService;

    public function BattleDebugModel() {
      super();
    }

    public function addFrame(param1:Number, param2:int, param3:Vector.<Vector3d>, param4:int) : void {
    }

    public function addGizmo(param1:Number, param2:int, param3:Vector3d, param4:Vector3d, param5:int) : void {
    }

    public function addMarker(param1:Number, param2:int, param3:Vector3d, param4:int) : void {
      battleService.getBattleScene3D().addMarker(param1,param2,param3.x,param3.y,param3.z);
    }
  }
}
