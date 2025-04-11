package alternativa.tanks.services.lightingeffects {
  import alternativa.tanks.models.teamlight.ModeLight;
  import flash.geom.ColorTransform;
  import projects.tanks.client.battleservice.BattleMode;

  public interface ILightingEffectsService {
    function setLightForMode(param1:BattleMode, param2:ModeLight) : void;
    function getLightForMode(param1:BattleMode) : ModeLight;
    function setBonusLighting(param1:Number, param2:ColorTransform, param3:ColorTransform) : void;
    function getBonusLightIntensity() : Number;
    function getBonusColorAdjust() : ColorTransform;
  }
}
