package alternativa.tanks.services.lightingeffects {
  import alternativa.tanks.models.teamlight.ModeLight;
  import alternativa.tanks.models.teamlight.TeamLightColor;
  import flash.geom.ColorTransform;
  import projects.tanks.client.battleservice.BattleMode;
  import projects.tanks.clients.flash.commons.models.gpu.GPUCapabilities;

  public class LightingEffectsService implements ILightingEffectsService {
    private var modes:Vector.<ModeLight> = new Vector.<ModeLight>(BattleMode.values.length,true);
    private var bonusLightIntensity:Number;
    private var bonusColorAdjust:ColorTransform;

    public function LightingEffectsService() {
      super();
      var local1:int = 0;
      while(local1 < this.modes.length) {
        this.modes[local1] = new ModeLight(new TeamLightColor(0,0),new TeamLightColor(0,0),new TeamLightColor(0,0),0,0);
        local1++;
      }
    }

    public function setLightForMode(param1:BattleMode, param2:ModeLight) : void {
      this.modes[param1.value] = param2;
    }

    public function getLightForMode(param1:BattleMode) : ModeLight {
      return this.modes[param1.value];
    }

    public function setBonusLighting(param1:Number, param2:ColorTransform, param3:ColorTransform) : void {
      this.bonusLightIntensity = param1;
      if(GPUCapabilities.gpuEnabled) {
        this.bonusColorAdjust = param2;
      } else {
        this.bonusColorAdjust = param3;
      }
    }

    public function getBonusLightIntensity() : Number {
      return this.bonusLightIntensity;
    }

    public function getBonusColorAdjust() : ColorTransform {
      return this.bonusColorAdjust;
    }
  }
}
