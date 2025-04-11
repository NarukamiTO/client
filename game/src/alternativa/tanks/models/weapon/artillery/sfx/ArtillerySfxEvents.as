package alternativa.tanks.models.weapon.artillery.sfx {
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;

  public class ArtillerySfxEvents implements ArtillerySfx {
    private var object:IGameObject;
    private var impl:Vector.<Object>;

    public function ArtillerySfxEvents(param1:IGameObject, param2:Vector.<Object>) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function getSfxData() : ArtillerySfxData {
      var result:ArtillerySfxData = null;
      var i:int = 0;
      var m:ArtillerySfx = null;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = ArtillerySfx(this.impl[i]);
          result = m.getSfxData();
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
