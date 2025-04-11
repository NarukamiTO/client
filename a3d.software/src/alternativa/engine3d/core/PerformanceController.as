package alternativa.engine3d.core {
  import flash.display.Stage;

  public class PerformanceController {
    public static const FOG:String = "fog";
    public static const DIRECTIONAL_LIGHT:String = "directionalLight";
    public static const SHADOW_MAP:String = "shadowMap";
    public static const SOFT_TRANSPARENCY:String = "softTransparency";
    public static const SHADOWS:String = "shadows";
    public static const ANTI_ALIAS:String = "antiAlias";
    public static const SSAO:String = "ssao";
    public static const DEFERRED_LIGHTING:String = "deferredLighting";

    private var camera:Camera3D;
    private var types:Vector.<String> = new Vector.<String>();
    private var _block:Boolean = false;

    public function PerformanceController() {
      super();
    }

    public function addFeature(param1:String, param2:Number, param3:Boolean) : void {
      var local4:String = null;
      if(this.camera != null) {
        throw new Error("Cannot add feature during analysis.");
      }
      if(param1 != FOG && param1 != SHADOWS && param1 != DIRECTIONAL_LIGHT && param1 != SHADOW_MAP && param1 != SOFT_TRANSPARENCY && param1 != ANTI_ALIAS && param1 != SSAO && param1 != DEFERRED_LIGHTING) {
        throw new Error("Nonexistent feature.");
      }
      for each(local4 in this.types) {
        if(local4 == param1) {
          throw new Error("Feature already exists.");
        }
      }
      this.types.push(param1);
    }

    public function get activated() : Boolean {
      return this.camera != null;
    }

    public function clearSharedObject() : void {
    }

    public function start(param1:Stage, param2:Camera3D, param3:Number, param4:Number, param5:Number, param6:Number, param7:uint, param8:String, param9:Boolean = false) : void {
      if(this.camera != null) {
        throw new Error("Analysis already started.");
      }
      this.camera = param2;
    }

    public function stop() : void {
      this.camera = null;
    }

    public function get block() : Boolean {
      return this._block;
    }

    public function set block(param1:Boolean) : void {
      this._block = param1;
    }
  }
}
