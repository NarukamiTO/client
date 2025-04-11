package alternativa.tanks.battle.scene3d {
  import alternativa.engine3d.core.Camera3D;
  import alternativa.engine3d.core.ShadowMap;
  import alternativa.engine3d.lights.DirectionalLight;
  import alternativa.math.Matrix3;
  import alternativa.math.Vector3;
  import alternativa.tanks.battle.Color;
  import flash.geom.Vector3D;

  public class Lighting {
    private static const SHADOWMAP_SIZE:int = 2048;
    private static const BIAS:Number = 0.5;
    private static const ADDITIONAL_SPACE:Number = 10000;
    private static const NEAR_DISTANCE:Number = 5000;
    private static const FAR_DISTANCE:Number = 10000;

    private var lightColor:Color;
    private var shadowColor:Color;
    private var angleX:Number = 0;
    private var angleZ:Number = 0;
    private var direction:Vector3D = new Vector3D(1,1,1);
    private var camera:Camera3D;

    public function Lighting(param1:Camera3D) {
      super();
      this.camera = param1;
    }

    public function enableShadows() : void {
      this.camera.shadowMap = new ShadowMap(SHADOWMAP_SIZE,NEAR_DISTANCE,FAR_DISTANCE,BIAS,ADDITIONAL_SPACE);
    }

    public function disableShadows() : void {
      if(this.camera.shadowMap != null) {
        this.camera.shadowMap.dispose();
        this.camera.shadowMap = null;
      }
    }

    public function enableLighting() : void {
      this.camera.directionalLight = new DirectionalLight(this.lightColor.getColor());
      this.camera.directionalLight.lookAt(this.direction.x,this.direction.y,this.direction.z);
      this.camera.ambientColor = this.shadowColor.getColor();
    }

    public function disableLighting() : void {
      this.camera.directionalLight = null;
    }

    public function setup(param1:int, param2:int, param3:Number, param4:Number) : void {
      this.lightColor = new Color(param1);
      this.shadowColor = new Color(param2);
      this.lightColor.subtract(this.shadowColor);
      this.angleX = param3;
      this.angleZ = param4;
      this.setupDirection();
    }

    private function setupDirection() : void {
      var local1:Matrix3 = new Matrix3();
      local1.setRotationMatrix(this.angleX,0,this.angleZ);
      var local2:Vector3 = new Vector3(0,1,0);
      local2.transform3(local1);
      this.direction.x = local2.x;
      this.direction.y = local2.y;
      this.direction.z = local2.z;
    }

    public function toggle() : void {
      if(this.camera.shadowMap == null) {
        this.enableShadows();
      } else {
        this.disableShadows();
      }
    }
  }
}
