package alternativa.tanks.models.tank {
  import alternativa.tanks.battle.objects.tank.Tank;
  import alternativa.tanks.battle.objects.tank.WeaponMount;
  import alternativa.tanks.battle.objects.tank.controllers.ChassisController;
  import alternativa.tanks.display.usertitle.UserTitle;
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;
  import projects.tanks.client.battlefield.types.Vector3d;

  public class ITankModelEvents implements ITankModel {
    private var object:IGameObject;
    private var impl:Vector.<Object>;

    public function ITankModelEvents(param1:IGameObject, param2:Vector.<Object>) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function getTank() : Tank {
      var result:Tank = null;
      var i:int = 0;
      var m:ITankModel = null;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = ITankModel(this.impl[i]);
          result = m.getTank();
          i++;
        }
      }
      finally {
        Model.popObject();
      }
      return result;
    }

    public function lockMovementControl(param1:int) : void {
      var i:int = 0;
      var m:ITankModel = null;
      var bits:int = param1;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = ITankModel(this.impl[i]);
          m.lockMovementControl(bits);
          i++;
        }
      }
      finally {
        Model.popObject();
      }
    }

    public function unlockMovementControl(param1:int) : void {
      var i:int = 0;
      var m:ITankModel = null;
      var bits:int = param1;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = ITankModel(this.impl[i]);
          m.unlockMovementControl(bits);
          i++;
        }
      }
      finally {
        Model.popObject();
      }
    }

    public function getWeaponController() : IWeaponController {
      var result:IWeaponController = null;
      var i:int = 0;
      var m:ITankModel = null;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = ITankModel(this.impl[i]);
          result = m.getWeaponController();
          i++;
        }
      }
      finally {
        Model.popObject();
      }
      return result;
    }

    public function getChassisController() : ChassisController {
      var result:ChassisController = null;
      var i:int = 0;
      var m:ITankModel = null;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = ITankModel(this.impl[i]);
          result = m.getChassisController();
          i++;
        }
      }
      finally {
        Model.popObject();
      }
      return result;
    }

    public function getWeaponMount() : WeaponMount {
      var result:WeaponMount = null;
      var i:int = 0;
      var m:ITankModel = null;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = ITankModel(this.impl[i]);
          result = m.getWeaponMount();
          i++;
        }
      }
      finally {
        Model.popObject();
      }
      return result;
    }

    public function getTitle() : UserTitle {
      var result:UserTitle = null;
      var i:int = 0;
      var m:ITankModel = null;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = ITankModel(this.impl[i]);
          result = m.getTitle();
          i++;
        }
      }
      finally {
        Model.popObject();
      }
      return result;
    }

    public function getUserInfo() : UserInfo {
      var result:UserInfo = null;
      var i:int = 0;
      var m:ITankModel = null;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = ITankModel(this.impl[i]);
          result = m.getUserInfo();
          i++;
        }
      }
      finally {
        Model.popObject();
      }
      return result;
    }

    public function sendStateCorrection(param1:Boolean) : void {
      var i:int = 0;
      var m:ITankModel = null;
      var mandatoryCorrection:Boolean = param1;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = ITankModel(this.impl[i]);
          m.sendStateCorrection(mandatoryCorrection);
          i++;
        }
      }
      finally {
        Model.popObject();
      }
    }

    public function onPrevStateCorrection(param1:Boolean) : void {
      var i:int = 0;
      var m:ITankModel = null;
      var mandatoryCorrection:Boolean = param1;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = ITankModel(this.impl[i]);
          m.onPrevStateCorrection(mandatoryCorrection);
          i++;
        }
      }
      finally {
        Model.popObject();
      }
    }

    public function handleCollisionWithOtherTank(param1:Tank) : void {
      var i:int = 0;
      var m:ITankModel = null;
      var tank:Tank = param1;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = ITankModel(this.impl[i]);
          m.handleCollisionWithOtherTank(tank);
          i++;
        }
      }
      finally {
        Model.popObject();
      }
    }

    public function sendDeathConfirmationCommand() : void {
      var i:int = 0;
      var m:ITankModel = null;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = ITankModel(this.impl[i]);
          m.sendDeathConfirmationCommand();
          i++;
        }
      }
      finally {
        Model.popObject();
      }
    }

    public function disableStateCorrection() : void {
      var i:int = 0;
      var m:ITankModel = null;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = ITankModel(this.impl[i]);
          m.disableStateCorrection();
          i++;
        }
      }
      finally {
        Model.popObject();
      }
    }

    public function enableStateCorrection() : void {
      var i:int = 0;
      var m:ITankModel = null;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = ITankModel(this.impl[i]);
          m.enableStateCorrection();
          i++;
        }
      }
      finally {
        Model.popObject();
      }
    }

    public function die(param1:int) : void {
      var i:int = 0;
      var m:ITankModel = null;
      var respawnDelay:int = param1;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = ITankModel(this.impl[i]);
          m.die(respawnDelay);
          i++;
        }
      }
      finally {
        Model.popObject();
      }
    }

    public function isLocal() : Boolean {
      var result:Boolean = false;
      var i:int = 0;
      var m:ITankModel = null;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = ITankModel(this.impl[i]);
          result = Boolean(m.isLocal());
          i++;
        }
      }
      finally {
        Model.popObject();
      }
      return result;
    }

    public function configureTankTitleAsRemote(param1:IGameObject) : void {
      var i:int = 0;
      var m:ITankModel = null;
      var user:IGameObject = param1;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = ITankModel(this.impl[i]);
          m.configureTankTitleAsRemote(user);
          i++;
        }
      }
      finally {
        Model.popObject();
      }
    }

    public function configureRemoteTankTitles() : void {
      var i:int = 0;
      var m:ITankModel = null;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = ITankModel(this.impl[i]);
          m.configureRemoteTankTitles();
          i++;
        }
      }
      finally {
        Model.popObject();
      }
    }

    public function addTankToBattle() : void {
      var i:int = 0;
      var m:ITankModel = null;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = ITankModel(this.impl[i]);
          m.addTankToBattle();
          i++;
        }
      }
      finally {
        Model.popObject();
      }
    }

    public function removeTankFromBattle() : void {
      var i:int = 0;
      var m:ITankModel = null;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = ITankModel(this.impl[i]);
          m.removeTankFromBattle();
          i++;
        }
      }
      finally {
        Model.popObject();
      }
    }

    public function doSetHealth(param1:Number) : void {
      var i:int = 0;
      var m:ITankModel = null;
      var health:Number = param1;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = ITankModel(this.impl[i]);
          m.doSetHealth(health);
          i++;
        }
      }
      finally {
        Model.popObject();
      }
    }

    public function setChassisState(param1:Vector3d, param2:Vector3d, param3:Vector3d, param4:Vector3d, param5:int, param6:int) : void {
      var i:int = 0;
      var m:ITankModel = null;
      var position:Vector3d = param1;
      var orientation:Vector3d = param2;
      var linearVelocity:Vector3d = param3;
      var angularVelocity:Vector3d = param4;
      var controlState:int = param5;
      var turnSpeedNumber:int = param6;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = ITankModel(this.impl[i]);
          m.setChassisState(position,orientation,linearVelocity,angularVelocity,controlState,turnSpeedNumber);
          i++;
        }
      }
      finally {
        Model.popObject();
      }
    }

    public function getMovementAnticheatTask() : MovementTimeoutAndDistanceAnticheatTask {
      var result:MovementTimeoutAndDistanceAnticheatTask = null;
      var i:int = 0;
      var m:ITankModel = null;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = ITankModel(this.impl[i]);
          result = m.getMovementAnticheatTask();
          i++;
        }
      }
      finally {
        Model.popObject();
      }
      return result;
    }

    public function addTankToExclusionSet(param1:Tank) : void {
      var i:int = 0;
      var m:ITankModel = null;
      var tank:Tank = param1;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = ITankModel(this.impl[i]);
          m.addTankToExclusionSet(tank);
          i++;
        }
      }
      finally {
        Model.popObject();
      }
    }

    public function getTankSet() : TankSet {
      var result:TankSet = null;
      var i:int = 0;
      var m:ITankModel = null;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = ITankModel(this.impl[i]);
          result = m.getTankSet();
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
