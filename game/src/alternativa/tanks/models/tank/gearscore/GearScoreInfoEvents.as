package alternativa.tanks.models.tank.gearscore {
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;

  public class GearScoreInfoEvents implements GearScoreInfo {
    private var object:IGameObject;
    private var impl:Vector.<Object>;

    public function GearScoreInfoEvents(param1:IGameObject, param2:Vector.<Object>) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function getScore() : int {
      var result:int = 0;
      var i:int = 0;
      var m:GearScoreInfo = null;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = GearScoreInfo(this.impl[i]);
          result = int(m.getScore());
          i++;
        }
      }
      finally {
        Model.popObject();
      }
      return result;
    }
  }
}
