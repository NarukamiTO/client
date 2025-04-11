package alternativa.tanks.models.tank.configuration {
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;

  public class TankConfigurationEvents implements TankConfiguration {
    private var object:IGameObject;
    private var impl:Vector.<Object>;

    public function TankConfigurationEvents(param1:IGameObject, param2:Vector.<Object>) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function getHullObject() : IGameObject {
      var result:IGameObject = null;
      var i:int = 0;
      var m:TankConfiguration = null;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = TankConfiguration(this.impl[i]);
          result = m.getHullObject();
          i++;
        }
      }
      finally {
        Model.popObject();
      }
      return result;
    }

    public function getWeaponObject() : IGameObject {
      var result:IGameObject = null;
      var i:int = 0;
      var m:TankConfiguration = null;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = TankConfiguration(this.impl[i]);
          result = m.getWeaponObject();
          i++;
        }
      }
      finally {
        Model.popObject();
      }
      return result;
    }

    public function getColoringObject() : IGameObject {
      var result:IGameObject = null;
      var i:int = 0;
      var m:TankConfiguration = null;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = TankConfiguration(this.impl[i]);
          result = m.getColoringObject();
          i++;
        }
      }
      finally {
        Model.popObject();
      }
      return result;
    }

    public function hasDrone() : Boolean {
      var result:Boolean = false;
      var i:int = 0;
      var m:TankConfiguration = null;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = TankConfiguration(this.impl[i]);
          result = Boolean(m.hasDrone());
          i++;
        }
      }
      finally {
        Model.popObject();
      }
      return result;
    }

    public function getDrone() : IGameObject {
      var result:IGameObject = null;
      var i:int = 0;
      var m:TankConfiguration = null;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = TankConfiguration(this.impl[i]);
          result = m.getDrone();
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
