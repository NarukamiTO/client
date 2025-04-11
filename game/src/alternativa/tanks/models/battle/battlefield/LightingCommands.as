package alternativa.tanks.models.battle.battlefield {
  import alternativa.osgi.service.console.variables.ConsoleVarFloat;
  import alternativa.osgi.service.console.variables.ConsoleVarString;

  public class LightingCommands {
    private var shadowLightColorVar:ConsoleVarString;
    private var shadowShadowColorVar:ConsoleVarString;
    private var shadowAngleXVar:ConsoleVarFloat;
    private var shadowAngleZVar:ConsoleVarFloat;
    private var fogColorVar:ConsoleVarString;
    private var notify:Function;

    public function LightingCommands(param1:uint, param2:uint, param3:Number, param4:Number, param5:uint, param6:Function) {
      super();
      this.shadowLightColorVar = new ConsoleVarString("DynamicShadowLightColor",String(param1),this.updateLightColor);
      this.shadowShadowColorVar = new ConsoleVarString("DynamicShadowShadowColor",String(param2),this.updateShadowColor);
      this.shadowAngleXVar = new ConsoleVarFloat("DynamicShadowAngleX",param3,-180,180,this.updateAngleX);
      this.shadowAngleZVar = new ConsoleVarFloat("DynamicShadowAngleZ",param4,-180,180,this.updateAngleZ);
      this.fogColorVar = new ConsoleVarString("FogColor",String(param5),this.updateFog);
      this.notify = param6;
    }

    public function destroy() : void {
      this.shadowLightColorVar.destroy();
      this.shadowShadowColorVar.destroy();
      this.shadowAngleXVar.destroy();
      this.shadowAngleZVar.destroy();
      this.fogColorVar.destroy();
    }

    private function doNotify() : void {
      this.notify(uint(this.shadowLightColorVar.value),uint(this.shadowShadowColorVar.value),this.shadowAngleXVar.value,this.shadowAngleZVar.value,uint(this.fogColorVar.value));
    }

    private function updateShadowColor(param1:String) : void {
      this.doNotify();
    }

    private function updateLightColor(param1:String) : void {
      this.doNotify();
    }

    private function updateAngleX(param1:Number) : void {
      this.doNotify();
    }

    private function updateAngleZ(param1:Number) : void {
      this.doNotify();
    }

    private function updateFog(param1:String) : void {
      this.doNotify();
    }
  }
}
