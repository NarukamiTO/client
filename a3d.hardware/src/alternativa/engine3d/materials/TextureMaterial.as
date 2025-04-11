package alternativa.engine3d.materials {
  import alternativa.engine3d.alternativa3d;
  import alternativa.engine3d.core.Camera3D;
  import alternativa.engine3d.core.Object3D;
  import alternativa.engine3d.objects.Decal;
  import alternativa.engine3d.objects.SkyBox;
  import alternativa.engine3d.objects.Sprite3D;
  import alternativa.gfx.core.BitmapTextureResource;
  import alternativa.gfx.core.CompressedTextureResource;
  import alternativa.gfx.core.Device;
  import alternativa.gfx.core.IndexBufferResource;
  import alternativa.gfx.core.ProgramResource;
  import alternativa.gfx.core.VertexBufferResource;
  import flash.display.BitmapData;
  import flash.display3D.Context3DProgramType;
  import flash.display3D.Context3DVertexBufferFormat;
  import flash.utils.ByteArray;

  use namespace alternativa3d;

  public class TextureMaterial extends Material {
    protected static const skyFogConst:Vector.<Number> = Vector.<Number>([0,0,0,1]);
    protected static const correctionConst:Vector.<Number> = Vector.<Number>([0,0,0,1,0,0,0,1]);
    protected static const uvCorrection:Vector.<Number> = Vector.<Number>([1,1,0,1]);
    protected static const fragmentConst:Vector.<Number> = Vector.<Number>([0,0,0,1]);

    private static var programs:Array = new Array();

    protected var uvTransformConst:Vector.<Number> = Vector.<Number>([1,0,0,0,0,1,0,0]);

    public var diffuseMapURL:String;
    public var opacityMapURL:String;
    public var repeat:Boolean = false;
    public var smooth:Boolean = true;
    public var resolution:Number = 1;
    public var threshold:Number = 0.01;
    public var correctUV:Boolean = false;

    alternativa3d var _textureATF:ByteArray;
    alternativa3d var _textureATFAlpha:ByteArray;
    alternativa3d var _mipMapping:int = 0;
    alternativa3d var _hardwareMipMaps:Boolean = false;
    alternativa3d var textureResource:BitmapTextureResource;
    alternativa3d var textureATFResource:CompressedTextureResource;
    alternativa3d var textureATFAlphaResource:CompressedTextureResource;

    protected var bitmap:BitmapData;

    public function TextureMaterial(param1:BitmapData = null, param2:Boolean = false, param3:Boolean = true, param4:int = 0, param5:Number = 1) {
      super();
      this.repeat = param2;
      this.smooth = param3;
      this.alternativa3d::_mipMapping = param4;
      this.resolution = param5;
      if(param1 != null) {
        this.bitmap = param1;
        this.alternativa3d::textureResource = TextureResourcesRegistry.getTextureResource(param1,this.alternativa3d::_mipMapping > 0,param2,this.alternativa3d::_hardwareMipMaps);
      }
    }

    public function get texture() : BitmapData {
      if(this.alternativa3d::textureResource != null) {
        return this.alternativa3d::textureResource.bitmapData;
      }
      return null;
    }

    public function set texture(param1:BitmapData) : void {
      var local2:BitmapData = this.texture;
      if(param1 != local2) {
        if(local2 != null) {
          this.alternativa3d::textureResource.dispose();
          this.alternativa3d::textureResource = null;
        }
        if(param1 != null) {
          this.alternativa3d::textureResource = TextureResourcesRegistry.getTextureResource(param1,this.alternativa3d::_mipMapping > 0,this.repeat,this.alternativa3d::_hardwareMipMaps);
        }
      }
    }

    public function get textureATF() : ByteArray {
      return this.alternativa3d::_textureATF;
    }

    public function set textureATF(param1:ByteArray) : void {
      if(param1 != this.alternativa3d::_textureATF) {
        if(this.alternativa3d::_textureATF != null) {
          this.alternativa3d::textureATFResource.dispose();
          this.alternativa3d::textureATFResource = null;
        }
        this.alternativa3d::_textureATF = param1;
        if(this.alternativa3d::_textureATF != null) {
          this.alternativa3d::textureATFResource = new CompressedTextureResource(this.alternativa3d::_textureATF);
        }
      }
    }

    public function get textureATFAlpha() : ByteArray {
      return this.alternativa3d::_textureATFAlpha;
    }

    public function set textureATFAlpha(param1:ByteArray) : void {
      if(param1 != this.alternativa3d::_textureATFAlpha) {
        if(this.alternativa3d::_textureATFAlpha != null) {
          this.alternativa3d::textureATFAlphaResource.dispose();
          this.alternativa3d::textureATFAlphaResource = null;
        }
        this.alternativa3d::_textureATFAlpha = param1;
        if(this.alternativa3d::_textureATFAlpha != null) {
          this.alternativa3d::textureATFAlphaResource = new CompressedTextureResource(this.alternativa3d::_textureATFAlpha);
        }
      }
    }

    public function get mipMapping() : int {
      return this.alternativa3d::_mipMapping;
    }

    public function set mipMapping(param1:int) : void {
      this.alternativa3d::_mipMapping = param1;
      if(this.bitmap != null) {
        this.alternativa3d::textureResource = TextureResourcesRegistry.getTextureResource(this.bitmap,this.alternativa3d::_mipMapping > 0,this.repeat,this.alternativa3d::_hardwareMipMaps);
      }
    }

    public function disposeResource() : void {
      if(this.alternativa3d::textureResource != null) {
        this.alternativa3d::textureResource.dispose();
        this.alternativa3d::textureResource = null;
      }
    }

    public function get hardwareMipMaps() : Boolean {
      return this.alternativa3d::_hardwareMipMaps;
    }

    public function set hardwareMipMaps(param1:Boolean) : void {
      if(param1 != this.alternativa3d::_hardwareMipMaps) {
        this.alternativa3d::_hardwareMipMaps = param1;
        if(this.texture != null) {
          this.alternativa3d::textureResource.calculateMipMapsUsingGPU = this.alternativa3d::_hardwareMipMaps;
        }
      }
    }

    override public function clone() : Material {
      var local1:TextureMaterial = new TextureMaterial(this.texture,this.repeat,this.smooth,this.alternativa3d::_mipMapping,this.resolution);
      local1.clonePropertiesFrom(this);
      return local1;
    }

    override protected function clonePropertiesFrom(param1:Material) : void {
      super.clonePropertiesFrom(param1);
      var local2:TextureMaterial = param1 as TextureMaterial;
      this.diffuseMapURL = local2.diffuseMapURL;
      this.opacityMapURL = local2.opacityMapURL;
      this.threshold = local2.threshold;
      this.correctUV = local2.correctUV;
      this.textureATF = local2.textureATF;
      this.textureATFAlpha = local2.textureATFAlpha;
      this.hardwareMipMaps = local2.hardwareMipMaps;
    }

    override alternativa3d function get transparent() : Boolean {
      if(super.alternativa3d::transparent) {
        return true;
      }
      if(this.texture != null) {
        return this.texture.transparent;
      }
      if(this.alternativa3d::_textureATF != null) {
        return this.alternativa3d::_textureATFAlpha != null;
      }
      return false;
    }

    override alternativa3d function drawOpaque(param1:Camera3D, param2:VertexBufferResource, param3:IndexBufferResource, param4:int, param5:int, param6:Object3D) : void {
      var local7:BitmapData = this.texture;
      if(local7 == null && this.alternativa3d::_textureATF == null) {
        return;
      }
      var local8:Device = param1.alternativa3d::device;
      var local9:Boolean = param6 is Decal;
      var local10:Boolean = !local9 && zOffset;
      var local11:Boolean = param6 is SkyBox && SkyBox(param6).autoSize;
      var local12:Boolean = param1.fogAlpha > 0 && param1.fogStrength > 0;
      var local13:Boolean = !param1.view.alternativa3d::constrained && param1.ssao && param1.ssaoStrength > 0 && Boolean(param6.alternativa3d::useDepth) && !local11;
      var local14:Boolean = !param1.view.alternativa3d::constrained && param1.directionalLight != null && param1.directionalLightStrength > 0 && param6.useLight && !local11;
      var local15:Boolean = !param1.view.alternativa3d::constrained && param1.shadowMap != null && param1.shadowMapStrength > 0 && param6.useLight && param6.useShadowMap && !local11;
      var local16:Boolean = !param1.view.alternativa3d::constrained && param1.deferredLighting && param1.deferredLightingStrength > 0 && Boolean(param6.alternativa3d::useDepth) && param6.useLight && !local11;
      var local17:Boolean = alphaTestThreshold > 0 && this.alternativa3d::transparent;
      local8.setProgram(this.getProgram(!local9 && !local17,local11,local9 || local10,false,param1.view.alternativa3d::quality,this.repeat,this.alternativa3d::_mipMapping > 0,param6.alternativa3d::concatenatedColorTransform != null,local9 && param6.alternativa3d::concatenatedAlpha < 1,local12,false,local13,local14,local15,local7 == null,false,local16,false,param1.view.alternativa3d::correction,param6.alternativa3d::concatenatedBlendMode != "normal",local17,false));
      if(local7 != null) {
        if(uploadEveryFrame && alternativa3d::drawId != Camera3D.alternativa3d::renderId) {
          local8.uploadResource(this.alternativa3d::textureResource);
          alternativa3d::drawId = Camera3D.alternativa3d::renderId;
        }
        local8.setTextureAt(0,this.alternativa3d::textureResource);
        uvCorrection[0] = this.alternativa3d::textureResource.correctionU;
        uvCorrection[1] = this.alternativa3d::textureResource.correctionV;
      } else {
        local8.setTextureAt(0,this.alternativa3d::textureATFResource);
        uvCorrection[0] = 1;
        uvCorrection[1] = 1;
      }
      if(local13) {
        local8.setTextureAt(1,param1.alternativa3d::depthMap);
      } else {
        local8.setTextureAt(1,null);
      }
      if(local15) {
        local8.setTextureAt(2,param1.shadowMap.alternativa3d::map);
        local8.setTextureAt(3,param1.shadowMap.alternativa3d::noise);
      } else {
        local8.setTextureAt(2,null);
        local8.setTextureAt(3,null);
      }
      local8.setTextureAt(4,null);
      local8.setTextureAt(6,null);
      if(local16) {
        local8.setTextureAt(5,param1.alternativa3d::lightMap);
      } else {
        local8.setTextureAt(5,null);
      }
      local8.setVertexBufferAt(0,param2,0,Context3DVertexBufferFormat.FLOAT_3);
      local8.setVertexBufferAt(1,param2,3,Context3DVertexBufferFormat.FLOAT_2);
      if(local14) {
        local8.setVertexBufferAt(2,param2,5,Context3DVertexBufferFormat.FLOAT_3);
      } else {
        local8.setVertexBufferAt(2,null);
      }
      local8.setProgramConstantsFromVector(Context3DProgramType.VERTEX,0,param6.alternativa3d::transformConst,3,false);
      local8.setProgramConstantsFromVector(Context3DProgramType.VERTEX,4,uvCorrection,1);
      if(local9) {
        correctionConst[0] = param6.alternativa3d::md * param1.alternativa3d::correctionX;
        correctionConst[1] = param6.alternativa3d::mh * param1.alternativa3d::correctionY;
        correctionConst[2] = param6.alternativa3d::ml;
        correctionConst[3] = param1.alternativa3d::correctionX;
        correctionConst[4] = param6.alternativa3d::mc * param1.alternativa3d::correctionX / Decal(param6).attenuation;
        correctionConst[5] = param6.alternativa3d::mg * param1.alternativa3d::correctionY / Decal(param6).attenuation;
        correctionConst[6] = param6.alternativa3d::mk / Decal(param6).attenuation;
        correctionConst[7] = param1.alternativa3d::correctionY;
        local8.setProgramConstantsFromVector(Context3DProgramType.VERTEX,11,correctionConst,2,false);
      } else if(local10) {
        correctionConst[0] = 0;
        correctionConst[1] = 0;
        correctionConst[2] = 0;
        correctionConst[3] = param1.alternativa3d::correctionX;
        correctionConst[4] = 0;
        correctionConst[5] = 0;
        correctionConst[6] = 0;
        correctionConst[7] = param1.alternativa3d::correctionY;
        local8.setProgramConstantsFromVector(Context3DProgramType.VERTEX,11,correctionConst,2,false);
      } else if(local11) {
        local8.setProgramConstantsFromVector(Context3DProgramType.VERTEX,11,SkyBox(param6).alternativa3d::reduceConst,1);
        if(local12) {
          skyFogConst[0] = param1.alternativa3d::fogFragment[0] * param1.alternativa3d::fogFragment[3];
          skyFogConst[1] = param1.alternativa3d::fogFragment[1] * param1.alternativa3d::fogFragment[3];
          skyFogConst[2] = param1.alternativa3d::fogFragment[2] * param1.alternativa3d::fogFragment[3];
          skyFogConst[3] = 1 - param1.alternativa3d::fogFragment[3];
          local8.setProgramConstantsFromVector(Context3DProgramType.FRAGMENT,13,skyFogConst,1);
        }
      }
      if(param6.alternativa3d::concatenatedColorTransform != null) {
        local8.setProgramConstantsFromVector(Context3DProgramType.FRAGMENT,0,param6.alternativa3d::colorConst,2,false);
      } else if(local9 && param6.alternativa3d::concatenatedAlpha < 1) {
        local8.setProgramConstantsFromVector(Context3DProgramType.FRAGMENT,0,param6.alternativa3d::colorConst,1);
      }
      if(local17) {
        fragmentConst[3] = alphaTestThreshold;
        local8.setProgramConstantsFromVector(Context3DProgramType.FRAGMENT,14,fragmentConst,1,false);
      }
      local8.drawTriangles(param3,param4,param5);
      ++param1.alternativa3d::numDraws;
      param1.alternativa3d::numTriangles += param5;
    }

    override alternativa3d function drawTransparent(param1:Camera3D, param2:VertexBufferResource, param3:IndexBufferResource, param4:int, param5:int, param6:Object3D, param7:Boolean = false) : void {
      var local8:BitmapData = this.texture;
      if(local8 == null && this.alternativa3d::_textureATF == null) {
        return;
      }
      var local9:Device = param1.alternativa3d::device;
      var local10:Boolean = zOffset;
      var local11:Boolean = param1.fogAlpha > 0 && param1.fogStrength > 0;
      var local12:Boolean = param6 is Sprite3D;
      var local13:Boolean = !param1.view.alternativa3d::constrained && param1.softTransparency && param1.softTransparencyStrength > 0 && param6.softAttenuation > 0;
      var local14:Boolean = !param1.view.alternativa3d::constrained && param1.ssao && param1.ssaoStrength > 0 && Boolean(param6.alternativa3d::useDepth);
      var local15:Boolean = !param1.view.alternativa3d::constrained && param1.directionalLight != null && param1.directionalLightStrength > 0 && param6.useLight;
      var local16:Boolean = !param1.view.alternativa3d::constrained && param1.shadowMap != null && param1.shadowMapStrength > 0 && param6.useLight && param6.useShadowMap;
      var local17:Boolean = !param1.view.alternativa3d::constrained && param1.deferredLighting && param1.deferredLightingStrength > 0;
      var local18:Boolean = local17 && Boolean(param6.alternativa3d::useDepth) && param6.useLight && !local12;
      var local19:Boolean = local17 && local12 && param6.useLight;
      local9.setProgram(this.getProgram(false,false,local10,local12,param1.view.alternativa3d::quality,this.repeat,this.alternativa3d::_mipMapping > 0,param6.alternativa3d::concatenatedColorTransform != null,param6.alternativa3d::concatenatedAlpha < 1,local11,local13,local14,local15,local16,local8 == null,local8 == null && this.alternativa3d::_textureATFAlpha != null,local18,local19,param1.view.alternativa3d::correction,param6.alternativa3d::concatenatedBlendMode != "normal",false,param7));
      if(local8 != null) {
        if(uploadEveryFrame && alternativa3d::drawId != Camera3D.alternativa3d::renderId) {
          local9.uploadResource(this.alternativa3d::textureResource);
          alternativa3d::drawId = Camera3D.alternativa3d::renderId;
        }
        local9.setTextureAt(0,this.alternativa3d::textureResource);
        uvCorrection[0] = this.alternativa3d::textureResource.correctionU;
        uvCorrection[1] = this.alternativa3d::textureResource.correctionV;
      } else {
        local9.setTextureAt(0,this.alternativa3d::textureATFResource);
        if(this.alternativa3d::_textureATFAlpha != null) {
          local9.setTextureAt(4,this.alternativa3d::textureATFAlphaResource);
        } else {
          local9.setTextureAt(4,null);
        }
        uvCorrection[0] = 1;
        uvCorrection[1] = 1;
      }
      if(local14 || local13) {
        local9.setTextureAt(1,param1.alternativa3d::depthMap);
      } else {
        local9.setTextureAt(1,null);
      }
      if(local16) {
        local9.setTextureAt(2,param1.shadowMap.alternativa3d::map);
        local9.setTextureAt(3,param1.shadowMap.alternativa3d::noise);
      } else {
        local9.setTextureAt(2,null);
        local9.setTextureAt(3,null);
      }
      local9.setTextureAt(4,null);
      local9.setTextureAt(6,null);
      if(local18) {
        local9.setTextureAt(5,param1.alternativa3d::lightMap);
      } else {
        local9.setTextureAt(5,null);
      }
      local9.setVertexBufferAt(0,param2,0,Context3DVertexBufferFormat.FLOAT_1);
      local9.setVertexBufferAt(1,null);
      local9.setVertexBufferAt(2,null);
      if(!local12) {
        local9.setProgramConstantsFromVector(Context3DProgramType.VERTEX,0,param6.alternativa3d::transformConst,3,false);
      }
      local9.setProgramConstantsFromVector(Context3DProgramType.VERTEX,4,uvCorrection,1);
      if(local13) {
        fragmentConst[2] = param6.softAttenuation;
        local9.setProgramConstantsFromVector(Context3DProgramType.FRAGMENT,14,fragmentConst,1);
      }
      if(local10) {
        correctionConst[0] = 0;
        correctionConst[1] = 0;
        correctionConst[2] = 0;
        correctionConst[3] = param1.alternativa3d::correctionX;
        correctionConst[4] = 0;
        correctionConst[5] = 0;
        correctionConst[6] = 0;
        correctionConst[7] = param1.alternativa3d::correctionY;
        local9.setProgramConstantsFromVector(Context3DProgramType.VERTEX,11,correctionConst,2,false);
      } else if(local12) {
        if(local15) {
          correctionConst[0] = param1.alternativa3d::correctionX;
          correctionConst[1] = param1.alternativa3d::correctionY;
          correctionConst[2] = 1;
          correctionConst[3] = 0.5;
          local9.setProgramConstantsFromVector(Context3DProgramType.VERTEX,11,correctionConst,1,false);
        }
        if(local19) {
          local9.setProgramConstantsFromVector(Context3DProgramType.FRAGMENT,13,Sprite3D(param6).alternativa3d::lightConst,1,false);
        }
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

    protected function getProgram(param1:Boolean, param2:Boolean, param3:Boolean, param4:Boolean, param5:Boolean, param6:Boolean, param7:Boolean, param8:Boolean, param9:Boolean, param10:Boolean, param11:Boolean, param12:Boolean, param13:Boolean, param14:Boolean, param15:Boolean, param16:Boolean, param17:Boolean, param18:Boolean, param19:Boolean, param20:Boolean, param21:Boolean, param22:Boolean) : ProgramResource {
      var local25:ByteArray = null;
      var local26:ByteArray = null;
      var local23:int = int(param1) | int(param2) << 1 | int(param3) << 2 | int(param4) << 3 | int(param5) << 4 | int(param6) << 5 | int(param7) << 6 | int(param8) << 7 | int(param9) << 8 | int(param10) << 9 | int(param11) << 10 | int(param12) << 11 | int(param13) << 12 | int(param14) << 13 | int(param15) << 14 | int(param16) << 15 | int(param17) << 16 | int(param18) << 17 | int(param19) << 18 | int(param20) << 19 | int(param21) << 20 | int(param22) << 21;
      var local24:ProgramResource = programs[local23];
      if(local24 == null) {
        local25 = new TextureMaterialVertexShader(!param22,param14 || param11 || param12 || param17,param13,param4,param14,param10,param2,param3,param3,param19).agalcode;
        local26 = new TextureMaterialFragmentShader(param6,param5,param7,param15,param16,param21,!param1 && !param16 && !param15,param8,param9,param3,param13,param11,param12,param17,param18,param14,param10,param2,param20).agalcode;
        local24 = new ProgramResource(local25,local26);
        programs[local23] = local24;
      }
      return local24;
    }

    override public function dispose() : void {
      this.disposeResource();
    }
  }
}
