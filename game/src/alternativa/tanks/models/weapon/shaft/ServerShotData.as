package alternativa.tanks.models.weapon.shaft {
  import platform.client.fp10.core.type.IGameObject;
  import projects.tanks.client.battlefield.types.Vector3d;

  internal class ServerShotData {
    public var staticHitPoint:Vector3d;
    public var hitPoint:Vector3d;
    public var tank:IGameObject;
    public var incarnation:int;
    public var tankPosition:Vector3d;
    public var targetPositionGlobal:Vector3d;

    public function ServerShotData(param1:Vector3d, param2:Vector3d, param3:IGameObject, param4:int, param5:Vector3d, param6:Vector3d) {
      super();
      this.staticHitPoint = param1;
      this.hitPoint = param2;
      this.tank = param3;
      this.incarnation = param4;
      this.tankPosition = param5;
      this.targetPositionGlobal = param6;
    }
  }
}
