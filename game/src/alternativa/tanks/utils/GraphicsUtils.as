package alternativa.tanks.utils {
  import alternativa.engine3d.core.Object3D;
  import alternativa.engine3d.materials.TextureMaterial;
  import alternativa.math.Vector3;
  import alternativa.tanks.engine3d.TextureAnimation;
  import alternativa.tanks.engine3d.UVFrame;
  import alternativa.utils.TextureMaterialRegistry;
  import flash.display.BitmapData;
  import flash.filters.BitmapFilter;
  import flash.geom.Point;
  import flash.utils.Dictionary;
  import platform.client.fp10.core.resource.types.MultiframeTextureResource;

  public class GraphicsUtils {
    private static var filteredImages:Dictionary = new Dictionary(true);

    public function GraphicsUtils() {
      super();
    }

    public static function setObjectTransform(param1:Object3D, param2:Vector3, param3:Vector3) : void {
      param1.x = param2.x;
      param1.y = param2.y;
      param1.z = param2.z;
      param1.rotationX = param3.x;
      param1.rotationY = param3.y;
      param1.rotationZ = param3.z;
    }

    public static function getTextureAnimationFromResource(param1:TextureMaterialRegistry, param2:MultiframeTextureResource) : TextureAnimation {
      var local3:TextureAnimation = getTextureAnimation(param1,param2.data,param2.frameWidth,param2.frameHeight,param2.numFrames);
      local3.fps = param2.fps;
      return local3;
    }

    public static function createFilteredImage(param1:BitmapData, param2:BitmapFilter) : BitmapData {
      var local3:* = undefined;
      var local4:BitmapData = null;
      var local5:Object = null;
      for(local3 in filteredImages) {
        local5 = filteredImages[local3];
        if(local5.s == param1 && local5.f == param2) {
          return local3;
        }
      }
      local4 = param1.clone();
      local4.applyFilter(param1,param1.rect,new Point(),param2);
      filteredImages[local4] = {
        "s":param1,
        "f":param2
      };
      return local4;
    }

    public static function getTextureAnimation(param1:TextureMaterialRegistry, param2:BitmapData, param3:int, param4:int, param5:int = 0, param6:Boolean = true) : TextureAnimation {
      var local7:TextureMaterial = param1.getMaterial(param2);
      var local8:Vector.<UVFrame> = getUVFramesFromTexture(param2,param3,param4,param5);
      return new TextureAnimation(local7,local8);
    }

    public static function getUVFramesFromTexture(param1:BitmapData, param2:int, param3:int, param4:int = 0) : Vector.<UVFrame> {
      var local15:int = 0;
      var local16:int = 0;
      var local17:int = 0;
      var local18:int = 0;
      var local19:int = 0;
      var local5:int = param1.width;
      var local6:int = Math.min(param2,local5);
      var local7:int = local5 / local6;
      var local8:int = param1.height;
      var local9:int = Math.min(param3,local8);
      var local10:int = local8 / local9;
      var local11:int = local7 * local10;
      if(param4 > 0 && local11 > param4) {
        local11 = param4;
      }
      var local12:Vector.<UVFrame> = new Vector.<UVFrame>(local11);
      var local13:int = 0;
      var local14:int = 0;
      while(local14 < local10) {
        local15 = local14 * local9;
        local16 = local15 + local9;
        local17 = 0;
        while(local17 < local7) {
          local18 = local17 * local6;
          local19 = local18 + local6;
          var local20:* = local13++;
          local12[local20] = new UVFrame(local18 / local5,local15 / local8,local19 / local5,local16 / local8);
          if(local13 == local11) {
            return local12;
          }
          local17++;
        }
        local14++;
      }
      return local12;
    }

    public static function getUVFramesFromTextureWithMirror(param1:BitmapData, param2:int, param3:int, param4:int = 0) : Vector.<UVFrame> {
      var local15:int = 0;
      var local16:int = 0;
      var local17:int = 0;
      var local18:int = 0;
      var local19:int = 0;
      var local20:Number = NaN;
      var local21:Number = NaN;
      var local5:int = param1.width;
      var local6:int = Math.min(param2,local5);
      var local7:int = local5 / local6;
      var local8:int = param1.height;
      var local9:int = Math.min(param3,local8);
      var local10:int = local8 / local9;
      var local11:int = local7 * local10;
      if(param4 > 0 && local11 > param4) {
        local11 = param4;
      }
      var local12:Vector.<UVFrame> = new Vector.<UVFrame>(local11);
      var local13:int = 0;
      var local14:int = 0;
      while(local14 < local10) {
        local15 = local14 * local9;
        local16 = local15 + local9;
        local17 = 0;
        while(local17 < local7) {
          local18 = local17 * local6;
          local19 = local18 + local6;
          local20 = local18 / local5;
          local21 = local19 / local5;
          var local22:* = local13++;
          local12[local22] = new UVFrame(local20,local15 / local8,local21,local16 / local8);
          if(local13 == local11) {
            return local12;
          }
          var local23:* = local13++;
          local12[local23] = new UVFrame(local21,local15 / local8,local20,local16 / local8);
          if(local13 == local11) {
            return local12;
          }
          local17++;
        }
        local14++;
      }
      return local12;
    }
  }
}
