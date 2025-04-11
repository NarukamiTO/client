package alternativa.tanks.battle.scene3d {
  import alternativa.engine3d.core.Camera3D;
  import alternativa.engine3d.core.Shadow;
  import alternativa.osgi.service.console.IConsole;
  import alternativa.tanks.battle.*;
  import alternativa.tanks.utils.MathUtils;
  import flash.utils.Dictionary;

  public class AmbientShadows {
    private static const MAX_FAR_DISTANCE:Number = 7000;
    private static const MAX_NEAR_DISTANCE:Number = 4000;
    private static const MIN_FAR_DISTANCE:Number = 2000;
    private static const MIN_NEAR_DISTANCE:Number = 1000;
    private static const EASING:Number = 0.01;
    private static const MAX_FPS:Number = 60;
    private static const MIN_FPS:Number = 20;

    private var camera:Camera3D;

    private const shadows:Dictionary = new Dictionary();

    private var nearDistance:Number = 4000;
    private var farDistance:Number = 7000;
    private var enabled:Boolean;
    private var color:int;
    private var alpha:Number = 0.85;

    public function AmbientShadows(param1:Camera3D) {
      super();
      this.camera = param1;
      this.registerConsoleCommands();
    }

    public function setup(param1:int) : void {
      this.color = param1;
    }

    public function add(param1:Shadow) : void {
      param1.color = this.color;
      param1.alpha = this.alpha;
      param1.nearDistance = this.nearDistance;
      param1.farDistance = this.farDistance;
      this.shadows[param1] = true;
      if(this.enabled) {
        this.camera.addShadow(param1);
      }
    }

    public function remove(param1:Shadow) : void {
      delete this.shadows[param1];
      if(this.enabled) {
        this.camera.removeShadow(param1);
      }
    }

    public function enable() : void {
      var local1:* = undefined;
      if(!this.enabled) {
        this.enabled = true;
        for(local1 in this.shadows) {
          this.camera.addShadow(local1);
        }
      }
    }

    public function disable() : void {
      var local1:* = undefined;
      if(this.enabled) {
        this.enabled = false;
        for(local1 in this.shadows) {
          this.camera.removeShadow(local1);
        }
      }
    }

    public function adjustDistances(param1:Number) : void {
      this.calculateDistances(param1);
      this.updateShadowsDistances();
    }

    private function calculateDistances(param1:Number) : void {
      var local2:Number = MathUtils.clamp((param1 - MIN_FPS) / (MAX_FPS - MIN_FPS),0,1);
      var local3:Number = MIN_NEAR_DISTANCE + local2 * (MAX_NEAR_DISTANCE - MIN_NEAR_DISTANCE);
      this.nearDistance += (local3 - this.nearDistance) * EASING;
      var local4:Number = MIN_FAR_DISTANCE + local2 * (MAX_FAR_DISTANCE - MIN_FAR_DISTANCE);
      this.farDistance += (local4 - this.farDistance) * EASING;
    }

    private function updateShadowsDistances() : void {
      var local1:* = undefined;
      var local2:Shadow = null;
      for(local1 in this.shadows) {
        local2 = local1;
        local2.nearDistance = this.nearDistance;
        local2.farDistance = this.farDistance;
      }
    }

    private function registerConsoleCommands() : void {
    }

    private function setColor(param1:IConsole, param2:Array) : void {
    }

    private function setAlpha(param1:IConsole, param2:Array) : void {
    }
  }
}
