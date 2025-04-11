package alternativa.tanks.models.weapon.rocketlauncher.radio {
  import platform.client.fp10.core.type.IGameObject;

  public class RocketExplosionEvents implements RocketExplosion {
    private var object:IGameObject;
    private var impl:Vector.<Object>;

    public function RocketExplosionEvents(param1:IGameObject, param2:Vector.<Object>) {
      super();
      this.object = param1;
      this.impl = param2;
    }
  }
}
