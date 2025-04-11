package alternativa.tanks.models.tank.configuration {
  import alternativa.types.Long;
  import platform.client.fp10.core.type.IGameObject;
  import projects.tanks.client.battlefield.models.user.configuration.ITankConfigurationModelBase;
  import projects.tanks.client.battlefield.models.user.configuration.TankConfigurationModelBase;

  [ModelInfo]
  public class TankConfigurationModel extends TankConfigurationModelBase implements ITankConfigurationModelBase, TankConfiguration {
    public function TankConfigurationModel() {
      super();
    }

    public function getHullObject() : IGameObject {
      return object.space.getObject(getInitParam().hullId);
    }

    public function getWeaponObject() : IGameObject {
      return object.space.getObject(getInitParam().weaponId);
    }

    public function getColoringObject() : IGameObject {
      return object.space.getObject(getInitParam().coloringId);
    }

    public function hasDrone() : Boolean {
      return getInitParam().droneId != Long.getLong(0,0);
    }

    public function getDrone() : IGameObject {
      return object.space.getObject(getInitParam().droneId);
    }
  }
}
