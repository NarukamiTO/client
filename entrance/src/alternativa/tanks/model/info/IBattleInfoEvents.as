package alternativa.tanks.model.info {
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.resource.types.ImageResource;
  import platform.client.fp10.core.type.IGameObject;
  import projects.tanks.client.battleselect.model.battle.BattleInfoCC;

  public class IBattleInfoEvents implements IBattleInfo {
    private var object:IGameObject;
    private var impl:Vector.<Object>;

    public function IBattleInfoEvents(param1:IGameObject, param2:Vector.<Object>) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function getConstructor() : BattleInfoCC {
      var result:BattleInfoCC = null;
      var i:int = 0;
      var m:IBattleInfo = null;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = IBattleInfo(this.impl[i]);
          result = m.getConstructor();
          i++;
        }
      }
      finally {
        Model.popObject();
      }
      return result;
    }

    public function getPreviewResource() : ImageResource {
      var result:ImageResource = null;
      var i:int = 0;
      var m:IBattleInfo = null;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = IBattleInfo(this.impl[i]);
          result = m.getPreviewResource();
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
