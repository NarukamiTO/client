package projects.tanks.client.battlefield.models.bonus.battle {
  import alternativa.types.Long;
  import platform.client.fp10.core.type.IGameObject;
  import projects.tanks.client.battlefield.types.Vector3d;

  public class BonusSpawnData {
    private var _battleBonusObject:IGameObject;
    private var _bonusId:Long;
    private var _lifeTime:int;
    private var _spawnPosition:Vector3d;

    public function BonusSpawnData(param1:IGameObject = null, param2:Long = null, param3:int = 0, param4:Vector3d = null) {
      super();
      this._battleBonusObject = param1;
      this._bonusId = param2;
      this._lifeTime = param3;
      this._spawnPosition = param4;
    }

    public function get battleBonusObject() : IGameObject {
      return this._battleBonusObject;
    }

    public function set battleBonusObject(param1:IGameObject) : void {
      this._battleBonusObject = param1;
    }

    public function get bonusId() : Long {
      return this._bonusId;
    }

    public function set bonusId(param1:Long) : void {
      this._bonusId = param1;
    }

    public function get lifeTime() : int {
      return this._lifeTime;
    }

    public function set lifeTime(param1:int) : void {
      this._lifeTime = param1;
    }

    public function get spawnPosition() : Vector3d {
      return this._spawnPosition;
    }

    public function set spawnPosition(param1:Vector3d) : void {
      this._spawnPosition = param1;
    }

    public function toString() : String {
      var local1:String = "BonusSpawnData [";
      local1 += "battleBonusObject = " + this.battleBonusObject + " ";
      local1 += "bonusId = " + this.bonusId + " ";
      local1 += "lifeTime = " + this.lifeTime + " ";
      local1 += "spawnPosition = " + this.spawnPosition + " ";
      return local1 + "]";
    }
  }
}
