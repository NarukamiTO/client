package alternativa.tanks.models.weapon.rocketlauncher.radio {
  import platform.client.fp10.core.type.IGameObject;

  public class RocketExplosionAdapt implements RocketExplosion {
    private var object:IGameObject;
    private var impl:RocketExplosion;

    public function RocketExplosionAdapt(param1:IGameObject, param2:RocketExplosion) {
      super();
      this.object = param1;
      this.impl = param2;
    }
  }
}
