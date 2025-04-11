package alternativa.tanks.models.sfx.smoke {
  import alternativa.tanks.battle.BattleService;
  import alternativa.tanks.battle.events.BattleEventDispatcher;
  import alternativa.tanks.battle.events.BattleEventSupport;
  import alternativa.tanks.battle.events.TankAddedToBattleEvent;
  import alternativa.tanks.battle.events.TankRemovedFromBattleEvent;
  import alternativa.tanks.models.tank.ITankModel;
  import flash.utils.Dictionary;
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;
  import projects.tanks.client.battlefield.models.tankparts.sfx.smoke.HullSmokeModelBase;
  import projects.tanks.client.battlefield.models.tankparts.sfx.smoke.IHullSmokeModelBase;

  [ModelInfo]
  public class HullSmokeModel extends HullSmokeModelBase implements HullSmoke, IHullSmokeModelBase {
    [Inject]
    public static var battleEventDispatcher:BattleEventDispatcher;

    [Inject]
    public static var battleService:BattleService;

    private var battleEventSupport:BattleEventSupport;
    private var renders:Dictionary = new Dictionary();
    private var controlStates:Dictionary = new Dictionary();

    public function HullSmokeModel() {
      super();
      this.battleEventSupport = new BattleEventSupport(battleEventDispatcher);
      this.battleEventSupport.addEventHandler(TankAddedToBattleEvent,this.onTankAddedToBattle);
      this.battleEventSupport.addEventHandler(TankRemovedFromBattleEvent,this.onTankRemovedFromBattle);
      this.battleEventSupport.activateHandlers();
    }

    private function onTankAddedToBattle(param1:TankAddedToBattleEvent) : void {
      var renderer:HullSmokeRenderer = null;
      var event:TankAddedToBattleEvent = param1;
      var tankModel:ITankModel = ITankModel(event.tank.getUser().adapt(ITankModel));
      Model.object = tankModel.getTankSet().hull;
      try {
        if(!getInitParam().enabled) {
          return;
        }
        renderer = new HullSmokeRenderer(event.tank,getInitParam());
        battleService.getBattleScene3D().addRenderer(renderer);
        this.renders[event.tank.getUser().id] = renderer;
      }
      finally {
        Model.popObject();
      }
    }

    private function onTankRemovedFromBattle(param1:TankRemovedFromBattleEvent) : void {
      var local2:HullSmokeRenderer = HullSmokeRenderer(this.renders[param1.tank.getUser().id]);
      if(local2 == null) {
        return;
      }
      battleService.getBattleScene3D().removeRenderer(local2);
      delete this.renders[param1.tank.getUser().id];
    }

    public function controlChanged(param1:IGameObject, param2:int) : void {
      var local3:HullSmokeRenderer = HullSmokeRenderer(this.renders[param1.id]);
      if(local3 == null) {
        return;
      }
      var local4:int = int(this.controlStates[param1.id]);
      var local5:Boolean = this.isForward(param2);
      var local6:Boolean = this.isForward(local4);
      if(local5 && !local6) {
        local3.start();
      } else if(!local5 && local6) {
        local3.stop();
      } else if(local4 != param2) {
        local3.changeDirection();
      }
      this.controlStates[param1.id] = param2;
    }

    private function isForward(param1:int) : Boolean {
      return param1 % 2 != 0;
    }
  }
}
