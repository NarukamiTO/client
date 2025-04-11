package alternativa.tanks.materials {
  import alternativa.engine3d.alternativa3d;
  import alternativa.engine3d.core.Camera3D;
  import alternativa.engine3d.core.MipMapping;
  import alternativa.engine3d.core.Object3D;
  import alternativa.engine3d.materials.*;
  import alternativa.gfx.core.BitmapTextureResource;
  import alternativa.gfx.core.Device;
  import alternativa.gfx.core.IndexBufferResource;
  import alternativa.gfx.core.ProgramResource;
  import alternativa.gfx.core.VertexBufferResource;
  import flash.display.BitmapData;
  import flash.display3D.Context3DProgramType;
  import flash.display3D.Context3DVertexBufferFormat;
  import flash.utils.ByteArray;
  import flash.utils.Dictionary;

  use namespace alternativa3d;

  public class PaintMaterial extends TextureMaterial {
    protected var fragConst:Vector.<Number>;

    private var programs:Dictionary = new Dictionary();

    protected var spriteSheetBitmap:BitmapData;
    protected var lightMapBitmap:BitmapData;
    protected var spriteSheetResource:BitmapTextureResource;
    protected var lightMapResource:BitmapTextureResource;

    public function PaintMaterial(param1:BitmapData, param2:BitmapData, param3:BitmapData, param4:int = 0) {
      super(param3,true,true,param4);
      this.spriteSheetBitmap = param1;
      this.lightMapBitmap = param2;
      this.spriteSheetResource = TextureResourcesRegistry.getTextureResource(param1,alternativa3d::_mipMapping > 0,true,false);
      this.lightMapResource = TextureResourcesRegistry.getTextureResource(param2,alternativa3d::_mipMapping > 0,true,false);
      this.fragConst = Vector.<Number>([0,0.5,1,2,0.999,0.999,0,0]);
      uvTransformConst[0] = param3.width / param1.width;
      uvTransformConst[5] = param3.height / param1.height;
      alternativa3d::_mipMapping = this.spriteSheetResource.mipMapping ? MipMapping.PER_PIXEL : 0;
    }

    override alternativa3d function get transparent() : Boolean {
      return false;
    }

    override public function set mipMapping(param1:int) : void {
      alternativa3d::_mipMapping = param1;
      alternativa3d::textureResource = TextureResourcesRegistry.getTextureResource(bitmap,alternativa3d::_mipMapping > 0,repeat,alternativa3d::_hardwareMipMaps);
      this.spriteSheetResource = TextureResourcesRegistry.getTextureResource(this.spriteSheetBitmap,alternativa3d::_mipMapping > 0,true,false);
      this.lightMapResource = TextureResourcesRegistry.getTextureResource(this.lightMapBitmap,alternativa3d::_mipMapping > 0,true,false);
    }

    override alternativa3d function drawOpaque(param1:Camera3D, param2:VertexBufferResource, param3:IndexBufferResource, param4:int, param5:int, param6:Object3D) : void {
      var local7:BitmapData = texture;
      if(local7 == null && alternativa3d::_textureATF == null) {
        return;
      }
      var local8:Device = param1.alternativa3d::device;
      var local9:Boolean = param1.fogAlpha > 0 && param1.fogStrength > 0;
      var local10:Boolean = !param1.view.alternativa3d::constrained && param1.ssao && param1.ssaoStrength > 0 && Boolean(param6.alternativa3d::useDepth);
      var local11:Boolean = !param1.view.alternativa3d::constrained && param1.directionalLight != null && param1.directionalLightStrength > 0 && param6.useLight;
      var local12:Boolean = !param1.view.alternativa3d::constrained && param1.shadowMap != null && param1.shadowMapStrength > 0 && param6.useLight && param6.useShadowMap;
      var local13:Boolean = !param1.view.alternativa3d::constrained && param1.deferredLighting && param1.deferredLightingStrength > 0 && Boolean(param6.alternativa3d::useDepth) && param6.useLight;
      var local14:Boolean = alphaTestThreshold > 0 && this.alternativa3d::transparent;
      local8.setProgram(this.getProgram(!local14,false,false,false,param1.view.alternativa3d::quality,repeat,alternativa3d::_mipMapping > 0,param6.alternativa3d::concatenatedColorTransform != null,false,local9,false,local10,local11,local12,local7 == null,false,local13,false,param1.view.alternativa3d::correction,param6.alternativa3d::concatenatedBlendMode != "normal",local14,false));
      local8.setTextureAt(0,alternativa3d::textureResource);
      uvCorrection[0] = alternativa3d::textureResource.correctionU;
      uvCorrection[1] = alternativa3d::textureResource.correctionV;
      if(local10) {
        local8.setTextureAt(1,param1.alternativa3d::depthMap);
      } else {
        local8.setTextureAt(1,null);
      }
      if(local12) {
        local8.setTextureAt(2,param1.shadowMap.alternativa3d::map);
        local8.setTextureAt(3,param1.shadowMap.alternativa3d::noise);
      } else {
        local8.setTextureAt(2,null);
        local8.setTextureAt(3,null);
      }
      local8.setTextureAt(4,this.spriteSheetResource);
      local8.setTextureAt(6,this.lightMapResource);
      if(local13) {
        local8.setTextureAt(5,param1.alternativa3d::lightMap);
      } else {
        local8.setTextureAt(5,null);
      }
      local8.setVertexBufferAt(0,param2,0,Context3DVertexBufferFormat.FLOAT_3);
      local8.setVertexBufferAt(1,param2,3,Context3DVertexBufferFormat.FLOAT_2);
      if(local11) {
        local8.setVertexBufferAt(2,param2,5,Context3DVertexBufferFormat.FLOAT_3);
      } else {
        local8.setVertexBufferAt(2,null);
      }
      local8.setProgramConstantsFromVector(Context3DProgramType.VERTEX,0,param6.alternativa3d::transformConst,3,false);
      local8.setProgramConstantsFromVector(Context3DProgramType.VERTEX,4,uvCorrection,1);
      local8.setProgramConstantsFromVector(Context3DProgramType.VERTEX,14,uvTransformConst,2);
      local8.setProgramConstantsFromVector(Context3DProgramType.FRAGMENT,23,this.fragConst,2,false);
      if(param6.alternativa3d::concatenatedColorTransform != null) {
        local8.setProgramConstantsFromVector(Context3DProgramType.FRAGMENT,0,param6.alternativa3d::colorConst,2,false);
      }
      if(local14) {
        fragmentConst[3] = alphaTestThreshold;
        local8.setProgramConstantsFromVector(Context3DProgramType.FRAGMENT,14,fragmentConst,1,false);
      }
      try {
        local8.drawTriangles(param3,param4,param5);
      }
      catch(e:Error) {
      }
      ++param1.alternativa3d::numDraws;
      param1.alternativa3d::numTriangles += param5;
    }

    override alternativa3d function drawTransparent(param1:Camera3D, param2:VertexBufferResource, param3:IndexBufferResource, param4:int, param5:int, param6:Object3D, param7:Boolean = false) : void {
      var local8:BitmapData = texture;
      if(local8 == null && alternativa3d::_textureATF == null) {
        return;
      }
      var local9:Device = param1.alternativa3d::device;
      var local10:Boolean = param1.fogAlpha > 0 && param1.fogStrength > 0;
      var local11:Boolean = !param1.view.alternativa3d::constrained && param1.softTransparency && param1.softTransparencyStrength > 0 && param6.softAttenuation > 0;
      var local12:Boolean = !param1.view.alternativa3d::constrained && param1.ssao && param1.ssaoStrength > 0 && Boolean(param6.alternativa3d::useDepth);
      var local13:Boolean = !param1.view.alternativa3d::constrained && param1.directionalLight != null && param1.directionalLightStrength > 0 && param6.useLight;
      var local14:Boolean = !param1.view.alternativa3d::constrained && param1.shadowMap != null && param1.shadowMapStrength > 0 && param6.useLight && param6.useShadowMap;
      var local15:Boolean = !param1.view.alternativa3d::constrained && param1.deferredLighting && param1.deferredLightingStrength > 0;
      var local16:Boolean = local15 && Boolean(param6.alternativa3d::useDepth) && param6.useLight;
      local9.setProgram(this.getProgram(false,false,false,false,param1.view.alternativa3d::quality,repeat,alternativa3d::_mipMapping > 0,param6.alternativa3d::concatenatedColorTransform != null,param6.alternativa3d::concatenatedAlpha < 1,local10,local11,local12,local13,local14,local8 == null,local8 == null && alternativa3d::_textureATFAlpha != null,local16,false,param1.view.alternativa3d::correction,param6.alternativa3d::concatenatedBlendMode != "normal",false,param7));
      local9.setTextureAt(0,alternativa3d::textureResource);
      uvCorrection[0] = alternativa3d::textureResource.correctionU;
      uvCorrection[1] = alternativa3d::textureResource.correctionV;
      if(local12 || local11) {
        local9.setTextureAt(1,param1.alternativa3d::depthMap);
      } else {
        local9.setTextureAt(1,null);
      }
      if(local14) {
        local9.setTextureAt(2,param1.shadowMap.alternativa3d::map);
        local9.setTextureAt(3,param1.shadowMap.alternativa3d::noise);
      } else {
        local9.setTextureAt(2,null);
        local9.setTextureAt(3,null);
      }
      local9.setTextureAt(4,this.spriteSheetResource);
      local9.setTextureAt(6,this.lightMapResource);
      if(local16) {
        local9.setTextureAt(5,param1.alternativa3d::lightMap);
      } else {
        local9.setTextureAt(5,null);
      }
      local9.setVertexBufferAt(0,param2,0,Context3DVertexBufferFormat.FLOAT_1);
      local9.setVertexBufferAt(1,null);
      local9.setVertexBufferAt(2,null);
      local9.setProgramConstantsFromVector(Context3DProgramType.VERTEX,0,param6.alternativa3d::transformConst,3,false);
      local9.setProgramConstantsFromVector(Context3DProgramType.VERTEX,4,uvCorrection,1);
      local9.setProgramConstantsFromVector(Context3DProgramType.VERTEX,14,uvTransformConst,2);
      local9.setProgramConstantsFromVector(Context3DProgramType.FRAGMENT,23,this.fragConst,2,false);
      if(local11) {
        fragmentConst[2] = param6.softAttenuation;
        local9.setProgramConstantsFromVector(Context3DProgramType.FRAGMENT,14,fragmentConst,1);
      }
      if(param6.alternativa3d::concatenatedColorTransform != null) {
        local9.setProgramConstantsFromVector(Context3DProgramType.FRAGMENT,0,param6.alternativa3d::colorConst,2,false);
      } else if(param6.alternativa3d::concatenatedAlpha < 1) {
        local9.setProgramConstantsFromVector(Context3DProgramType.FRAGMENT,0,param6.alternativa3d::colorConst,1);
      }
      local9.drawTriangles(param3,param4,param5);
      ++param1.alternativa3d::numDraws;
      param1.alternativa3d::numTriangles += param5;
    }

    override public function disposeResource() : void {
      if(alternativa3d::textureResource != null) {
        alternativa3d::textureResource.dispose();
        alternativa3d::textureResource = null;
      }
      if(this.spriteSheetResource != null) {
        this.spriteSheetResource.dispose();
        this.spriteSheetResource = null;
      }
      if(this.lightMapResource != null) {
        this.lightMapResource.dispose();
        this.lightMapResource = null;
      }
    }

    override public function dispose() : void {
      this.disposeResource();
      this.spriteSheetBitmap = null;
      this.lightMapBitmap = null;
    }

    override protected function getProgram(param1:Boolean, param2:Boolean, param3:Boolean, param4:Boolean, param5:Boolean, param6:Boolean, param7:Boolean, param8:Boolean, param9:Boolean, param10:Boolean, param11:Boolean, param12:Boolean, param13:Boolean, param14:Boolean, param15:Boolean, param16:Boolean, param17:Boolean, param18:Boolean, param19:Boolean, param20:Boolean, param21:Boolean, param22:Boolean) : ProgramResource {
      var local25:ByteArray = null;
      var local26:ByteArray = null;
      var local23:int = int(param1) | int(param2) << 1 | int(param3) << 2 | int(param4) << 3 | int(param5) << 4 | int(param6) << 5 | int(param7) << 6 | int(param8) << 7 | int(param9) << 8 | int(param10) << 9 | int(param11) << 10 | int(param12) << 11 | int(param13) << 12 | int(param14) << 13 | int(param15) << 14 | int(param16) << 15 | int(param17) << 16 | int(param18) << 17 | int(param19) << 18 | int(param20) << 19 | int(param21) << 20 | int(param22) << 21;
      var local24:ProgramResource = this.programs[local23];
      if(local24 == null) {
        local25 = new PaintVertexShader(!param22,param14 || param11 || param12 || param17,param13,param4,param14,param10,param2,param3,param3,param19).agalcode;
        local26 = new PaintFragmentShader(param6,param5,param7,param15,param21,!param1 && !param16 && !param15,param8,param9,param3,param13,param11,param12,param17,param18,param14,param10,param2,param20).agalcode;
        local24 = new ProgramResource(local25,local26);
        this.programs[local23] = local24;
      }
      return local24;
    }
  }
}
