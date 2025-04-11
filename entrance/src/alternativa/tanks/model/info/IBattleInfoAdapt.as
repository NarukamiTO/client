package alternativa.tanks.model.info {
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.resource.types.ImageResource;
  import platform.client.fp10.core.type.IGameObject;
  import projects.tanks.client.battleselect.model.battle.BattleInfoCC;

  public class IBattleInfoAdapt implements IBattleInfo {
    private var object:IGameObject;
    private var impl:IBattleInfo;

    public function IBattleInfoAdapt(param1:IGameObject, param2:IBattleInfo) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function getConstructor() : BattleInfoCC {
      var result:BattleInfoCC = null;
      try {
        Model.object = this.object;
        result = this.impl.getConstructor();
      }
      finally {
        Model.popObject();
      }
      return result;
    }

    public function getPreviewResource() : ImageResource {
      var result:ImageResource = null;
      try {
        Model.object = this.object;
        result = this.impl.getPreviewResource();
      }
      finally {
        Model.popObject();
      }
      return result;
    }
  }
}
