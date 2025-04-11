package alternativa.tanks.models.bonus.bonuslight {
  import alternativa.tanks.models.teamlight.TeamLightColor;

  public class BonusLight {
    private var lightColor:TeamLightColor;
    private var attenuationBegin:Number;
    private var attenuationEnd:Number;

    public function BonusLight(param1:TeamLightColor, param2:Number, param3:Number) {
      super();
      this.lightColor = param1;
      this.attenuationBegin = param2;
      this.attenuationEnd = param3;
    }

    public function getLightColor() : TeamLightColor {
      return this.lightColor;
    }

    public function getAttenuationBegin() : Number {
      return this.attenuationBegin;
    }

    public function getAttenuationEnd() : Number {
      return this.attenuationEnd;
    }
  }
}
