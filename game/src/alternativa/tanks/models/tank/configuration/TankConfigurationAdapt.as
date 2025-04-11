package alternativa.tanks.models.tank.configuration {
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;

  public class TankConfigurationAdapt implements TankConfiguration {
    private var object:IGameObject;
    private var impl:TankConfiguration;

    public function TankConfigurationAdapt(param1:IGameObject, param2:TankConfiguration) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function getHullObject() : IGameObject {
      var result:IGameObject = null;
      try {
        Model.object = this.object;
        result = this.impl.getHullObject();
      }
      finally {
        Model.popObject();
      }
      return result;
    }

    public function getWeaponObject() : IGameObject {
      var result:IGameObject = null;
      try {
        Model.object = this.object;
        result = this.impl.getWeaponObject();
      }
      finally {
        Model.popObject();
      }
      return result;
    }

    public function getColoringObject() : IGameObject {
      var result:IGameObject = null;
      try {
        Model.object = this.object;
        result = this.impl.getColoringObject();
      }
      finally {
        Model.popObject();
      }
      return result;
    }

    public function hasDrone() : Boolean {
      var result:Boolean = false;
      try {
        Model.object = this.object;
        result = Boolean(this.impl.hasDrone());
      }
      finally {
        Model.popObject();
      }
      return result;
    }

    public function getDrone() : IGameObject {
      var result:IGameObject = null;
      try {
        Model.object = this.object;
        result = this.impl.getDrone();
      }
      finally {
        Model.popObject();
      }
      return result;
    }
  }
}
