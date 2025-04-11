package alternativa.tanks.models.battle.battlefield {
  import alternativa.osgi.OSGi;
  import alternativa.osgi.service.clientlog.IClientLog;
  import projects.tanks.client.battlefield.models.battle.battlefield.types.HitTraceData;

  public class HitTracer {
    public function HitTracer() {
      super();
    }

    public static function trace(param1:HitTraceData) : void {
      var local2:Number = param1.colorResistDamage - param1.origDamage;
      var local3:Number = param1.weaponEffectsDamage - param1.colorResistDamage;
      var local4:Number = param1.armorPreEffectDamage - param1.weaponEffectsDamage;
      var local5:Number = param1.targetHealth - param1.postHealth;
      IClientLog(OSGi.getInstance().getService(IClientLog)).log("damage",makeCell(param1.killerTurretName,12) + makeCell(param1.targetHullName,12) + makeCell(param1.targetHealth.toFixed(2),13) + makeCell(param1.origDamage.toFixed(2),11) + makeCell(local2 != 0 ? local2.toFixed(2) : "",13) + makeCell(local3 != 0 ? local3.toFixed(2) : "",13) + makeCell(local4 != 0 ? local4.toFixed(2) : "",12) + makeCell(local5.toFixed(2),11) + makeCell(param1.postHealth.toFixed(2),12));
    }

    private static function makeCell(param1:String, param2:int) : String {
      var local3:String = param1;
      if(local3.length >= param2) {
        local3 = local3.substr(0,param2 - 2) + "\\";
      }
      var local4:int = param2 - local3.length;
      var local5:int = 0;
      while(local5 < local4) {
        local3 = " " + local3;
        local5++;
      }
      return local3;
    }
  }
}
