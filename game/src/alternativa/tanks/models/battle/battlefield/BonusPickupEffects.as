package alternativa.tanks.models.battle.battlefield {
  import alternativa.osgi.service.console.variables.ConsoleVarInt;
  import alternativa.tanks.battle.BattleService;
  import alternativa.tanks.battle.objects.tank.Tank;
  import alternativa.types.Long;
  import flash.utils.Dictionary;

  public class BonusPickupEffects {
    private static var conShowEffects:ConsoleVarInt;

    private var battleService:BattleService;
    private var tanks:Dictionary = new Dictionary();
    private var effects:Dictionary = new Dictionary();

    public function BonusPickupEffects(param1:BattleService) {
      super();
      this.battleService = param1;
      if(conShowEffects == null) {
        conShowEffects = new ConsoleVarInt("bonus_flash",0,0,1);
      }
    }

    public function addTank(param1:Tank) : void {
      this.tanks[param1.getUser()] = param1;
    }

    public function removeTank(param1:Tank) : void {
      this.removeEffect(param1);
      delete this.tanks[param1.getUser()];
    }

    public function showBonusPickup(param1:Long) : void {
      var local2:Tank = null;
      var local3:BonusPickupEffect = null;
      if(conShowEffects.value == 1) {
        local2 = this.tanks[param1];
        if(local2 != null) {
          local3 = this.effects[param1];
          if(local3 == null) {
            local3 = new BonusPickupEffect(local2);
            this.effects[param1] = local3;
          }
          if(!local3.onScene) {
            this.battleService.addGraphicEffect(local3);
          }
          local3.init();
        }
      }
    }

    private function removeEffect(param1:Tank) : void {
      var local2:BonusPickupEffect = this.effects[param1.getUser()];
      if(local2 != null) {
        local2.kill();
        delete this.effects[param1.getUser()];
      }
    }
  }
}
