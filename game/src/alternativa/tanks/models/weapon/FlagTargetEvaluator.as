package alternativa.tanks.models.weapon {
  import alternativa.physics.Body;
  import alternativa.tanks.models.battle.commonflag.CommonFlag;
  import flash.utils.Dictionary;

  public class FlagTargetEvaluator {
    private var carriers:Dictionary = new Dictionary();

    public function FlagTargetEvaluator() {
      super();
    }

    public function setFlagCarrier(param1:CommonFlag, param2:Body) : void {
      if(param2 != null) {
        this.carriers[param1] = param2;
      } else {
        delete this.carriers[param1];
      }
    }

    public function isCarrier(param1:Body) : Boolean {
      var local2:Body = null;
      for each(local2 in this.carriers) {
        if(local2 == param1) {
          return true;
        }
      }
      return false;
    }
  }
}
