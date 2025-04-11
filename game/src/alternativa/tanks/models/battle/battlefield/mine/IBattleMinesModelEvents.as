package alternativa.tanks.models.battle.battlefield.mine {
  import alternativa.math.Vector3;
  import alternativa.types.Long;
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;

  public class IBattleMinesModelEvents implements IBattleMinesModel {
    private var object:IGameObject;
    private var impl:Vector.<Object>;

    public function IBattleMinesModelEvents(param1:IGameObject, param2:Vector.<Object>) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function getMinDistanceFromBase() : Number {
      var result:Number = NaN;
      var i:int = 0;
      var m:IBattleMinesModel = null;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = IBattleMinesModel(this.impl[i]);
          result = Number(m.getMinDistanceFromBase());
          i++;
        }
      }
      finally {
        Model.popObject();
      }
      return result;
    }

    public function getMinePosition(param1:Long) : Vector3 {
      var result:Vector3 = null;
      var i:int = 0;
      var m:IBattleMinesModel = null;
      var mineId:Long = param1;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = IBattleMinesModel(this.impl[i]);
          result = m.getMinePosition(mineId);
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
