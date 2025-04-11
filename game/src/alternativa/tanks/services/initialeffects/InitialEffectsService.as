package alternativa.tanks.services.initialeffects {
  import alternativa.types.Long;
  import flash.utils.getTimer;

  public class InitialEffectsService implements IInitialEffectsService {
    private var initialEffects:Vector.<ClientBattleEffect>;

    public function InitialEffectsService() {
      super();
    }

    public function takeInitialEffects(param1:Long) : Vector.<ClientBattleEffect> {
      var local2:Vector.<ClientBattleEffect> = null;
      var local3:int = 0;
      var local4:int = 0;
      var local5:ClientBattleEffect = null;
      if(this.initialEffects != null) {
        local3 = int(this.initialEffects.length);
        local4 = 0;
        while(local4 < local3) {
          local5 = this.initialEffects[local4];
          if(local5.userId == param1) {
            if(local2 == null) {
              local2 = new Vector.<ClientBattleEffect>();
            }
            local2.push(local5);
            var local6:* = local4--;
            this.initialEffects[local6] = this.initialEffects[--local3];
            this.initialEffects.length = local3;
          }
          local4++;
        }
        if(local3 == 0) {
          this.initialEffects = null;
        }
      }
      return local2;
    }

    public function addInitialEffect(param1:Long, param2:int, param3:int, param4:int) : void {
      if(this.initialEffects == null) {
        this.initialEffects = new Vector.<ClientBattleEffect>();
      }
      this.initialEffects.push(new ClientBattleEffect(getTimer(),param1,param2,param3,param4));
    }

    public function removeInitialEffect(param1:Long, param2:int) : void {
      var local4:int = 0;
      var local3:int = this.indexOfInitialEffect(param1,param2);
      if(local3 >= 0) {
        local4 = int(this.initialEffects.length);
        this.initialEffects[local3] = this.initialEffects[--local4];
        this.initialEffects.length = local4;
      }
    }

    private function indexOfInitialEffect(param1:Long, param2:int) : int {
      var local3:int = 0;
      var local4:int = 0;
      var local5:ClientBattleEffect = null;
      if(this.initialEffects != null) {
        local3 = int(this.initialEffects.length);
        local4 = 0;
        while(local4 < local3) {
          local5 = this.initialEffects[local4];
          if(local5.userId == param1 && local5.effectId == param2) {
            return local4;
          }
          local4++;
        }
      }
      return -1;
    }
  }
}
