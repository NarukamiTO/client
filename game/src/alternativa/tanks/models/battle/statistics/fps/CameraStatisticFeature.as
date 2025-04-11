package alternativa.tanks.models.battle.statistics.fps {
  import alternativa.tanks.battle.BattleService;
  import alternativa.tanks.camera.GameCamera;

  public class CameraStatisticFeature {
    [Inject]
    public static var battleService:BattleService;

    private var fieldName:String;
    private var bit:int;

    public function CameraStatisticFeature(param1:String, param2:int) {
      super();
      this.fieldName = param1;
      this.bit = param2;
    }

    public function isTesting() : Boolean {
      var local1:Number = this.getStrength();
      return 0 < local1 && local1 < 1;
    }

    public function getMask() : int {
      return this.getStrength() == 1 ? this.bit : 0;
    }

    private function getStrength() : Number {
      var local1:GameCamera = battleService.getBattleScene3D().getCamera();
      return local1[this.fieldName];
    }
  }
}
