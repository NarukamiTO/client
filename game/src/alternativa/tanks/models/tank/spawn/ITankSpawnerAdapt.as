package alternativa.tanks.models.tank.spawn {
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;

  public class ITankSpawnerAdapt implements ITankSpawner {
    private var object:IGameObject;
    private var impl:ITankSpawner;

    public function ITankSpawnerAdapt(param1:IGameObject, param2:ITankSpawner) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function getIncarnationId() : int {
      var result:int = 0;
      try {
        Model.object = this.object;
        result = int(this.impl.getIncarnationId());
      }
      finally {
        Model.popObject();
      }
      return result;
    }

    public function readyToSpawn() : void {
      try {
        Model.object = this.object;
        this.impl.readyToSpawn();
      }
      finally {
        Model.popObject();
      }
    }

    public function setLocal() : void {
      try {
        Model.object = this.object;
        this.impl.setLocal();
      }
      finally {
        Model.popObject();
      }
    }

    public function setRemote() : void {
      try {
        Model.object = this.object;
        this.impl.setRemote();
      }
      finally {
        Model.popObject();
      }
    }

    public function setReadyToPlace() : void {
      try {
        Model.object = this.object;
        this.impl.setReadyToPlace();
      }
      finally {
        Model.popObject();
      }
    }
  }
}
