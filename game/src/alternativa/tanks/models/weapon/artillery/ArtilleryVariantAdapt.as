package alternativa.tanks.models.weapon.artillery {
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;

  public class ArtilleryVariantAdapt implements ArtilleryVariant {
    private var object:IGameObject;
    private var impl:ArtilleryVariant;

    public function ArtilleryVariantAdapt(param1:IGameObject, param2:ArtilleryVariant) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function initArtilleryVariant(param1:IGameObject, param2:ArtilleryWeapon, param3:Boolean) : void {
      var user:IGameObject = param1;
      var weapon:ArtilleryWeapon = param2;
      var isLocal:Boolean = param3;
      try {
        Model.object = this.object;
        this.impl.initArtilleryVariant(user,weapon,isLocal);
      }
      finally {
        Model.popObject();
      }
    }
  }
}
