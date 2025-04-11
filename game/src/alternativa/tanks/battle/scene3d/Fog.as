package alternativa.tanks.battle.scene3d {
  import alternativa.engine3d.core.Camera3D;

  public class Fog {
    public var color:int;
    public var alpha:Number;
    public var near:Number;
    public var far:Number;

    private var camera:Camera3D;

    public function Fog(param1:Camera3D) {
      super();
      this.camera = param1;
    }

    public function enable() : void {
      if(this.color != 0) {
        this.camera.fogNear = this.near;
        this.camera.fogFar = this.far;
        this.camera.fogAlpha = this.alpha;
        this.camera.fogColor = this.color;
      }
    }

    public function disable() : void {
      this.camera.fogNear = 0;
      this.camera.fogFar = 1000000;
      this.camera.fogAlpha = 0;
    }

    public function setup(param1:int, param2:Number, param3:Number, param4:Number) : void {
      this.color = param1;
      this.alpha = param2;
      this.near = param3;
      this.far = param4;
    }
  }
}
