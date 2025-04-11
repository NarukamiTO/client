package alternativa.tanks.models.battle.battlefield.mine {
  import alternativa.math.Vector3;
  import alternativa.types.Long;
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;

  public class IBattleMinesModelAdapt implements IBattleMinesModel {
    private var object:IGameObject;
    private var impl:IBattleMinesModel;

    public function IBattleMinesModelAdapt(param1:IGameObject, param2:IBattleMinesModel) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function getMinDistanceFromBase() : Number {
      var result:Number = NaN;
      try {
        Model.object = this.object;
        result = Number(this.impl.getMinDistanceFromBase());
      }
      finally {
        Model.popObject();
      }
      return result;
    }

    public function getMinePosition(param1:Long) : Vector3 {
      var result:Vector3 = null;
      var mineId:Long = param1;
      try {
        Model.object = this.object;
        result = this.impl.getMinePosition(mineId);
      }
      finally {
        Model.popObject();
      }
      return result;
    }
  }
}
