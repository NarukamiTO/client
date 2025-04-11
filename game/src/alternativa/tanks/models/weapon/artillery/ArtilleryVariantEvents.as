package alternativa.tanks.models.weapon.artillery {
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;

  public class ArtilleryVariantEvents implements ArtilleryVariant {
    private var object:IGameObject;
    private var impl:Vector.<Object>;

    public function ArtilleryVariantEvents(param1:IGameObject, param2:Vector.<Object>) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function initArtilleryVariant(param1:IGameObject, param2:ArtilleryWeapon, param3:Boolean) : void {
      var i:int = 0;
      var m:ArtilleryVariant = null;
      var user:IGameObject = param1;
      var weapon:ArtilleryWeapon = param2;
      var isLocal:Boolean = param3;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = ArtilleryVariant(this.impl[i]);
          m.initArtilleryVariant(user,weapon,isLocal);
          i++;
        }
      }
      finally {
        Model.popObject();
      }
    }
  }
}
