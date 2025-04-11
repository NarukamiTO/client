package alternativa.tanks.models.weapon.artillery.sfx {
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;

  public class ArtillerySfxAdapt implements ArtillerySfx {
    private var object:IGameObject;
    private var impl:ArtillerySfx;

    public function ArtillerySfxAdapt(param1:IGameObject, param2:ArtillerySfx) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function getSfxData() : ArtillerySfxData {
      var result:ArtillerySfxData = null;
      try {
        Model.object = this.object;
        result = this.impl.getSfxData();
      }
      finally {
        Model.popObject();
      }
      return result;
    }
  }
}
