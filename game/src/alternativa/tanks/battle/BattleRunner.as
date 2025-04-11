package alternativa.tanks.battle {
  import alternativa.physics.Body;
  import alternativa.physics.collision.CollisionShape;
  import alternativa.tanks.battle.events.BattleEventDispatcher;
  import alternativa.tanks.battle.triggers.Triggers;
  import alternativa.tanks.battle.utils.AddPostPhysicsControllerAction;
  import alternativa.tanks.battle.utils.LogicUnitDeferredAction;
  import alternativa.tanks.battle.utils.PhysicsControllerDeferredAction;
  import alternativa.tanks.battle.utils.RemovePostPhysicsController;
  import alternativa.tanks.models.tank.LocalTankInfoService;
  import alternativa.tanks.physics.TankBody;
  import alternativa.tanks.physics.TankBodyIdProvider;
  import alternativa.tanks.physics.TankPhysicsScene;
  import alternativa.tanks.physics.TanksCollisionDetector;
  import alternativa.tanks.sound.ISoundManager;
  import alternativa.tanks.sound.SoundManager;
  import alternativa.tanks.utils.EncryptedInt;
  import alternativa.tanks.utils.EncryptedIntImpl;
  import flash.media.Sound;
  import flash.utils.getTimer;

  public class BattleRunner {
    [Inject]
    public static var battleService:BattleService;

    [Inject]
    public static var localTankInfoService:LocalTankInfoService;

    public static const PHYSICS_STEP_IN_MS:int = 33;
    public static const PHYSICS_STEP_IN_S:Number = 0.033;

    private static const thousand:EncryptedInt = new EncryptedIntImpl(1000);

    public var physicsPerformanceMonitor:PerformanceMonitor = new PerformanceMonitor(30);

    private var time:int;
    private var lastRunLogicTime:int;
    private var inputProcessors:Vector.<LogicUnit> = new Vector.<LogicUnit>();
    private var logicUnits:Vector.<LogicUnit> = new Vector.<LogicUnit>();
    private var logicInProgress:Boolean;
    private var physicsControllers:Vector.<PhysicsController> = new Vector.<PhysicsController>();
    private var postPhysicsControllers:Vector.<PostPhysicsController> = new Vector.<PostPhysicsController>();
    private var physicsInterpolators:Vector.<PhysicsInterpolator> = new Vector.<PhysicsInterpolator>();
    private var deferredActions:Vector.<DeferredAction> = new Vector.<DeferredAction>();
    private var localBody:Body;
    private var physicsInProgress:Boolean;
    private var soundManager:ISoundManager;
    private var battleEventDispatcher:BattleEventDispatcher;

    private const _triggers:Triggers = new Triggers();

    private var physicsScene:TankPhysicsScene;

    public function BattleRunner(param1:Number, param2:Sound, param3:BattleEventDispatcher) {
      super();
      this.battleEventDispatcher = param3;
      this.time = getTimer();
      this.physicsScene = new TankPhysicsScene(this.time,param1,param3);
      this.soundManager = SoundManager.createSoundManager(param2);
      this.lastRunLogicTime = this.time;
      TankBodyIdProvider.resetIds();
    }

    public function getSoundManager() : ISoundManager {
      return this.soundManager;
    }

    public function initStaticGeometry(param1:Vector.<CollisionShape>) : void {
      this.physicsScene.initStaticGeometry(param1);
    }

    public function getCollisionDetector() : TanksCollisionDetector {
      return this.physicsScene.getCollisionDetector();
    }

    public function addInputProcessor(param1:LogicUnit) : void {
      if(this.inputProcessors.indexOf(param1) < 0) {
        this.inputProcessors.push(param1);
      }
    }

    public function removeInputProcessor(param1:LogicUnit) : void {
      this.removeLogicUnitFromArray(param1,this.inputProcessors);
    }

    public function addLogicUnit(param1:LogicUnit) : void {
      if(this.logicInProgress) {
        this.addDeferredAction(new LogicUnitDeferredAction(param1,true));
      } else if(this.logicUnits.indexOf(param1) < 0) {
        this.logicUnits.push(param1);
      }
    }

    public function removeLogicUnit(param1:LogicUnit) : void {
      if(this.logicInProgress) {
        this.addDeferredAction(new LogicUnitDeferredAction(param1,false));
      } else {
        this.removeLogicUnitFromArray(param1,this.logicUnits);
      }
    }

    private function removeLogicUnitFromArray(param1:LogicUnit, param2:Vector.<LogicUnit>) : void {
      var local4:int = 0;
      var local3:int = int(param2.indexOf(param1));
      if(local3 >= 0) {
        local4 = param2.length - 1;
        param2[local3] = param2[local4];
        param2.length = local4;
      }
    }

    public function addTrigger(param1:Trigger) : void {
      this._triggers.add(param1);
    }

    public function removeTrigger(param1:Trigger) : void {
      this._triggers.remove(param1);
    }

    public function setLocalBody(param1:Body) : void {
      this.localBody = param1;
    }

    public function addBodyWrapper(param1:TankBody) : void {
      this.physicsScene.addBody(param1);
    }

    public function removeBodyWrapper(param1:TankBody) : void {
      this.physicsScene.removeBody(param1);
      if(this.localBody == param1.body) {
        this.setLocalBody(null);
      }
    }

    public function addPhysicsController(param1:PhysicsController) : void {
      if(this.physicsInProgress) {
        this.addDeferredAction(new PhysicsControllerDeferredAction(param1,true));
      } else if(this.physicsControllers.indexOf(param1) < 0) {
        this.physicsControllers.push(param1);
      }
    }

    public function removePhysicsController(param1:PhysicsController) : void {
      var local2:int = 0;
      var local3:int = 0;
      if(this.physicsInProgress) {
        this.addDeferredAction(new PhysicsControllerDeferredAction(param1,false));
      } else {
        local2 = int(this.physicsControllers.length);
        if(local2 > 0) {
          local3 = int(this.physicsControllers.indexOf(param1));
          if(local3 >= 0) {
            this.physicsControllers.splice(local3,1);
          }
        }
      }
    }

    public function addPostPhysicsController(param1:PostPhysicsController) : void {
      if(this.physicsInProgress) {
        this.addDeferredAction(new AddPostPhysicsControllerAction(param1));
      } else if(this.postPhysicsControllers.indexOf(param1) < 0) {
        this.postPhysicsControllers.push(param1);
      }
    }

    public function removePostPhysicsController(param1:PostPhysicsController) : void {
      var local2:int = 0;
      var local3:int = 0;
      if(this.physicsInProgress) {
        this.addDeferredAction(new RemovePostPhysicsController(param1));
      } else {
        local2 = int(this.postPhysicsControllers.length);
        if(local2 > 0) {
          local3 = int(this.postPhysicsControllers.indexOf(param1));
          if(local3 >= 0) {
            this.postPhysicsControllers.splice(local3,1);
          }
        }
      }
    }

    public function addPhysicsInterpolator(param1:PhysicsInterpolator) : void {
      if(this.physicsInterpolators.indexOf(param1) < 0) {
        this.physicsInterpolators.push(param1);
      }
    }

    public function removePhysicsInterpolator(param1:PhysicsInterpolator) : void {
      var local3:int = 0;
      var local2:int = int(this.physicsInterpolators.length);
      if(local2 > 0) {
        local3 = int(this.physicsInterpolators.indexOf(param1));
        if(local3 >= 0) {
          this.physicsInterpolators[local3] = this.physicsInterpolators[--local2];
          this.physicsInterpolators.length = local2;
        }
      }
    }

    public function tick() : void {
      var local1:int = getTimer();
      var local2:int = local1 - this.time;
      this.time = local1;
      this.runInputProcessors(this.time,local2);
      this.runPhysics(PHYSICS_STEP_IN_MS);
      battleService.getBattleScene3D().render(this.time,local2);
      battleService.getBattleView().update();
      this.soundManager.updateSoundEffects(local2,battleService.getBattleScene3D().getCamera());
    }

    private function runInputProcessors(param1:int, param2:int) : void {
      var local3:int = int(this.inputProcessors.length);
      var local4:int = 0;
      while(local4 < local3) {
        this.inputProcessors[local4].runLogic(param1,param2);
        local4++;
      }
    }

    public function shutdown() : void {
      this.soundManager.stopAllSounds();
      this.soundManager.removeAllEffects();
      this.physicsScene.destroy();
    }

    private function runLogicUnits(param1:int) : void {
      var local5:LogicUnit = null;
      var local2:int = param1 - this.lastRunLogicTime;
      this.lastRunLogicTime = param1;
      this.logicInProgress = true;
      var local3:int = int(this.logicUnits.length);
      var local4:int = 0;
      while(local4 < local3) {
        local5 = this.logicUnits[local4];
        local5.runLogic(param1,local2);
        local4++;
      }
      this.logicInProgress = false;
      this.executeDeferedActions();
    }

    private function runPhysics(param1:int) : void {
      this.physicsPerformanceMonitor.beginFrame();
      while(this.physicsScene.getPhysicsTime() < this.time) {
        this.updateLocalTankPhysicsState();
        this.runLogicUnits(this.getPhysicsTime());
        this.physicsInProgress = true;
        this.runPhysicsControllers(param1 / thousand.getInt());
        this.physicsScene.update(param1);
        this.runPostPhysicsControllers(param1 / thousand.getInt());
        this._triggers.check(this.localBody);
        this.physicsInProgress = false;
        this.executeDeferedActions();
      }
      this.physicsPerformanceMonitor.endFrame();
      this.runPhysicsInterpolators(param1);
    }

    private function updateLocalTankPhysicsState() : void {
      if(localTankInfoService.isLocalTankLoaded()) {
        localTankInfoService.getLocalTank().updatePhysicsState();
      }
    }

    private function runPhysicsControllers(param1:Number) : void {
      var local4:PhysicsController = null;
      var local2:int = int(this.physicsControllers.length);
      var local3:int = 0;
      while(local3 < local2) {
        local4 = this.physicsControllers[local3];
        local4.runBeforePhysicsUpdate(param1);
        local3++;
      }
    }

    private function runPostPhysicsControllers(param1:Number) : void {
      var local4:PostPhysicsController = null;
      var local2:int = int(this.postPhysicsControllers.length);
      var local3:int = 0;
      while(local3 < local2) {
        local4 = this.postPhysicsControllers[local3];
        local4.runAfterPhysicsUpdate(param1);
        local3++;
      }
    }

    private function runPhysicsInterpolators(param1:int) : void {
      var local5:PhysicsInterpolator = null;
      var local2:Number = 1 + (this.time - this.physicsScene.getPhysicsTime()) / PHYSICS_STEP_IN_MS;
      var local3:int = int(this.physicsInterpolators.length);
      var local4:int = 0;
      while(local4 < local3) {
        local5 = this.physicsInterpolators[local4];
        local5.interpolatePhysicsState(local2,param1);
        local4++;
      }
    }

    private function addDeferredAction(param1:DeferredAction) : void {
      this.deferredActions.push(param1);
    }

    private function executeDeferedActions() : void {
      var local1:DeferredAction = null;
      while(true) {
        local1 = this.deferredActions.pop();
        if(local1 == null) {
          break;
        }
        local1.execute();
      }
    }

    public function getPhysicsTime() : int {
      return this.physicsScene.getPhysicsTime();
    }

    public function getGravity() : Number {
      return this.physicsScene.getGravity();
    }
  }
}
