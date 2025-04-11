package alternativa.tanks.models.weapon.shaft {
  import alternativa.tanks.models.weapon.WeaponObject;
  import alternativa.tanks.models.weapon.laser.LaserPointer;
  import platform.client.fp10.core.type.IGameObject;

  public class ShaftObject extends WeaponObject {
    public function ShaftObject(param1:IGameObject) {
      super(param1);
    }

    public function getEffects() : ShaftEffects {
      var local1:IShaftSFXModel = IShaftSFXModel(object.adapt(IShaftSFXModel));
      return local1.getEffects();
    }

    public function laser() : LaserPointer {
      return LaserPointer(object.adapt(LaserPointer));
    }
  }
}
