package alternativa.tanks.models.battle.facilities {
  import alternativa.math.Vector3;
  import alternativa.tanks.battle.objects.tank.Tank;
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;

  public class BattleFacilitiesCheckerAdapt implements BattleFacilitiesChecker {
    private var object:IGameObject;
    private var impl:BattleFacilitiesChecker;

    public function BattleFacilitiesCheckerAdapt(param1:IGameObject, param2:BattleFacilitiesChecker) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function checkFacilityZonesDemandsStateCorrection(param1:Vector3, param2:Vector3) : Boolean {
      var result:Boolean = false;
      var previousSentPosition:Vector3 = param1;
      var currentPosition:Vector3 = param2;
      try {
        Model.object = this.object;
        result = Boolean(this.impl.checkFacilityZonesDemandsStateCorrection(previousSentPosition,currentPosition));
      }
      finally {
        Model.popObject();
      }
      return result;
    }

    public function onMoveCommand(param1:Tank, param2:Vector3, param3:Vector3) : void {
      var tank:Tank = param1;
      var prevPosition:Vector3 = param2;
      var newPosition:Vector3 = param3;
      try {
        Model.object = this.object;
        this.impl.onMoveCommand(tank,prevPosition,newPosition);
      }
      finally {
        Model.popObject();
      }
    }
  }
}
