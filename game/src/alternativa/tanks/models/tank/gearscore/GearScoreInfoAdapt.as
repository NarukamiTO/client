package alternativa.tanks.models.tank.gearscore {
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;

  public class GearScoreInfoAdapt implements GearScoreInfo {
    private var object:IGameObject;
    private var impl:GearScoreInfo;

    public function GearScoreInfoAdapt(param1:IGameObject, param2:GearScoreInfo) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function getScore() : int {
      var result:int = 0;
      try {
        Model.object = this.object;
        result = int(this.impl.getScore());
      }
      finally {
        Model.popObject();
      }
      return result;
    }
  }
}
