package alternativa.tanks.models.tank {
  import alternativa.tanks.battle.objects.tank.Tank;
  import alternativa.tanks.battle.objects.tank.WeaponMount;
  import alternativa.tanks.battle.objects.tank.controllers.ChassisController;
  import alternativa.tanks.display.usertitle.UserTitle;
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;
  import projects.tanks.client.battlefield.types.Vector3d;

  public class ITankModelAdapt implements ITankModel {
    private var object:IGameObject;
    private var impl:ITankModel;

    public function ITankModelAdapt(param1:IGameObject, param2:ITankModel) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function getTank() : Tank {
      var result:Tank = null;
      try {
        Model.object = this.object;
        result = this.impl.getTank();
      }
      finally {
        Model.popObject();
      }
      return result;
    }

    public function lockMovementControl(param1:int) : void {
      var bits:int = param1;
      try {
        Model.object = this.object;
        this.impl.lockMovementControl(bits);
      }
      finally {
        Model.popObject();
      }
    }

    public function unlockMovementControl(param1:int) : void {
      var bits:int = param1;
      try {
        Model.object = this.object;
        this.impl.unlockMovementControl(bits);
      }
      finally {
        Model.popObject();
      }
    }

    public function getWeaponController() : IWeaponController {
      var result:IWeaponController = null;
      try {
        Model.object = this.object;
        result = this.impl.getWeaponController();
      }
      finally {
        Model.popObject();
      }
      return result;
    }

    public function getChassisController() : ChassisController {
      var result:ChassisController = null;
      try {
        Model.object = this.object;
        result = this.impl.getChassisController();
      }
      finally {
        Model.popObject();
      }
      return result;
    }

    public function getWeaponMount() : WeaponMount {
      var result:WeaponMount = null;
      try {
        Model.object = this.object;
        result = this.impl.getWeaponMount();
      }
      finally {
        Model.popObject();
      }
      return result;
    }

    public function getTitle() : UserTitle {
      var result:UserTitle = null;
      try {
        Model.object = this.object;
        result = this.impl.getTitle();
      }
      finally {
        Model.popObject();
      }
      return result;
    }

    public function getUserInfo() : UserInfo {
      var result:UserInfo = null;
      try {
        Model.object = this.object;
        result = this.impl.getUserInfo();
      }
      finally {
        Model.popObject();
      }
      return result;
    }

    public function sendStateCorrection(param1:Boolean) : void {
      var mandatoryCorrection:Boolean = param1;
      try {
        Model.object = this.object;
        this.impl.sendStateCorrection(mandatoryCorrection);
      }
      finally {
        Model.popObject();
      }
    }

    public function onPrevStateCorrection(param1:Boolean) : void {
      var mandatoryCorrection:Boolean = param1;
      try {
        Model.object = this.object;
        this.impl.onPrevStateCorrection(mandatoryCorrection);
      }
      finally {
        Model.popObject();
      }
    }

    public function handleCollisionWithOtherTank(param1:Tank) : void {
      var tank:Tank = param1;
      try {
        Model.object = this.object;
        this.impl.handleCollisionWithOtherTank(tank);
      }
      finally {
        Model.popObject();
      }
    }

    public function sendDeathConfirmationCommand() : void {
      try {
        Model.object = this.object;
        this.impl.sendDeathConfirmationCommand();
      }
      finally {
        Model.popObject();
      }
    }

    public function disableStateCorrection() : void {
      try {
        Model.object = this.object;
        this.impl.disableStateCorrection();
      }
      finally {
        Model.popObject();
      }
    }

    public function enableStateCorrection() : void {
      try {
        Model.object = this.object;
        this.impl.enableStateCorrection();
      }
      finally {
        Model.popObject();
      }
    }

    public function die(param1:int) : void {
      var respawnDelay:int = param1;
      try {
        Model.object = this.object;
        this.impl.die(respawnDelay);
      }
      finally {
        Model.popObject();
      }
    }

    public function isLocal() : Boolean {
      var result:Boolean = false;
      try {
        Model.object = this.object;
        result = Boolean(this.impl.isLocal());
      }
      finally {
        Model.popObject();
      }
      return result;
    }

    public function configureTankTitleAsRemote(param1:IGameObject) : void {
      var user:IGameObject = param1;
      try {
        Model.object = this.object;
        this.impl.configureTankTitleAsRemote(user);
      }
      finally {
        Model.popObject();
      }
    }

    public function configureRemoteTankTitles() : void {
      try {
        Model.object = this.object;
        this.impl.configureRemoteTankTitles();
      }
      finally {
        Model.popObject();
      }
    }

    public function addTankToBattle() : void {
      try {
        Model.object = this.object;
        this.impl.addTankToBattle();
      }
      finally {
        Model.popObject();
      }
    }

    public function removeTankFromBattle() : void {
      try {
        Model.object = this.object;
        this.impl.removeTankFromBattle();
      }
      finally {
        Model.popObject();
      }
    }

    public function doSetHealth(param1:Number) : void {
      var health:Number = param1;
      try {
        Model.object = this.object;
        this.impl.doSetHealth(health);
      }
      finally {
        Model.popObject();
      }
    }

    public function setChassisState(param1:Vector3d, param2:Vector3d, param3:Vector3d, param4:Vector3d, param5:int, param6:int) : void {
      var position:Vector3d = param1;
      var orientation:Vector3d = param2;
      var linearVelocity:Vector3d = param3;
      var angularVelocity:Vector3d = param4;
      var controlState:int = param5;
      var turnSpeedNumber:int = param6;
      try {
        Model.object = this.object;
        this.impl.setChassisState(position,orientation,linearVelocity,angularVelocity,controlState,turnSpeedNumber);
      }
      finally {
        Model.popObject();
      }
    }

    public function getMovementAnticheatTask() : MovementTimeoutAndDistanceAnticheatTask {
      var result:MovementTimeoutAndDistanceAnticheatTask = null;
      try {
        Model.object = this.object;
        result = this.impl.getMovementAnticheatTask();
      }
      finally {
        Model.popObject();
      }
      return result;
    }

    public function addTankToExclusionSet(param1:Tank) : void {
      var tank:Tank = param1;
      try {
        Model.object = this.object;
        this.impl.addTankToExclusionSet(tank);
      }
      finally {
        Model.popObject();
      }
    }

    public function getTankSet() : TankSet {
      var result:TankSet = null;
      try {
        Model.object = this.object;
        result = this.impl.getTankSet();
      }
      finally {
        Model.popObject();
      }
      return result;
    }
  }
}
