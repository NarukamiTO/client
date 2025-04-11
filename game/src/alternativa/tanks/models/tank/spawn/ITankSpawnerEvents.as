package alternativa.tanks.models.tank.spawn {
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;

  public class ITankSpawnerEvents implements ITankSpawner {
    private var object:IGameObject;
    private var impl:Vector.<Object>;

    public function ITankSpawnerEvents(param1:IGameObject, param2:Vector.<Object>) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function getIncarnationId() : int {
      var result:int = 0;
      var i:int = 0;
      var m:ITankSpawner = null;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = ITankSpawner(this.impl[i]);
          result = int(m.getIncarnationId());
          i++;
        }
      }
      finally {
        Model.popObject();
      }
      return result;
    }

    public function readyToSpawn() : void {
      var i:int = 0;
      var m:ITankSpawner = null;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = ITankSpawner(this.impl[i]);
          m.readyToSpawn();
          i++;
        }
      }
      finally {
        Model.popObject();
      }
    }

    public function setLocal() : void {
      var i:int = 0;
      var m:ITankSpawner = null;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = ITankSpawner(this.impl[i]);
          m.setLocal();
          i++;
        }
      }
      finally {
        Model.popObject();
      }
    }

    public function setRemote() : void {
      var i:int = 0;
      var m:ITankSpawner = null;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = ITankSpawner(this.impl[i]);
          m.setRemote();
          i++;
        }
      }
      finally {
        Model.popObject();
      }
    }

    public function setReadyToPlace() : void {
      var i:int = 0;
      var m:ITankSpawner = null;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = ITankSpawner(this.impl[i]);
          m.setReadyToPlace();
          i++;
        }
      }
      finally {
        Model.popObject();
      }
    }
  }
}
