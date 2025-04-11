package alternativa.tanks.models.weapon.railgun {
  import flash.display.BitmapData;
  import flash.display.BlendMode;
  import flash.geom.ColorTransform;
  import flash.geom.Matrix;
  import platform.client.fp10.core.resource.types.TextureResource;

  public class ChargingTextureRegistry {
    private static const CHARGE_FRAME_SIZE:int = 210;
    private static const NUM_FRAMES:int = 30;

    private const cache:Object = {};

    public function ChargingTextureRegistry() {
      super();
    }

    private static function getKey(param1:TextureResource, param2:TextureResource, param3:TextureResource) : String {
      return param1.id.toString() + "_" + param2.id.toString() + "_" + param3.id.toString();
    }

    private static function createTexture(param1:TextureResource, param2:TextureResource, param3:TextureResource) : BitmapData {
      var local4:BitmapData = param1.data;
      var local5:BitmapData = param2.data;
      var local6:BitmapData = param3.data;
      var local7:BitmapData = new BitmapData(CHARGE_FRAME_SIZE * NUM_FRAMES,CHARGE_FRAME_SIZE,true,0);
      var local8:String = BlendMode.NORMAL;
      var local9:int = 0;
      while(local9 < NUM_FRAMES) {
        drawPart1(local4,local7,local9,CHARGE_FRAME_SIZE,local8);
        drawPart2(local5,local7,local9,CHARGE_FRAME_SIZE,local8);
        drawPart3(local6,local7,local9,CHARGE_FRAME_SIZE,local8);
        local9++;
      }
      return local7;
    }

    private static function drawPart1(param1:BitmapData, param2:BitmapData, param3:int, param4:int, param5:String) : void {
      var local6:ColorTransform = new ColorTransform();
      if(param3 < 14) {
        local6.alphaMultiplier = param3 / 14;
      } else if(param3 < 25) {
        local6.alphaMultiplier = 1;
      } else {
        local6.alphaMultiplier = 1 - (param3 - 24) / 5;
      }
      var local7:Matrix = new Matrix();
      local7.tx = param3 * param4 + 0.5 * (param4 - param1.width);
      local7.ty = 0.5 * (param4 - param1.height);
      param2.draw(param1,local7,local6,param5,null,true);
    }

    private static function drawPart2(param1:BitmapData, param2:BitmapData, param3:int, param4:int, param5:String) : void {
      var local6:ColorTransform = new ColorTransform();
      if(param3 < 5) {
        local6.alphaMultiplier = param3 / 5;
      } else if(param3 < 25) {
        local6.alphaMultiplier = 1;
      } else {
        local6.alphaMultiplier = 1 - (param3 - 24) / 5;
      }
      var local7:Matrix = new Matrix();
      local7.translate(-0.5 * param1.width,-0.5 * param1.height);
      local7.rotate(2 * param3 * Math.PI / 180);
      local7.translate(param3 * param4 + 0.5 * param4,0.5 * param4);
      param2.draw(param1,local7,local6,param5,null,true);
    }

    private static function drawPart3(param1:BitmapData, param2:BitmapData, param3:int, param4:int, param5:String) : void {
      var local7:Number = NaN;
      var local8:Number = NaN;
      var local6:ColorTransform = new ColorTransform();
      if(param3 < 24) {
        local7 = param3 / 24;
        local6.alphaMultiplier = local7;
        local8 = 0.4 + 0.6 * local7;
      } else if(param3 < 25) {
        local6.alphaMultiplier = 1;
        local8 = 1;
      } else {
        local7 = 1 - (param3 - 24) / 5;
        local6.alphaMultiplier = local7;
        local8 = 0.2 + 0.8 * local7;
      }
      var local9:Matrix = new Matrix();
      local9.translate(-0.5 * param1.width,-0.5 * param1.height);
      local9.scale(local8,local8);
      local9.rotate(2 * -param3 * Math.PI / 180);
      local9.translate(param3 * param4 + 0.5 * param4,0.5 * param4);
      param2.draw(param1,local9,local6,param5,null,true);
    }

    public function getTexture(param1:TextureResource, param2:TextureResource, param3:TextureResource) : BitmapData {
      var local4:ChargingTextureEntry = this.getEntry(param1,param2,param3);
      ++local4.referenceCount;
      return local4.texture;
    }

    public function releaseTexture(param1:TextureResource, param2:TextureResource, param3:TextureResource) : void {
      var local4:String = getKey(param1,param2,param3);
      var local5:ChargingTextureEntry = this.cache[local4];
      if(local5 != null) {
        --local5.referenceCount;
        if(local5.referenceCount == 0) {
          local5.texture.dispose();
          delete this.cache[local4];
        }
      }
    }

    private function getEntry(param1:TextureResource, param2:TextureResource, param3:TextureResource) : ChargingTextureEntry {
      var local4:String = getKey(param1,param2,param3);
      var local5:ChargingTextureEntry = this.cache[local4];
      if(local5 == null) {
        local5 = new ChargingTextureEntry();
        local5.texture = createTexture(param1,param2,param3);
        this.cache[local4] = local5;
      }
      return local5;
    }
  }
}
