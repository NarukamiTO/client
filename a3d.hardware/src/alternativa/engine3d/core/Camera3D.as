package alternativa.engine3d.core {
  import alternativa.engine3d.alternativa3d;
  import alternativa.engine3d.lights.DirectionalLight;
  import alternativa.engine3d.lights.OmniLight;
  import alternativa.engine3d.lights.SpotLight;
  import alternativa.engine3d.lights.TubeLight;
  import alternativa.engine3d.materials.Material;
  import alternativa.engine3d.objects.Decal;
  import alternativa.engine3d.objects.Sprite3D;
  import alternativa.gfx.core.Device;
  import alternativa.gfx.core.IndexBufferResource;
  import alternativa.gfx.core.TextureResource;
  import alternativa.gfx.core.VertexBufferResource;
  import flash.display.Bitmap;
  import flash.display.BitmapData;
  import flash.display.DisplayObject;
  import flash.display.Sprite;
  import flash.display.StageAlign;
  import flash.display3D.Context3DBlendFactor;
  import flash.display3D.Context3DClearMask;
  import flash.display3D.Context3DCompareMode;
  import flash.display3D.Context3DProgramType;
  import flash.display3D.Context3DStencilAction;
  import flash.display3D.Context3DTriangleFace;
  import flash.events.Event;
  import flash.geom.Point;
  import flash.geom.Rectangle;
  import flash.geom.Vector3D;
  import flash.system.System;
  import flash.text.TextField;
  import flash.text.TextFieldAutoSize;
  import flash.text.TextFormat;
  import flash.utils.Dictionary;
  import flash.utils.getDefinitionByName;
  import flash.utils.getQualifiedClassName;
  import flash.utils.getQualifiedSuperclassName;
  import flash.utils.getTimer;

  use namespace alternativa3d;

  public class Camera3D extends Object3D {
    alternativa3d static var renderId:int = 0;

    private static const constantsAttributesCount:int = 8;
    private static const constantsOffset:int = 16;
    private static const constantsMaxTriangles:int = 18;
    private static const constants:Vector.<Number> = new Vector.<Number>(constantsMaxTriangles * 3 * constantsAttributesCount);
    private static const constantsVertexBuffer:VertexBufferResource = createConstantsVertexBuffer(constantsMaxTriangles * 3);
    private static const constantsIndexBuffer:IndexBufferResource = createConstantsIndexBuffer(constantsMaxTriangles * 3);

    public var view:View;
    public var fov:Number = 1.5707963267948966;
    public var nearClipping:Number = 1;
    public var farClipping:Number = 1000000;
    public var onRender:Function;

    alternativa3d var viewSizeX:Number;
    alternativa3d var viewSizeY:Number;
    alternativa3d var focalLength:Number;
    alternativa3d var correctionX:Number;
    alternativa3d var correctionY:Number;
    alternativa3d var lights:Vector.<Light3D> = new Vector.<Light3D>();
    alternativa3d var lightsLength:int = 0;
    alternativa3d var occluders:Vector.<Vertex> = new Vector.<Vertex>();
    alternativa3d var numOccluders:int;
    alternativa3d var occludedAll:Boolean;
    alternativa3d var numDraws:int;
    alternativa3d var numShadows:int;
    alternativa3d var numTriangles:int;
    alternativa3d var device:Device;
    alternativa3d var projection:Vector.<Number> = new Vector.<Number>(4);
    alternativa3d var correction:Vector.<Number> = new Vector.<Number>(4);
    alternativa3d var transform:Vector.<Number> = new Vector.<Number>(12);

    private var opaqueMaterials:Vector.<Material> = new Vector.<Material>();
    private var opaqueVertexBuffers:Vector.<VertexBufferResource> = new Vector.<VertexBufferResource>();
    private var opaqueIndexBuffers:Vector.<IndexBufferResource> = new Vector.<IndexBufferResource>();
    private var opaqueFirstIndexes:Vector.<int> = new Vector.<int>();
    private var opaqueNumsTriangles:Vector.<int> = new Vector.<int>();
    private var opaqueObjects:Vector.<Object3D> = new Vector.<Object3D>();
    private var opaqueCount:int = 0;
    private var skyMaterials:Vector.<Material> = new Vector.<Material>();
    private var skyVertexBuffers:Vector.<VertexBufferResource> = new Vector.<VertexBufferResource>();
    private var skyIndexBuffers:Vector.<IndexBufferResource> = new Vector.<IndexBufferResource>();
    private var skyFirstIndexes:Vector.<int> = new Vector.<int>();
    private var skyNumsTriangles:Vector.<int> = new Vector.<int>();
    private var skyObjects:Vector.<Object3D> = new Vector.<Object3D>();
    private var skyCount:int = 0;
    private var transparentFaceLists:Vector.<Face> = new Vector.<Face>();
    private var transparentObjects:Vector.<Object3D> = new Vector.<Object3D>();
    private var transparentCount:int = 0;
    private var transparentOpaqueFaceLists:Vector.<Face> = new Vector.<Face>();
    private var transparentOpaqueObjects:Vector.<Object3D> = new Vector.<Object3D>();
    private var transparentOpaqueCount:int = 0;
    private var transparentBatchObjects:Vector.<Object3D> = new Vector.<Object3D>();
    private var decals:Vector.<Decal> = new Vector.<Decal>();
    private var decalsCount:int = 0;

    alternativa3d var depthObjects:Vector.<Object3D> = new Vector.<Object3D>();
    alternativa3d var depthCount:int = 0;
    alternativa3d var casterObjects:Vector.<Object3D> = new Vector.<Object3D>();
    alternativa3d var casterCount:int = 0;
    alternativa3d var shadowAtlases:Array = new Array();
    alternativa3d var receiversVertexBuffers:Vector.<VertexBufferResource>;
    alternativa3d var receiversIndexBuffers:Vector.<IndexBufferResource>;
    alternativa3d var gma:Number;
    alternativa3d var gmb:Number;
    alternativa3d var gmc:Number;
    alternativa3d var gmd:Number;
    alternativa3d var gme:Number;
    alternativa3d var gmf:Number;
    alternativa3d var gmg:Number;
    alternativa3d var gmh:Number;
    alternativa3d var gmi:Number;
    alternativa3d var gmj:Number;
    alternativa3d var gmk:Number;
    alternativa3d var gml:Number;
    alternativa3d var fogParams:Vector.<Number> = Vector.<Number>([1,1,0,1]);
    alternativa3d var fogFragment:Vector.<Number> = Vector.<Number>([0,0,0,1]);

    private var fragmentConst:Vector.<Number> = Vector.<Number>([0,0,0,1,0.5,0.5,0,1 / 4096]);
    private var shadows:Dictionary = new Dictionary();
    private var shadowList:Vector.<Shadow> = new Vector.<Shadow>();
    private var depthRenderer:DepthRenderer = new DepthRenderer();

    alternativa3d var depthMap:TextureResource;
    alternativa3d var lightMap:TextureResource;

    private var depthParams:Vector.<Number> = Vector.<Number>([0,0,0,1]);
    private var ssaoParams:Vector.<Number> = Vector.<Number>([0,0,0,1]);
    private var lightTransform:Vector.<Number> = Vector.<Number>([0,0,0,1]);
    private var lightParams:Vector.<Number> = Vector.<Number>([0,0,0,1,0,0,0,1]);

    alternativa3d var omnies:Vector.<OmniLight> = new Vector.<OmniLight>();
    alternativa3d var omniesCount:int = 0;
    alternativa3d var spots:Vector.<SpotLight> = new Vector.<SpotLight>();
    alternativa3d var spotsCount:int = 0;
    alternativa3d var tubes:Vector.<TubeLight> = new Vector.<TubeLight>();
    alternativa3d var tubesCount:int = 0;

    public var fogNear:Number = 0;
    public var fogFar:Number = 1000000;
    public var fogAlpha:Number = 0;
    public var fogColor:int = 8355711;
    public var softTransparency:Boolean = false;
    public var depthBufferScale:Number = 1;
    public var ssao:Boolean = false;
    public var ssaoRadius:Number = 100;
    public var ssaoRange:Number = 1000;
    public var ssaoColor:int = 0;
    public var ssaoAlpha:Number = 1;
    public var directionalLight:DirectionalLight;
    public var shadowMap:ShadowMap;
    public var ambientColor:int = 0;
    public var deferredLighting:Boolean = false;
    public var fogStrength:Number = 1;
    public var softTransparencyStrength:Number = 1;
    public var ssaoStrength:Number = 1;
    public var directionalLightStrength:Number = 1;
    public var shadowMapStrength:Number = 1;
    public var shadowsStrength:Number = 1;
    public var shadowsDistanceMultiplier:Number = 1;
    public var deferredLightingStrength:Number = 1;
    public var debug:Boolean = false;

    private var debugSet:Object = new Object();
    private var _diagram:Sprite = this.createDiagram();

    public var fpsUpdatePeriod:int = 10;
    public var timerUpdatePeriod:int = 10;

    private var fpsTextField:TextField;
    private var memoryTextField:TextField;
    private var drawsTextField:TextField;
    private var shadowsTextField:TextField;
    private var trianglesTextField:TextField;
    private var timerTextField:TextField;
    private var graph:Bitmap;
    private var rect:Rectangle;
    private var _diagramAlign:String = "TR";
    private var _diagramHorizontalMargin:Number = 2;
    private var _diagramVerticalMargin:Number = 2;
    private var fpsUpdateCounter:int;
    private var previousFrameTime:int;
    private var previousPeriodTime:int;
    private var maxMemory:int;
    private var timerUpdateCounter:int;
    private var timeSum:int;
    private var timeCount:int;
    private var timer:int;
    private var firstVertex:Vertex = new Vertex();
    private var firstFace:Face = new Face();
    private var firstWrapper:Wrapper = new Wrapper();

    alternativa3d var lastWrapper:Wrapper = this.firstWrapper;
    alternativa3d var lastVertex:Vertex = this.firstVertex;
    alternativa3d var lastFace:Face = this.firstFace;

    public function Camera3D() {
      super();
    }

    private static function createConstantsVertexBuffer(param1:int) : VertexBufferResource {
      var local5:int = 0;
      var local2:Vector.<Number> = new Vector.<Number>();
      var local3:int = 0;
      while(local3 < param1) {
        local2.push((local3 << 1) + constantsOffset);
        local3++;
      }
      var local4:int = 0;
      while(local4 < param1 << 1) {
        local5 = local4 * 4 + 3;
        constants[local5] = 1;
        local4++;
      }
      return new VertexBufferResource(local2,1);
    }

    private static function createConstantsIndexBuffer(param1:int) : IndexBufferResource {
      var local2:Vector.<uint> = new Vector.<uint>();
      var local3:int = 0;
      while(local3 < param1) {
        local2.push(local3);
        local3++;
      }
      return new IndexBufferResource(local2);
    }

    public function addShadow(param1:Shadow) : void {
      this.shadows[param1] = true;
    }

    public function removeShadow(param1:Shadow) : void {
      delete this.shadows[param1];
    }

    public function removeAllShadows() : void {
      this.shadows = new Dictionary();
    }

    public function render() : void {
      var local1:int = 0;
      var local2:int = 0;
      var local3:int = 0;
      var local4:Shadow = null;
      var local5:Object3D = null;
      var local6:Light3D = null;
      var local7:ShadowAtlas = null;
      var local8:Boolean = false;
      var local9:Material = null;
      var local10:* = undefined;
      var local11:Decal = null;
      var local12:int = 0;
      var local13:int = 0;
      var local14:int = 0;
      var local15:TextureResource = null;
      var local16:Face = null;
      var local17:Object3D = null;
      var local18:Boolean = false;
      var local19:Boolean = false;
      var local20:int = 0;
      var local21:Sprite3D = null;
      var local22:Face = null;
      var local23:Face = null;
      var local24:Object3D = null;
      var local25:Sprite3D = null;
      this.alternativa3d::numDraws = 0;
      this.alternativa3d::numShadows = 0;
      this.alternativa3d::numTriangles = 0;
      if(this.view != null && this.view.alternativa3d::device != null && Boolean(this.view.alternativa3d::device.ready)) {
        ++alternativa3d::renderId;
        this.alternativa3d::device = this.view.alternativa3d::device;
        this.view.alternativa3d::configure();
        if(this.nearClipping < 1) {
          this.nearClipping = 1;
        }
        if(this.farClipping > 1000000) {
          this.farClipping = 1000000;
        }
        this.alternativa3d::viewSizeX = this.view.alternativa3d::_width * 0.5;
        this.alternativa3d::viewSizeY = this.view.alternativa3d::_height * 0.5;
        this.alternativa3d::focalLength = Math.sqrt(this.alternativa3d::viewSizeX * this.alternativa3d::viewSizeX + this.alternativa3d::viewSizeY * this.alternativa3d::viewSizeY) / Math.tan(this.fov * 0.5);
        this.alternativa3d::correctionX = this.alternativa3d::viewSizeX / this.alternativa3d::focalLength;
        this.alternativa3d::correctionY = this.alternativa3d::viewSizeY / this.alternativa3d::focalLength;
        this.alternativa3d::projection[0] = 1 << this.view.zBufferPrecision;
        this.alternativa3d::projection[1] = 1;
        this.alternativa3d::projection[2] = this.farClipping / (this.farClipping - this.nearClipping);
        this.alternativa3d::projection[3] = this.nearClipping * this.farClipping / (this.nearClipping - this.farClipping);
        this.alternativa3d::composeCameraMatrix();
        local5 = this;
        while(local5.alternativa3d::_parent != null) {
          local5 = local5.alternativa3d::_parent;
          local5.alternativa3d::composeMatrix();
          alternativa3d::appendMatrix(local5);
        }
        this.alternativa3d::gma = alternativa3d::ma;
        this.alternativa3d::gmb = alternativa3d::mb;
        this.alternativa3d::gmc = alternativa3d::mc;
        this.alternativa3d::gmd = alternativa3d::md;
        this.alternativa3d::gme = alternativa3d::me;
        this.alternativa3d::gmf = alternativa3d::mf;
        this.alternativa3d::gmg = alternativa3d::mg;
        this.alternativa3d::gmh = alternativa3d::mh;
        this.alternativa3d::gmi = alternativa3d::mi;
        this.alternativa3d::gmj = alternativa3d::mj;
        this.alternativa3d::gmk = alternativa3d::mk;
        this.alternativa3d::gml = alternativa3d::ml;
        alternativa3d::invertMatrix();
        this.alternativa3d::transform[0] = alternativa3d::ma;
        this.alternativa3d::transform[1] = alternativa3d::mb;
        this.alternativa3d::transform[2] = alternativa3d::mc;
        this.alternativa3d::transform[3] = alternativa3d::md;
        this.alternativa3d::transform[4] = alternativa3d::me;
        this.alternativa3d::transform[5] = alternativa3d::mf;
        this.alternativa3d::transform[6] = alternativa3d::mg;
        this.alternativa3d::transform[7] = alternativa3d::mh;
        this.alternativa3d::transform[8] = alternativa3d::mi;
        this.alternativa3d::transform[9] = alternativa3d::mj;
        this.alternativa3d::transform[10] = alternativa3d::mk;
        this.alternativa3d::transform[11] = alternativa3d::ml;
        this.alternativa3d::numOccluders = 0;
        this.alternativa3d::occludedAll = false;
        if(local5 != this && local5.visible) {
          this.alternativa3d::lightsLength = 0;
          local6 = (local5 as Object3DContainer).alternativa3d::lightList;
          while(local6 != null) {
            if(local6.visible) {
              local6.alternativa3d::calculateCameraMatrix(this);
              if(local6.alternativa3d::checkFrustumCulling(this)) {
                this.alternativa3d::lights[this.alternativa3d::lightsLength] = local6;
                ++this.alternativa3d::lightsLength;
                if(!this.view.alternativa3d::constrained && this.deferredLighting && this.deferredLightingStrength > 0) {
                  if(local6 is OmniLight) {
                    this.alternativa3d::omnies[this.alternativa3d::omniesCount] = local6 as OmniLight;
                    ++this.alternativa3d::omniesCount;
                  } else if(local6 is SpotLight) {
                    this.alternativa3d::spots[this.alternativa3d::spotsCount] = local6 as SpotLight;
                    ++this.alternativa3d::spotsCount;
                  } else if(local6 is TubeLight) {
                    this.alternativa3d::tubes[this.alternativa3d::tubesCount] = local6 as TubeLight;
                    ++this.alternativa3d::tubesCount;
                  }
                }
              }
            }
            local6 = local6.alternativa3d::nextLight;
          }
          local5.alternativa3d::appendMatrix(this);
          local5.alternativa3d::cullingInCamera(this,63);
          if(this.debug) {
            local1 = 0;
            while(local1 < this.alternativa3d::lightsLength) {
              (this.alternativa3d::lights[local1] as Light3D).alternativa3d::drawDebug(this);
              local1++;
            }
          }
          local8 = false;
          if(!this.view.alternativa3d::constrained && this.shadowsStrength > 0) {
            for(local10 in this.shadows) {
              local4 = local10;
              if(local4.alternativa3d::checkVisibility(this)) {
                local2 = local4.mapSize + local4.blur;
                local7 = this.alternativa3d::shadowAtlases[local2];
                if(local7 == null) {
                  local7 = new ShadowAtlas(local4.mapSize,local4.blur);
                  this.alternativa3d::shadowAtlases[local2] = local7;
                }
                local7.alternativa3d::shadows[local7.alternativa3d::shadowsCount] = local4;
                ++local7.alternativa3d::shadowsCount;
                local8 = true;
              }
            }
          }
          this.alternativa3d::device.setCulling(Context3DTriangleFace.FRONT);
          this.alternativa3d::device.setBlendFactors(Context3DBlendFactor.ONE,Context3DBlendFactor.ZERO);
          this.alternativa3d::device.setStencilActions(Context3DTriangleFace.NONE);
          this.alternativa3d::device.setStencilReferenceValue(0);
          if(local8) {
            this.alternativa3d::device.setCulling(Context3DTriangleFace.BACK);
            this.alternativa3d::device.setDepthTest(true,Context3DCompareMode.GREATER_EQUAL);
            this.alternativa3d::device.setProgram(Shadow.alternativa3d::getCasterProgram());
            for each(local7 in this.alternativa3d::shadowAtlases) {
              if(local7.alternativa3d::shadowsCount > 0) {
                local7.alternativa3d::renderCasters(this);
              }
            }
            this.alternativa3d::device.setCulling(Context3DTriangleFace.FRONT);
            this.alternativa3d::device.setDepthTest(false,Context3DCompareMode.ALWAYS);
            for each(local7 in this.alternativa3d::shadowAtlases) {
              if(local7.alternativa3d::shadowsCount > 0) {
                local7.alternativa3d::renderBlur(this);
              }
            }
            this.alternativa3d::device.setTextureAt(0,null);
            this.alternativa3d::device.setVertexBufferAt(1,null);
          }
          if(this.directionalLight != null) {
            this.directionalLight.alternativa3d::composeAndAppend(this);
            this.directionalLight.alternativa3d::calculateInverseMatrix();
          }
          local5.alternativa3d::concatenatedAlpha = local5.alpha;
          local5.alternativa3d::concatenatedBlendMode = local5.blendMode;
          local5.alternativa3d::concatenatedColorTransform = local5.colorTransform;
          local5.alternativa3d::draw(this);
          this.alternativa3d::device.setDepthTest(true,Context3DCompareMode.LESS);
          if(!this.view.alternativa3d::constrained && this.shadowMap != null && this.shadowMapStrength > 0) {
            this.shadowMap.alternativa3d::calculateBounds(this);
            this.shadowMap.alternativa3d::render(this,this.alternativa3d::casterObjects,this.alternativa3d::casterCount);
          }
          this.alternativa3d::depthMap = null;
          this.alternativa3d::lightMap = null;
          if(!this.view.alternativa3d::constrained && (this.softTransparency && this.softTransparencyStrength > 0 || this.ssao && this.ssaoStrength > 0 || this.deferredLighting && this.deferredLightingStrength > 0)) {
            this.depthRenderer.alternativa3d::render(this,this.view.alternativa3d::_width,this.view.alternativa3d::_height,this.depthBufferScale,this.ssao && this.ssaoStrength > 0,this.deferredLighting && this.deferredLightingStrength > 0,this.directionalLight != null && this.directionalLightStrength > 0 || this.shadowMap != null && this.shadowMapStrength > 0 ? 0 : 0.5,this.alternativa3d::depthObjects,this.alternativa3d::depthCount);
            if(this.softTransparency && this.softTransparencyStrength > 0 || this.ssao && this.ssaoStrength > 0) {
              this.alternativa3d::depthMap = this.depthRenderer.alternativa3d::depthBuffer;
            }
            if(this.deferredLighting && this.deferredLightingStrength > 0) {
              this.alternativa3d::lightMap = this.depthRenderer.alternativa3d::lightBuffer;
            }
          } else {
            this.depthRenderer.alternativa3d::resetResources();
          }
          if(local8 || !this.view.alternativa3d::constrained && (this.softTransparency && this.softTransparencyStrength > 0 || this.ssao && this.ssaoStrength > 0 || this.deferredLighting && this.deferredLightingStrength > 0) || !this.view.alternativa3d::constrained && this.shadowMap != null && this.shadowMapStrength > 0) {
            this.alternativa3d::device.setRenderToBackBuffer();
          }
          this.view.alternativa3d::clearArea();
          this.alternativa3d::device.setProgramConstantsFromVector(Context3DProgramType.VERTEX,3,this.alternativa3d::projection,1);
          this.fragmentConst[0] = this.farClipping;
          this.fragmentConst[1] = this.farClipping / 255;
          this.alternativa3d::device.setProgramConstantsFromVector(Context3DProgramType.FRAGMENT,17,this.fragmentConst,2);
          this.alternativa3d::correction[0] = this.view.alternativa3d::rect.width / this.alternativa3d::device.width;
          this.alternativa3d::correction[1] = this.view.alternativa3d::rect.height / this.alternativa3d::device.height;
          this.alternativa3d::correction[2] = (this.view.alternativa3d::rect.x * 2 + this.view.alternativa3d::rect.width - this.alternativa3d::device.width) / this.alternativa3d::device.width;
          this.alternativa3d::correction[3] = (this.view.alternativa3d::rect.y * 2 + this.view.alternativa3d::rect.height - this.alternativa3d::device.height) / this.alternativa3d::device.height;
          this.alternativa3d::device.setProgramConstantsFromVector(Context3DProgramType.VERTEX,13,this.alternativa3d::correction,1);
          if(!this.view.alternativa3d::constrained && (this.softTransparency && this.softTransparencyStrength > 0 || this.ssao && this.ssaoStrength > 0 || this.deferredLighting && this.deferredLightingStrength > 0 || this.shadowMap != null && this.shadowMapStrength > 0)) {
            this.depthParams[0] = this.depthRenderer.alternativa3d::correctionX;
            this.depthParams[1] = this.depthRenderer.alternativa3d::correctionY;
            this.alternativa3d::device.setProgramConstantsFromVector(Context3DProgramType.FRAGMENT,4,this.depthParams,1);
            if(this.ssao && this.ssaoStrength > 0) {
              this.ssaoParams[0] = (1 - 2 * (this.ssaoColor >> 16 & 0xFF) / 255) * this.ssaoAlpha * this.ssaoStrength;
              this.ssaoParams[1] = (1 - 2 * (this.ssaoColor >> 8 & 0xFF) / 255) * this.ssaoAlpha * this.ssaoStrength;
              this.ssaoParams[2] = (1 - 2 * (this.ssaoColor & 0xFF) / 255) * this.ssaoAlpha * this.ssaoStrength;
              this.alternativa3d::device.setProgramConstantsFromVector(Context3DProgramType.FRAGMENT,12,this.ssaoParams,1);
            }
          }
          if(!this.view.alternativa3d::constrained && this.shadowMap != null && this.shadowMapStrength > 0) {
            this.alternativa3d::device.setProgramConstantsFromVector(Context3DProgramType.VERTEX,6,this.shadowMap.alternativa3d::transform,4);
            this.alternativa3d::device.setProgramConstantsFromVector(Context3DProgramType.FRAGMENT,5,this.shadowMap.alternativa3d::params,5);
          }
          if(this.fogAlpha > 0 && this.fogStrength > 0) {
            this.alternativa3d::fogParams[2] = this.fogNear;
            this.alternativa3d::fogParams[3] = this.fogFar - this.fogNear;
            this.alternativa3d::device.setProgramConstantsFromVector(Context3DProgramType.VERTEX,5,this.alternativa3d::fogParams,1);
            this.alternativa3d::fogFragment[0] = (this.fogColor >> 16 & 0xFF) / 255;
            this.alternativa3d::fogFragment[1] = (this.fogColor >> 8 & 0xFF) / 255;
            this.alternativa3d::fogFragment[2] = (this.fogColor & 0xFF) / 255;
            this.alternativa3d::fogFragment[3] = this.fogAlpha * this.fogStrength;
            this.alternativa3d::device.setProgramConstantsFromVector(Context3DProgramType.FRAGMENT,2,this.alternativa3d::fogFragment,1);
          }
          if(!this.view.alternativa3d::constrained && this.directionalLight != null && this.directionalLightStrength > 0) {
            this.lightTransform[0] = -this.directionalLight.alternativa3d::imi;
            this.lightTransform[1] = -this.directionalLight.alternativa3d::imj;
            this.lightTransform[2] = -this.directionalLight.alternativa3d::imk;
            this.alternativa3d::device.setProgramConstantsFromVector(Context3DProgramType.VERTEX,10,this.lightTransform,1);
            this.lightParams[0] = this.directionalLight.intensity * (this.directionalLight.color >> 16 & 0xFF) * 2 * this.directionalLightStrength / 255;
            this.lightParams[1] = this.directionalLight.intensity * (this.directionalLight.color >> 8 & 0xFF) * 2 * this.directionalLightStrength / 255;
            this.lightParams[2] = this.directionalLight.intensity * (this.directionalLight.color & 0xFF) * 2 * this.directionalLightStrength / 255;
            this.lightParams[4] = 1 + ((this.ambientColor >> 16 & 0xFF) * 2 / 255 - 1) * this.directionalLightStrength;
            this.lightParams[5] = 1 + ((this.ambientColor >> 8 & 0xFF) * 2 / 255 - 1) * this.directionalLightStrength;
            this.lightParams[6] = 1 + ((this.ambientColor & 0xFF) * 2 / 255 - 1) * this.directionalLightStrength;
            this.alternativa3d::device.setProgramConstantsFromVector(Context3DProgramType.FRAGMENT,10,this.lightParams,2);
          } else if(!this.view.alternativa3d::constrained && this.shadowMap != null && this.shadowMapStrength > 0) {
            this.lightParams[0] = 0;
            this.lightParams[1] = 0;
            this.lightParams[2] = 0;
            this.lightParams[4] = 1;
            this.lightParams[5] = 1;
            this.lightParams[6] = 1;
            this.alternativa3d::device.setProgramConstantsFromVector(Context3DProgramType.FRAGMENT,10,this.lightParams,2);
          }
          local1 = 0;
          while(local1 < this.opaqueCount) {
            local9 = this.opaqueMaterials[local1];
            local9.alternativa3d::drawOpaque(this,this.opaqueVertexBuffers[local1],this.opaqueIndexBuffers[local1],this.opaqueFirstIndexes[local1],this.opaqueNumsTriangles[local1],this.opaqueObjects[local1]);
            local1++;
          }
          this.alternativa3d::device.setDepthTest(false,Context3DCompareMode.LESS_EQUAL);
          local1 = 0;
          while(local1 < this.skyCount) {
            local9 = this.skyMaterials[local1];
            local9.alternativa3d::drawOpaque(this,this.skyVertexBuffers[local1],this.skyIndexBuffers[local1],this.skyFirstIndexes[local1],this.skyNumsTriangles[local1],this.skyObjects[local1]);
            local1++;
          }
          this.alternativa3d::device.setDepthTest(false,Context3DCompareMode.LESS);
          local1 = this.decalsCount - 1;
          while(local1 >= 0) {
            local11 = this.decals[local1];
            if(local11.alternativa3d::concatenatedBlendMode != "normal") {
              this.alternativa3d::device.setBlendFactors(Context3DBlendFactor.SOURCE_ALPHA,Context3DBlendFactor.ONE);
            } else {
              this.alternativa3d::device.setBlendFactors(Context3DBlendFactor.SOURCE_ALPHA,Context3DBlendFactor.ONE_MINUS_SOURCE_ALPHA);
            }
            local11.alternativa3d::faceList.material.alternativa3d::drawOpaque(this,local11.alternativa3d::vertexBuffer,local11.alternativa3d::indexBuffer,0,local11.alternativa3d::numTriangles,local11);
            local1--;
          }
          if(local8) {
            this.alternativa3d::device.setTextureAt(0,null);
            this.alternativa3d::device.setTextureAt(1,null);
            this.alternativa3d::device.setTextureAt(2,null);
            this.alternativa3d::device.setTextureAt(3,null);
            this.alternativa3d::device.setTextureAt(5,null);
            this.alternativa3d::device.setVertexBufferAt(1,null);
            this.alternativa3d::device.setVertexBufferAt(2,null);
            local12 = 0;
            for each(local7 in this.alternativa3d::shadowAtlases) {
              local1 = 0;
              while(local1 < local7.alternativa3d::shadowsCount) {
                this.shadowList[local12] = local7.alternativa3d::shadows[local1];
                local12++;
                local1++;
              }
            }
            this.alternativa3d::device.setDepthTest(false,Context3DCompareMode.LESS);
            local15 = null;
            local1 = 0;
            while(local1 < local12) {
              if(local1 > 0) {
                this.alternativa3d::device.clear(0,0,0,0,1,0,Context3DClearMask.STENCIL);
              }
              this.alternativa3d::device.setBlendFactors(Context3DBlendFactor.ZERO,Context3DBlendFactor.ONE);
              this.alternativa3d::device.setCulling(Context3DTriangleFace.NONE);
              this.alternativa3d::device.setStencilActions(Context3DTriangleFace.FRONT_AND_BACK,Context3DCompareMode.ALWAYS,Context3DStencilAction.INVERT);
              local13 = local1;
              local14 = 1;
              while(local13 < local1 + 8 && local13 < local12) {
                local4 = this.shadowList[local13];
                if(!local4.alternativa3d::cameraInside) {
                  this.alternativa3d::device.setStencilReferenceValue(local14,local14,local14);
                  local4.alternativa3d::renderVolume(this);
                }
                local13++;
                local14 <<= 1;
              }
              this.alternativa3d::device.setBlendFactors(Context3DBlendFactor.SOURCE_ALPHA,Context3DBlendFactor.ONE_MINUS_SOURCE_ALPHA);
              this.alternativa3d::device.setCulling(Context3DTriangleFace.FRONT);
              this.alternativa3d::device.setStencilActions(Context3DTriangleFace.BACK,Context3DCompareMode.EQUAL);
              local13 = local1;
              local14 = 1;
              while(local13 < local1 + 8 && local13 < local12) {
                local4 = this.shadowList[local13];
                if(local4.alternativa3d::texture != local15) {
                  this.alternativa3d::device.setTextureAt(0,local4.alternativa3d::texture);
                  local15 = local4.alternativa3d::texture;
                }
                if(!local4.alternativa3d::cameraInside) {
                  this.alternativa3d::device.setStencilReferenceValue(local14,local14,local14);
                  local4.alternativa3d::renderReceivers(this);
                } else {
                  this.alternativa3d::device.setStencilActions(Context3DTriangleFace.BACK,Context3DCompareMode.ALWAYS);
                  local4.alternativa3d::renderReceivers(this);
                  this.alternativa3d::device.setStencilActions(Context3DTriangleFace.BACK,Context3DCompareMode.EQUAL);
                }
                local13++;
                local14 <<= 1;
              }
              this.alternativa3d::device.setTextureAt(0,null);
              local15 = null;
              local1 += 8;
            }
            this.alternativa3d::device.setStencilActions();
            this.alternativa3d::device.setStencilReferenceValue(0);
          }
          this.alternativa3d::device.setProgramConstantsFromVector(Context3DProgramType.VERTEX,13,this.alternativa3d::correction,1);
          this.alternativa3d::device.setCulling(Context3DTriangleFace.FRONT);
          local1 = 0;
          while(local1 < this.transparentOpaqueCount) {
            if(local1 < this.transparentOpaqueFaceLists.length && local1 < this.transparentOpaqueObjects.length) {
              this.transparentFaceLists[this.transparentCount] = this.transparentOpaqueFaceLists[local1];
              this.transparentObjects[this.transparentCount] = this.transparentOpaqueObjects[local1];
              ++this.transparentCount;
            }
            local1++;
          }
          this.transparentOpaqueCount = this.transparentCount - this.transparentOpaqueCount;
          this.alternativa3d::device.setDepthTest(true,Context3DCompareMode.LESS);
          local1 = this.transparentCount - 1;
          while(local1 >= 0) {
            if(local1 + 1 == this.transparentOpaqueCount) {
              this.alternativa3d::device.setDepthTest(false,Context3DCompareMode.LESS);
            }
            local16 = this.transparentFaceLists[local1];
            local17 = this.transparentObjects[local1];
            if(local17.alternativa3d::concatenatedBlendMode != "normal") {
              this.alternativa3d::device.setBlendFactors(Context3DBlendFactor.SOURCE_ALPHA,Context3DBlendFactor.ONE);
            } else {
              this.alternativa3d::device.setBlendFactors(Context3DBlendFactor.SOURCE_ALPHA,Context3DBlendFactor.ONE_MINUS_SOURCE_ALPHA);
            }
            local18 = local17 is Sprite3D;
            if(local18) {
              local20 = 0;
              local21 = Sprite3D(local17);
              local22 = local16;
              while(local22.alternativa3d::processNext != null) {
                local22.alternativa3d::distance = local20;
                local22 = local22.alternativa3d::processNext;
              }
              local22.alternativa3d::distance = local20;
              this.transparentBatchObjects[local20] = local17;
              local20++;
              local13 = local1 - 1;
              while(local13 >= 0) {
                local23 = this.transparentFaceLists[local13];
                if(local16.material != local23.material) {
                  break;
                }
                local24 = this.transparentObjects[local13];
                if(!(local24 is Sprite3D)) {
                  break;
                }
                local25 = Sprite3D(local24);
                if(local21.useLight != local25.useLight || local21.useShadowMap != local25.useShadowMap || Boolean(local21.alternativa3d::lighted) || Boolean(local25.alternativa3d::lighted) || local21.softAttenuation != local25.softAttenuation || local21.alternativa3d::concatenatedAlpha != local25.alternativa3d::concatenatedAlpha || local21.alternativa3d::concatenatedColorTransform != null || local25.alternativa3d::concatenatedColorTransform != null || local21.alternativa3d::concatenatedBlendMode != local25.alternativa3d::concatenatedBlendMode) {
                  break;
                }
                local22.alternativa3d::processNext = local23;
                local22 = local23;
                while(local22.alternativa3d::processNext != null) {
                  local22.alternativa3d::distance = local20;
                  local22 = local22.alternativa3d::processNext;
                }
                local22.alternativa3d::distance = local20;
                this.transparentBatchObjects[local20] = local24;
                local20++;
                local1--;
                local13--;
              }
            }
            local19 = local18 && !Sprite3D(local17).depthTest;
            if(local19) {
              this.alternativa3d::device.setDepthTest(false,Context3DCompareMode.ALWAYS);
            }
            this.drawTransparentList(local16,local17,local18);
            if(local19) {
              this.alternativa3d::device.setDepthTest(false,Context3DCompareMode.LESS);
            }
            local1--;
          }
          this.alternativa3d::device.setTextureAt(0,null);
          this.alternativa3d::device.setTextureAt(1,null);
          this.alternativa3d::device.setTextureAt(2,null);
          this.alternativa3d::device.setTextureAt(3,null);
          this.alternativa3d::device.setTextureAt(5,null);
          this.alternativa3d::device.setTextureAt(6,null);
          this.alternativa3d::device.setTextureAt(7,null);
          this.alternativa3d::device.setVertexBufferAt(1,null);
          this.alternativa3d::device.setVertexBufferAt(2,null);
          this.alternativa3d::device.setVertexBufferAt(3,null);
          this.alternativa3d::device.setVertexBufferAt(4,null);
          this.alternativa3d::device.setVertexBufferAt(5,null);
          this.alternativa3d::device.setVertexBufferAt(6,null);
          this.alternativa3d::device.setVertexBufferAt(7,null);
          this.opaqueMaterials.length = 0;
          this.opaqueVertexBuffers.length = 0;
          this.opaqueIndexBuffers.length = 0;
          this.opaqueFirstIndexes.length = 0;
          this.opaqueNumsTriangles.length = 0;
          this.opaqueObjects.length = 0;
          this.opaqueCount = 0;
          this.skyMaterials.length = 0;
          this.skyVertexBuffers.length = 0;
          this.skyIndexBuffers.length = 0;
          this.skyFirstIndexes.length = 0;
          this.skyNumsTriangles.length = 0;
          this.skyObjects.length = 0;
          this.skyCount = 0;
          this.transparentFaceLists.length = 0;
          this.transparentObjects.length = 0;
          this.transparentCount = 0;
          this.transparentOpaqueFaceLists.length = 0;
          this.transparentOpaqueObjects.length = 0;
          this.transparentOpaqueCount = 0;
          this.transparentBatchObjects.length = 0;
          this.decals.length = 0;
          this.decalsCount = 0;
          this.alternativa3d::depthObjects.length = 0;
          this.alternativa3d::depthCount = 0;
          this.alternativa3d::casterObjects.length = 0;
          this.alternativa3d::casterCount = 0;
          this.alternativa3d::omnies.length = 0;
          this.alternativa3d::omniesCount = 0;
          this.alternativa3d::spots.length = 0;
          this.alternativa3d::spotsCount = 0;
          this.alternativa3d::tubes.length = 0;
          this.alternativa3d::tubesCount = 0;
          for each(local7 in this.alternativa3d::shadowAtlases) {
            if(local7.alternativa3d::shadowsCount > 0) {
              local7.alternativa3d::clear();
            }
          }
          this.alternativa3d::receiversVertexBuffers = null;
          this.alternativa3d::receiversIndexBuffers = null;
          this.alternativa3d::deferredDestroy();
          this.alternativa3d::clearOccluders();
          this.view.alternativa3d::onRender(this);
          if(this.onRender != null) {
            this.onRender();
          }
          this.view.alternativa3d::present();
        } else {
          this.view.alternativa3d::clearArea();
          if(this.onRender != null) {
            this.onRender();
          }
          this.view.alternativa3d::present();
        }
        this.alternativa3d::device = null;
      }
    }

    private function drawTransparentList(param1:Face, param2:Object3D, param3:Boolean) : void {
      var local4:Vertex = null;
      var local5:Vertex = null;
      var local6:Vertex = null;
      var local7:Wrapper = null;
      var local8:Face = null;
      var local12:int = 0;
      var local13:Object3D = null;
      var local9:int = 0;
      var local10:int = 0;
      var local11:Material = param1.material;
      while(param1 != null) {
        local8 = param1.alternativa3d::processNext;
        param1.alternativa3d::processNext = null;
        local7 = param1.alternativa3d::wrapper;
        local4 = local7.alternativa3d::vertex;
        local7 = local7.alternativa3d::next;
        local5 = local7.alternativa3d::vertex;
        if(param3) {
          local12 = int(param1.alternativa3d::distance);
          local13 = this.transparentBatchObjects[local12];
          local7 = local7.alternativa3d::next;
          while(local7 != null) {
            if(local10 == constantsMaxTriangles) {
              if(local11 != null) {
                this.alternativa3d::device.setProgramConstantsFromVector(Context3DProgramType.VERTEX,constantsOffset,constants,local10 * 6,false);
                local11.alternativa3d::drawTransparent(this,constantsVertexBuffer,constantsIndexBuffer,0,local10,param2,true);
              }
              local10 = 0;
              local9 = 0;
            }
            local6 = local7.alternativa3d::vertex;
            constants[local9] = local4.alternativa3d::cameraX;
            local9++;
            constants[local9] = local4.alternativa3d::cameraY;
            local9++;
            constants[local9] = local4.alternativa3d::cameraZ;
            local9++;
            constants[local9] = -local13.alternativa3d::md;
            local9++;
            constants[local9] = local4.u;
            local9++;
            constants[local9] = local4.v;
            local9++;
            constants[local9] = -local13.alternativa3d::mh;
            local9++;
            constants[local9] = -local13.alternativa3d::ml;
            local9++;
            constants[local9] = local5.alternativa3d::cameraX;
            local9++;
            constants[local9] = local5.alternativa3d::cameraY;
            local9++;
            constants[local9] = local5.alternativa3d::cameraZ;
            local9++;
            constants[local9] = -local13.alternativa3d::md;
            local9++;
            constants[local9] = local5.u;
            local9++;
            constants[local9] = local5.v;
            local9++;
            constants[local9] = -local13.alternativa3d::mh;
            local9++;
            constants[local9] = -local13.alternativa3d::ml;
            local9++;
            constants[local9] = local6.alternativa3d::cameraX;
            local9++;
            constants[local9] = local6.alternativa3d::cameraY;
            local9++;
            constants[local9] = local6.alternativa3d::cameraZ;
            local9++;
            constants[local9] = -local13.alternativa3d::md;
            local9++;
            constants[local9] = local6.u;
            local9++;
            constants[local9] = local6.v;
            local9++;
            constants[local9] = -local13.alternativa3d::mh;
            local9++;
            constants[local9] = -local13.alternativa3d::ml;
            local9++;
            local10++;
            local5 = local6;
            local7 = local7.alternativa3d::next;
          }
        } else {
          local7 = local7.alternativa3d::next;
          while(local7 != null) {
            if(local10 == constantsMaxTriangles) {
              if(local11 != null) {
                this.alternativa3d::device.setProgramConstantsFromVector(Context3DProgramType.VERTEX,constantsOffset,constants,local10 * 6,false);
                local11.alternativa3d::drawTransparent(this,constantsVertexBuffer,constantsIndexBuffer,0,local10,param2,true);
              }
              local10 = 0;
              local9 = 0;
            }
            local6 = local7.alternativa3d::vertex;
            constants[local9] = local4.alternativa3d::cameraX;
            local9++;
            constants[local9] = local4.alternativa3d::cameraY;
            local9++;
            constants[local9] = local4.alternativa3d::cameraZ;
            local9++;
            constants[local9] = local4.normalX;
            local9++;
            constants[local9] = local4.u;
            local9++;
            constants[local9] = local4.v;
            local9++;
            constants[local9] = local4.normalY;
            local9++;
            constants[local9] = local4.normalZ;
            local9++;
            constants[local9] = local5.alternativa3d::cameraX;
            local9++;
            constants[local9] = local5.alternativa3d::cameraY;
            local9++;
            constants[local9] = local5.alternativa3d::cameraZ;
            local9++;
            constants[local9] = local5.normalX;
            local9++;
            constants[local9] = local5.u;
            local9++;
            constants[local9] = local5.v;
            local9++;
            constants[local9] = local5.normalY;
            local9++;
            constants[local9] = local5.normalZ;
            local9++;
            constants[local9] = local6.alternativa3d::cameraX;
            local9++;
            constants[local9] = local6.alternativa3d::cameraY;
            local9++;
            constants[local9] = local6.alternativa3d::cameraZ;
            local9++;
            constants[local9] = local6.normalX;
            local9++;
            constants[local9] = local6.u;
            local9++;
            constants[local9] = local6.v;
            local9++;
            constants[local9] = local6.normalY;
            local9++;
            constants[local9] = local6.normalZ;
            local9++;
            local10++;
            local5 = local6;
            local7 = local7.alternativa3d::next;
          }
        }
        param1 = local8;
      }
      if(local10 > 0 && local11 != null) {
        this.alternativa3d::device.setProgramConstantsFromVector(Context3DProgramType.VERTEX,constantsOffset,constants,local10 * 6,false);
        local11.alternativa3d::drawTransparent(this,constantsVertexBuffer,constantsIndexBuffer,0,local10,param2,true);
      }
    }

    public function lookAt(param1:Number, param2:Number, param3:Number) : void {
      var local4:Number = param1 - this.x;
      var local5:Number = param2 - this.y;
      var local6:Number = param3 - this.z;
      rotationX = Math.atan2(local6,Math.sqrt(local4 * local4 + local5 * local5)) - Math.PI / 2;
      rotationY = 0;
      rotationZ = -Math.atan2(local4,local5);
    }

    public function projectGlobal(param1:Vector3D) : Vector3D {
      if(this.view == null) {
        throw new Error("It is necessary to have view set.");
      }
      this.alternativa3d::viewSizeX = this.view.alternativa3d::_width * 0.5;
      this.alternativa3d::viewSizeY = this.view.alternativa3d::_height * 0.5;
      this.alternativa3d::focalLength = Math.sqrt(this.alternativa3d::viewSizeX * this.alternativa3d::viewSizeX + this.alternativa3d::viewSizeY * this.alternativa3d::viewSizeY) / Math.tan(this.fov * 0.5);
      this.alternativa3d::composeCameraMatrix();
      var local2:Object3D = this;
      while(local2.alternativa3d::_parent != null) {
        local2 = local2.alternativa3d::_parent;
        alternativa3d::tA.alternativa3d::composeMatrixFromSource(local2);
        alternativa3d::appendMatrix(alternativa3d::tA);
      }
      alternativa3d::invertMatrix();
      var local3:Vector3D = new Vector3D();
      local3.x = alternativa3d::ma * param1.x + alternativa3d::mb * param1.y + alternativa3d::mc * param1.z + alternativa3d::md;
      local3.y = alternativa3d::me * param1.x + alternativa3d::mf * param1.y + alternativa3d::mg * param1.z + alternativa3d::mh;
      local3.z = alternativa3d::mi * param1.x + alternativa3d::mj * param1.y + alternativa3d::mk * param1.z + alternativa3d::ml;
      local3.x = local3.x * this.alternativa3d::viewSizeX / local3.z + this.alternativa3d::viewSizeX;
      local3.y = local3.y * this.alternativa3d::viewSizeY / local3.z + this.alternativa3d::viewSizeY;
      return local3;
    }

    public function calculateRay(param1:Vector3D, param2:Vector3D, param3:Number, param4:Number) : void {
      if(this.view == null) {
        throw new Error("It is necessary to have view set.");
      }
      this.alternativa3d::viewSizeX = this.view.alternativa3d::_width * 0.5;
      this.alternativa3d::viewSizeY = this.view.alternativa3d::_height * 0.5;
      this.alternativa3d::focalLength = Math.sqrt(this.alternativa3d::viewSizeX * this.alternativa3d::viewSizeX + this.alternativa3d::viewSizeY * this.alternativa3d::viewSizeY) / Math.tan(this.fov * 0.5);
      param3 -= this.alternativa3d::viewSizeX;
      param4 -= this.alternativa3d::viewSizeY;
      var local5:Number = param3 * this.alternativa3d::focalLength / this.alternativa3d::viewSizeX;
      var local6:Number = param4 * this.alternativa3d::focalLength / this.alternativa3d::viewSizeY;
      var local7:Number = this.alternativa3d::focalLength;
      var local8:Number = local5 * this.nearClipping / this.alternativa3d::focalLength;
      var local9:Number = local6 * this.nearClipping / this.alternativa3d::focalLength;
      var local10:Number = this.nearClipping;
      this.alternativa3d::composeCameraMatrix();
      var local11:Object3D = this;
      while(local11.alternativa3d::_parent != null) {
        local11 = local11.alternativa3d::_parent;
        alternativa3d::tA.alternativa3d::composeMatrixFromSource(local11);
        alternativa3d::appendMatrix(alternativa3d::tA);
      }
      param1.x = alternativa3d::ma * local8 + alternativa3d::mb * local9 + alternativa3d::mc * local10 + alternativa3d::md;
      param1.y = alternativa3d::me * local8 + alternativa3d::mf * local9 + alternativa3d::mg * local10 + alternativa3d::mh;
      param1.z = alternativa3d::mi * local8 + alternativa3d::mj * local9 + alternativa3d::mk * local10 + alternativa3d::ml;
      param2.x = alternativa3d::ma * local5 + alternativa3d::mb * local6 + alternativa3d::mc * local7;
      param2.y = alternativa3d::me * local5 + alternativa3d::mf * local6 + alternativa3d::mg * local7;
      param2.z = alternativa3d::mi * local5 + alternativa3d::mj * local6 + alternativa3d::mk * local7;
      var local12:Number = 1 / Math.sqrt(param2.x * param2.x + param2.y * param2.y + param2.z * param2.z);
      param2.x *= local12;
      param2.y *= local12;
      param2.z *= local12;
    }

    override public function clone() : Object3D {
      var local1:Camera3D = new Camera3D();
      local1.clonePropertiesFrom(this);
      return local1;
    }

    override protected function clonePropertiesFrom(param1:Object3D) : void {
      var local3:* = undefined;
      super.clonePropertiesFrom(param1);
      var local2:Camera3D = param1 as Camera3D;
      this.fov = local2.fov;
      this.nearClipping = local2.nearClipping;
      this.farClipping = local2.farClipping;
      this.debug = local2.debug;
      this.fogNear = local2.fogNear;
      this.fogFar = local2.fogFar;
      this.fogAlpha = local2.fogAlpha;
      this.fogColor = local2.fogColor;
      this.softTransparency = local2.softTransparency;
      this.depthBufferScale = local2.depthBufferScale;
      this.ssao = local2.ssao;
      this.ssaoRadius = local2.ssaoRadius;
      this.ssaoRange = local2.ssaoRange;
      this.ssaoColor = local2.ssaoColor;
      this.ssaoAlpha = local2.ssaoAlpha;
      this.directionalLight = local2.directionalLight;
      this.shadowMap = local2.shadowMap;
      this.ambientColor = local2.ambientColor;
      this.deferredLighting = local2.deferredLighting;
      this.fogStrength = local2.fogStrength;
      this.softTransparencyStrength = local2.softTransparencyStrength;
      this.ssaoStrength = local2.ssaoStrength;
      this.directionalLightStrength = local2.directionalLightStrength;
      this.shadowMapStrength = local2.shadowMapStrength;
      this.shadowsStrength = local2.shadowsStrength;
      this.shadowsDistanceMultiplier = local2.shadowsDistanceMultiplier;
      this.deferredLightingStrength = local2.deferredLightingStrength;
      for(local3 in local2.shadows) {
        this.shadows[local3] = true;
      }
    }

    alternativa3d function addOpaque(param1:Material, param2:VertexBufferResource, param3:IndexBufferResource, param4:int, param5:int, param6:Object3D) : void {
      this.opaqueMaterials[this.opaqueCount] = param1;
      this.opaqueVertexBuffers[this.opaqueCount] = param2;
      this.opaqueIndexBuffers[this.opaqueCount] = param3;
      this.opaqueFirstIndexes[this.opaqueCount] = param4;
      this.opaqueNumsTriangles[this.opaqueCount] = param5;
      this.opaqueObjects[this.opaqueCount] = param6;
      ++this.opaqueCount;
    }

    alternativa3d function addSky(param1:Material, param2:VertexBufferResource, param3:IndexBufferResource, param4:int, param5:int, param6:Object3D) : void {
      this.skyMaterials[this.skyCount] = param1;
      this.skyVertexBuffers[this.skyCount] = param2;
      this.skyIndexBuffers[this.skyCount] = param3;
      this.skyFirstIndexes[this.skyCount] = param4;
      this.skyNumsTriangles[this.skyCount] = param5;
      this.skyObjects[this.skyCount] = param6;
      ++this.skyCount;
    }

    alternativa3d function addTransparent(param1:Face, param2:Object3D) : void {
      this.transparentFaceLists[this.transparentCount] = param1;
      this.transparentObjects[this.transparentCount] = param2;
      ++this.transparentCount;
    }

    alternativa3d function addTransparentOpaque(param1:Face, param2:Object3D) : void {
      this.transparentOpaqueFaceLists[this.transparentOpaqueCount] = param1;
      this.transparentOpaqueObjects[this.transparentOpaqueCount] = param2;
      ++this.transparentOpaqueCount;
    }

    alternativa3d function addDecal(param1:Decal) : void {
      this.decals[this.decalsCount] = param1;
      ++this.decalsCount;
    }

    alternativa3d function composeCameraMatrix() : void {
      var local1:Number = this.alternativa3d::viewSizeX / this.alternativa3d::focalLength;
      var local2:Number = this.alternativa3d::viewSizeY / this.alternativa3d::focalLength;
      var local3:Number = Math.cos(rotationX);
      var local4:Number = Math.sin(rotationX);
      var local5:Number = Math.cos(rotationY);
      var local6:Number = Math.sin(rotationY);
      var local7:Number = Math.cos(rotationZ);
      var local8:Number = Math.sin(rotationZ);
      var local9:Number = local7 * local6;
      var local10:Number = local8 * local6;
      var local11:Number = local5 * scaleX;
      var local12:Number = local4 * scaleY;
      var local13:Number = local3 * scaleY;
      var local14:Number = local3 * scaleZ;
      var local15:Number = local4 * scaleZ;
      alternativa3d::ma = local7 * local11 * local1;
      alternativa3d::mb = (local9 * local12 - local8 * local13) * local2;
      alternativa3d::mc = local9 * local14 + local8 * local15;
      alternativa3d::md = x;
      alternativa3d::me = local8 * local11 * local1;
      alternativa3d::mf = (local10 * local12 + local7 * local13) * local2;
      alternativa3d::mg = local10 * local14 - local7 * local15;
      alternativa3d::mh = y;
      alternativa3d::mi = -local6 * scaleX * local1;
      alternativa3d::mj = local5 * local12 * local2;
      alternativa3d::mk = local5 * local14;
      alternativa3d::ml = z;
      var local16:Number = this.view.offsetX / this.alternativa3d::viewSizeX;
      var local17:Number = this.view.offsetY / this.alternativa3d::viewSizeY;
      alternativa3d::mc -= alternativa3d::ma * local16 + alternativa3d::mb * local17;
      alternativa3d::mg -= alternativa3d::me * local16 + alternativa3d::mf * local17;
      alternativa3d::mk -= alternativa3d::mi * local16 + alternativa3d::mj * local17;
    }

    public function addToDebug(param1:int, param2:*) : void {
      if(!this.debugSet[param1]) {
        this.debugSet[param1] = new Dictionary();
      }
      this.debugSet[param1][param2] = true;
    }

    public function removeFromDebug(param1:int, param2:*) : void {
      var local3:* = undefined;
      if(Boolean(this.debugSet[param1])) {
        delete this.debugSet[param1][param2];
        var local4:int = 0;
        var local5:* = this.debugSet[param1];
        for(local3 in local5) {
        }
        if(!local3) {
          delete this.debugSet[param1];
        }
      }
    }

    alternativa3d function checkInDebug(param1:Object3D) : int {
      var local4:Class = null;
      var local2:int = 0;
      var local3:int = 1;
      while(local3 <= 512) {
        if(Boolean(this.debugSet[local3])) {
          if(Boolean(this.debugSet[local3][Object3D]) || Boolean(this.debugSet[local3][param1])) {
            local2 |= local3;
          } else {
            local4 = getDefinitionByName(getQualifiedClassName(param1)) as Class;
            while(local4 != Object3D) {
              if(Boolean(this.debugSet[local3][local4])) {
                local2 |= local3;
                break;
              }
              local4 = Class(getDefinitionByName(getQualifiedSuperclassName(local4)));
            }
          }
        }
        local3 <<= 1;
      }
      return local2;
    }

    public function startTimer() : void {
      this.timer = getTimer();
    }

    public function stopTimer() : void {
      this.timeSum += getTimer() - this.timer;
      ++this.timeCount;
    }

    public function get diagram() : DisplayObject {
      return this._diagram;
    }

    public function get diagramAlign() : String {
      return this._diagramAlign;
    }

    public function set diagramAlign(param1:String) : void {
      this._diagramAlign = param1;
      this.resizeDiagram();
    }

    public function get diagramHorizontalMargin() : Number {
      return this._diagramHorizontalMargin;
    }

    public function set diagramHorizontalMargin(param1:Number) : void {
      this._diagramHorizontalMargin = param1;
      this.resizeDiagram();
    }

    public function get diagramVerticalMargin() : Number {
      return this._diagramVerticalMargin;
    }

    public function set diagramVerticalMargin(param1:Number) : void {
      this._diagramVerticalMargin = param1;
      this.resizeDiagram();
    }

    private function createDiagram() : Sprite {
      var diagram:Sprite = null;
      diagram = new Sprite();
      diagram.mouseEnabled = false;
      diagram.mouseChildren = false;
      diagram.addEventListener(Event.ADDED_TO_STAGE,function():void {
        while(diagram.numChildren > 0) {
          diagram.removeChildAt(0);
        }
        fpsTextField = new TextField();
        fpsTextField.defaultTextFormat = new TextFormat("Tahoma",10,13421772);
        fpsTextField.autoSize = TextFieldAutoSize.LEFT;
        fpsTextField.text = "FPS:";
        fpsTextField.selectable = false;
        fpsTextField.x = -3;
        fpsTextField.y = -5;
        diagram.addChild(fpsTextField);
        fpsTextField = new TextField();
        fpsTextField.defaultTextFormat = new TextFormat("Tahoma",10,13421772);
        fpsTextField.autoSize = TextFieldAutoSize.RIGHT;
        fpsTextField.text = Number(diagram.stage.frameRate).toFixed(2);
        fpsTextField.selectable = false;
        fpsTextField.x = -3;
        fpsTextField.y = -5;
        fpsTextField.width = 65;
        diagram.addChild(fpsTextField);
        timerTextField = new TextField();
        timerTextField.defaultTextFormat = new TextFormat("Tahoma",10,26367);
        timerTextField.autoSize = TextFieldAutoSize.LEFT;
        timerTextField.text = "MS:";
        timerTextField.selectable = false;
        timerTextField.x = -3;
        timerTextField.y = 4;
        diagram.addChild(timerTextField);
        timerTextField = new TextField();
        timerTextField.defaultTextFormat = new TextFormat("Tahoma",10,26367);
        timerTextField.autoSize = TextFieldAutoSize.RIGHT;
        timerTextField.text = "";
        timerTextField.selectable = false;
        timerTextField.x = -3;
        timerTextField.y = 4;
        timerTextField.width = 65;
        diagram.addChild(timerTextField);
        memoryTextField = new TextField();
        memoryTextField.defaultTextFormat = new TextFormat("Tahoma",10,13421568);
        memoryTextField.autoSize = TextFieldAutoSize.LEFT;
        memoryTextField.text = "MEM:";
        memoryTextField.selectable = false;
        memoryTextField.x = -3;
        memoryTextField.y = 13;
        diagram.addChild(memoryTextField);
        memoryTextField = new TextField();
        memoryTextField.defaultTextFormat = new TextFormat("Tahoma",10,13421568);
        memoryTextField.autoSize = TextFieldAutoSize.RIGHT;
        memoryTextField.text = bytesToString(System.totalMemory);
        memoryTextField.selectable = false;
        memoryTextField.x = -3;
        memoryTextField.y = 13;
        memoryTextField.width = 65;
        diagram.addChild(memoryTextField);
        drawsTextField = new TextField();
        drawsTextField.defaultTextFormat = new TextFormat("Tahoma",10,52224);
        drawsTextField.autoSize = TextFieldAutoSize.LEFT;
        drawsTextField.text = "DRW:";
        drawsTextField.selectable = false;
        drawsTextField.x = -3;
        drawsTextField.y = 22;
        diagram.addChild(drawsTextField);
        drawsTextField = new TextField();
        drawsTextField.defaultTextFormat = new TextFormat("Tahoma",10,52224);
        drawsTextField.autoSize = TextFieldAutoSize.RIGHT;
        drawsTextField.text = "0";
        drawsTextField.selectable = false;
        drawsTextField.x = -3;
        drawsTextField.y = 22;
        drawsTextField.width = 52;
        diagram.addChild(drawsTextField);
        shadowsTextField = new TextField();
        shadowsTextField.defaultTextFormat = new TextFormat("Tahoma",10,16711731);
        shadowsTextField.autoSize = TextFieldAutoSize.LEFT;
        shadowsTextField.text = "SHD:";
        shadowsTextField.selectable = false;
        shadowsTextField.x = -3;
        shadowsTextField.y = 31;
        diagram.addChild(shadowsTextField);
        shadowsTextField = new TextField();
        shadowsTextField.defaultTextFormat = new TextFormat("Tahoma",10,16711731);
        shadowsTextField.autoSize = TextFieldAutoSize.RIGHT;
        shadowsTextField.text = "0";
        shadowsTextField.selectable = false;
        shadowsTextField.x = -3;
        shadowsTextField.y = 31;
        shadowsTextField.width = 52;
        diagram.addChild(shadowsTextField);
        trianglesTextField = new TextField();
        trianglesTextField.defaultTextFormat = new TextFormat("Tahoma",10,16737792);
        trianglesTextField.autoSize = TextFieldAutoSize.LEFT;
        trianglesTextField.text = "TRI:";
        trianglesTextField.selectable = false;
        trianglesTextField.x = -3;
        trianglesTextField.y = 40;
        diagram.addChild(trianglesTextField);
        trianglesTextField = new TextField();
        trianglesTextField.defaultTextFormat = new TextFormat("Tahoma",10,16737792);
        trianglesTextField.autoSize = TextFieldAutoSize.RIGHT;
        trianglesTextField.text = "0";
        trianglesTextField.selectable = false;
        trianglesTextField.x = -3;
        trianglesTextField.y = 40;
        trianglesTextField.width = 52;
        diagram.addChild(trianglesTextField);
        graph = new Bitmap(new BitmapData(60,40,true,553648127));
        rect = new Rectangle(0,0,1,40);
        graph.x = 0;
        graph.y = 54;
        diagram.addChild(graph);
        previousPeriodTime = getTimer();
        previousFrameTime = previousPeriodTime;
        fpsUpdateCounter = 0;
        maxMemory = 0;
        timerUpdateCounter = 0;
        timeSum = 0;
        timeCount = 0;
        diagram.stage.addEventListener(Event.ENTER_FRAME,updateDiagram,false,-1000);
        diagram.stage.addEventListener(Event.RESIZE,resizeDiagram,false,-1000);
        resizeDiagram();
      });
      diagram.addEventListener(Event.REMOVED_FROM_STAGE,function():void {
        while(diagram.numChildren > 0) {
          diagram.removeChildAt(0);
        }
        fpsTextField = null;
        memoryTextField = null;
        drawsTextField = null;
        shadowsTextField = null;
        trianglesTextField = null;
        timerTextField = null;
        graph.bitmapData.dispose();
        graph = null;
        rect = null;
        diagram.stage.removeEventListener(Event.ENTER_FRAME,updateDiagram);
        diagram.stage.removeEventListener(Event.RESIZE,resizeDiagram);
      });
      return diagram;
    }

    private function resizeDiagram(param1:Event = null) : void {
      var local2:Point = null;
      if(this._diagram.stage != null) {
        local2 = this._diagram.parent.globalToLocal(new Point());
        if(this._diagramAlign == StageAlign.TOP_LEFT || this._diagramAlign == StageAlign.LEFT || this._diagramAlign == StageAlign.BOTTOM_LEFT) {
          this._diagram.x = Math.round(local2.x + this._diagramHorizontalMargin);
        }
        if(this._diagramAlign == StageAlign.TOP || this._diagramAlign == StageAlign.BOTTOM) {
          this._diagram.x = Math.round(local2.x + this._diagram.stage.stageWidth / 2 - this.graph.width / 2);
        }
        if(this._diagramAlign == StageAlign.TOP_RIGHT || this._diagramAlign == StageAlign.RIGHT || this._diagramAlign == StageAlign.BOTTOM_RIGHT) {
          this._diagram.x = Math.round(local2.x + this._diagram.stage.stageWidth - this._diagramHorizontalMargin - this.graph.width);
        }
        if(this._diagramAlign == StageAlign.TOP_LEFT || this._diagramAlign == StageAlign.TOP || this._diagramAlign == StageAlign.TOP_RIGHT) {
          this._diagram.y = Math.round(local2.y + this._diagramVerticalMargin);
        }
        if(this._diagramAlign == StageAlign.LEFT || this._diagramAlign == StageAlign.RIGHT) {
          this._diagram.y = Math.round(local2.y + this._diagram.stage.stageHeight / 2 - (this.graph.y + this.graph.height) / 2);
        }
        if(this._diagramAlign == StageAlign.BOTTOM_LEFT || this._diagramAlign == StageAlign.BOTTOM || this._diagramAlign == StageAlign.BOTTOM_RIGHT) {
          this._diagram.y = Math.round(local2.y + this._diagram.stage.stageHeight - this._diagramVerticalMargin - this.graph.y - this.graph.height);
        }
      }
    }

    private function updateDiagram(param1:Event) : void {
      var local2:Number = NaN;
      var local3:int = 0;
      var local4:String = null;
      var local5:int = getTimer();
      var local6:int = this._diagram.stage.frameRate;
      if(++this.fpsUpdateCounter == this.fpsUpdatePeriod) {
        local2 = 1000 * this.fpsUpdatePeriod / (local5 - this.previousPeriodTime);
        if(local2 > local6) {
          local2 = local6;
        }
        local3 = local2 * 100 % 100;
        local4 = local3 >= 10 ? String(local3) : (local3 > 0 ? "0" + String(local3) : "00");
        this.fpsTextField.text = int(local2) + "." + local4;
        this.previousPeriodTime = local5;
        this.fpsUpdateCounter = 0;
      }
      local2 = 1000 / (local5 - this.previousFrameTime);
      if(local2 > local6) {
        local2 = local6;
      }
      this.graph.bitmapData.scroll(1,0);
      this.graph.bitmapData.fillRect(this.rect,553648127);
      this.graph.bitmapData.setPixel32(0,40 * (1 - local2 / local6),4291611852);
      this.previousFrameTime = local5;
      if(++this.timerUpdateCounter == this.timerUpdatePeriod) {
        if(this.timeCount > 0) {
          local2 = this.timeSum / this.timeCount;
          local3 = local2 * 100 % 100;
          local4 = local3 >= 10 ? String(local3) : (local3 > 0 ? "0" + String(local3) : "00");
          this.timerTextField.text = int(local2) + "." + local4;
        } else {
          this.timerTextField.text = "";
        }
        this.timerUpdateCounter = 0;
        this.timeSum = 0;
        this.timeCount = 0;
      }
      var local7:int = int(System.totalMemory);
      local2 = local7 / 1048576;
      local3 = local2 * 100 % 100;
      local4 = local3 >= 10 ? String(local3) : (local3 > 0 ? "0" + String(local3) : "00");
      this.memoryTextField.text = int(local2) + "." + local4;
      if(local7 > this.maxMemory) {
        this.maxMemory = local7;
      }
      this.graph.bitmapData.setPixel32(0,40 * (1 - local7 / this.maxMemory),4291611648);
      this.drawsTextField.text = String(this.alternativa3d::numDraws);
      this.shadowsTextField.text = String(this.alternativa3d::numShadows);
      this.trianglesTextField.text = String(this.alternativa3d::numTriangles);
    }

    private function bytesToString(param1:int) : String {
      if(param1 < 1024) {
        return param1 + "b";
      }
      if(param1 < 10240) {
        return (param1 / 1024).toFixed(2) + "kb";
      }
      if(param1 < 102400) {
        return (param1 / 1024).toFixed(1) + "kb";
      }
      if(param1 < 1048576) {
        return (param1 >> 10) + "kb";
      }
      if(param1 < 10485760) {
        return (param1 / 1048576).toFixed(2);
      }
      if(param1 < 104857600) {
        return (param1 / 1048576).toFixed(1);
      }
      return String(param1 >> 20);
    }

    alternativa3d function deferredDestroy() : void {
      var local2:Wrapper = null;
      var local3:Wrapper = null;
      var local1:Face = this.firstFace.alternativa3d::next;
      while(local1 != null) {
        local2 = local1.alternativa3d::wrapper;
        if(local2 != null) {
          local3 = null;
          while(local2 != null) {
            local2.alternativa3d::vertex = null;
            local3 = local2;
            local2 = local2.alternativa3d::next;
          }
          this.alternativa3d::lastWrapper.alternativa3d::next = local1.alternativa3d::wrapper;
          this.alternativa3d::lastWrapper = local3;
        }
        local1.material = null;
        local1.alternativa3d::wrapper = null;
        local1 = local1.alternativa3d::next;
      }
      if(this.firstFace != this.alternativa3d::lastFace) {
        this.alternativa3d::lastFace.alternativa3d::next = Face.alternativa3d::collector;
        Face.alternativa3d::collector = this.firstFace.alternativa3d::next;
        this.firstFace.alternativa3d::next = null;
        this.alternativa3d::lastFace = this.firstFace;
      }
      if(this.firstWrapper != this.alternativa3d::lastWrapper) {
        this.alternativa3d::lastWrapper.alternativa3d::next = Wrapper.alternativa3d::collector;
        Wrapper.alternativa3d::collector = this.firstWrapper.alternativa3d::next;
        this.firstWrapper.alternativa3d::next = null;
        this.alternativa3d::lastWrapper = this.firstWrapper;
      }
      if(this.firstVertex != this.alternativa3d::lastVertex) {
        this.alternativa3d::lastVertex.alternativa3d::next = Vertex.alternativa3d::collector;
        Vertex.alternativa3d::collector = this.firstVertex.alternativa3d::next;
        this.firstVertex.alternativa3d::next = null;
        this.alternativa3d::lastVertex = this.firstVertex;
      }
    }

    alternativa3d function clearOccluders() : void {
      var local2:Vertex = null;
      var local3:Vertex = null;
      var local1:int = 0;
      while(local1 < this.alternativa3d::numOccluders) {
        local2 = this.alternativa3d::occluders[local1];
        local3 = local2;
        while(local3.alternativa3d::next != null) {
          local3 = local3.alternativa3d::next;
        }
        local3.alternativa3d::next = Vertex.alternativa3d::collector;
        Vertex.alternativa3d::collector = local2;
        this.alternativa3d::occluders[local1] = null;
        local1++;
      }
      this.alternativa3d::numOccluders = 0;
    }

    alternativa3d function sortByAverageZ(param1:Face) : Face {
      var local2:int = 0;
      var local3:Number = NaN;
      var local4:Wrapper = null;
      var local5:Face = param1;
      var local6:Face = param1.alternativa3d::processNext;
      while(local6 != null && local6.alternativa3d::processNext != null) {
        param1 = param1.alternativa3d::processNext;
        local6 = local6.alternativa3d::processNext.alternativa3d::processNext;
      }
      local6 = param1.alternativa3d::processNext;
      param1.alternativa3d::processNext = null;
      if(local5.alternativa3d::processNext != null) {
        local5 = this.alternativa3d::sortByAverageZ(local5);
      } else {
        local2 = 0;
        local3 = 0;
        local4 = local5.alternativa3d::wrapper;
        while(local4 != null) {
          local2++;
          local3 += local4.alternativa3d::vertex.alternativa3d::cameraZ;
          local4 = local4.alternativa3d::next;
        }
        local5.alternativa3d::distance = local3 / local2;
      }
      if(local6.alternativa3d::processNext != null) {
        local6 = this.alternativa3d::sortByAverageZ(local6);
      } else {
        local2 = 0;
        local3 = 0;
        local4 = local6.alternativa3d::wrapper;
        while(local4 != null) {
          local2++;
          local3 += local4.alternativa3d::vertex.alternativa3d::cameraZ;
          local4 = local4.alternativa3d::next;
        }
        local6.alternativa3d::distance = local3 / local2;
      }
      var local7:Boolean = local5.alternativa3d::distance > local6.alternativa3d::distance;
      if(local7) {
        param1 = local5;
        local5 = local5.alternativa3d::processNext;
      } else {
        param1 = local6;
        local6 = local6.alternativa3d::processNext;
      }
      var local8:Face = param1;
      while(true) {
        if(local5 == null) {
          local8.alternativa3d::processNext = local6;
          return param1;
        }
        if(local6 == null) {
          local8.alternativa3d::processNext = local5;
          return param1;
        }
        if(local7) {
          if(local5.alternativa3d::distance > local6.alternativa3d::distance) {
            local8 = local5;
            local5 = local5.alternativa3d::processNext;
          } else {
            local8.alternativa3d::processNext = local6;
            local8 = local6;
            local6 = local6.alternativa3d::processNext;
            local7 = false;
          }
        } else if(local6.alternativa3d::distance > local5.alternativa3d::distance) {
          local8 = local6;
          local6 = local6.alternativa3d::processNext;
        } else {
          local8.alternativa3d::processNext = local5;
          local8 = local5;
          local5 = local5.alternativa3d::processNext;
          local7 = true;
        }
      }
      return null;
    }

    alternativa3d function sortByDynamicBSP(param1:Face, param2:Number, param3:Face = null) : Face {
      var local4:Wrapper = null;
      var local5:Vertex = null;
      var local6:Vertex = null;
      var local7:Vertex = null;
      var local8:Vertex = null;
      var local23:Face = null;
      var local24:Face = null;
      var local26:Face = null;
      var local27:Face = null;
      var local28:Face = null;
      var local30:Number = NaN;
      var local31:Number = NaN;
      var local32:Number = NaN;
      var local33:Number = NaN;
      var local34:Number = NaN;
      var local35:Number = NaN;
      var local36:Number = NaN;
      var local37:Number = NaN;
      var local38:Number = NaN;
      var local39:Number = NaN;
      var local40:Boolean = false;
      var local41:Boolean = false;
      var local42:Number = NaN;
      var local43:Face = null;
      var local44:Face = null;
      var local45:Wrapper = null;
      var local46:Wrapper = null;
      var local47:Wrapper = null;
      var local48:Boolean = false;
      var local49:Number = NaN;
      var local9:Face = param1;
      param1 = local9.alternativa3d::processNext;
      local4 = local9.alternativa3d::wrapper;
      local5 = local4.alternativa3d::vertex;
      local4 = local4.alternativa3d::next;
      local6 = local4.alternativa3d::vertex;
      var local10:Number = Number(local5.alternativa3d::cameraX);
      var local11:Number = Number(local5.alternativa3d::cameraY);
      var local12:Number = Number(local5.alternativa3d::cameraZ);
      var local13:Number = local6.alternativa3d::cameraX - local10;
      var local14:Number = local6.alternativa3d::cameraY - local11;
      var local15:Number = local6.alternativa3d::cameraZ - local12;
      var local16:Number = 0;
      var local17:Number = 0;
      var local18:Number = 1;
      var local19:Number = local12;
      var local20:Number = 0;
      local4 = local4.alternativa3d::next;
      while(local4 != null) {
        local8 = local4.alternativa3d::vertex;
        local30 = local8.alternativa3d::cameraX - local10;
        local31 = local8.alternativa3d::cameraY - local11;
        local32 = local8.alternativa3d::cameraZ - local12;
        local33 = local32 * local14 - local31 * local15;
        local34 = local30 * local15 - local32 * local13;
        local35 = local31 * local13 - local30 * local14;
        local36 = local33 * local33 + local34 * local34 + local35 * local35;
        if(local36 > param2) {
          local36 = 1 / Math.sqrt(local36);
          local16 = local33 * local36;
          local17 = local34 * local36;
          local18 = local35 * local36;
          local19 = local10 * local16 + local11 * local17 + local12 * local18;
          break;
        }
        if(local36 > local20) {
          local36 = 1 / Math.sqrt(local36);
          local16 = local33 * local36;
          local17 = local34 * local36;
          local18 = local35 * local36;
          local19 = local10 * local16 + local11 * local17 + local12 * local18;
          local20 = local36;
        }
        local4 = local4.alternativa3d::next;
      }
      var local21:Number = local19 - param2;
      var local22:Number = local19 + param2;
      var local25:Face = local9;
      var local29:Face = param1;
      while(local29 != null) {
        local28 = local29.alternativa3d::processNext;
        local4 = local29.alternativa3d::wrapper;
        local5 = local4.alternativa3d::vertex;
        local4 = local4.alternativa3d::next;
        local6 = local4.alternativa3d::vertex;
        local4 = local4.alternativa3d::next;
        local7 = local4.alternativa3d::vertex;
        local4 = local4.alternativa3d::next;
        local37 = local5.alternativa3d::cameraX * local16 + local5.alternativa3d::cameraY * local17 + local5.alternativa3d::cameraZ * local18;
        local38 = local6.alternativa3d::cameraX * local16 + local6.alternativa3d::cameraY * local17 + local6.alternativa3d::cameraZ * local18;
        local39 = local7.alternativa3d::cameraX * local16 + local7.alternativa3d::cameraY * local17 + local7.alternativa3d::cameraZ * local18;
        local40 = local37 < local21 || local38 < local21 || local39 < local21;
        local41 = local37 > local22 || local38 > local22 || local39 > local22;
        while(local4 != null) {
          local8 = local4.alternativa3d::vertex;
          local42 = local8.alternativa3d::cameraX * local16 + local8.alternativa3d::cameraY * local17 + local8.alternativa3d::cameraZ * local18;
          if(local42 < local21) {
            local40 = true;
          } else if(local42 > local22) {
            local41 = true;
          }
          local8.alternativa3d::offset = local42;
          local4 = local4.alternativa3d::next;
        }
        if(!local40) {
          if(!local41) {
            local25.alternativa3d::processNext = local29;
            local25 = local29;
          } else {
            if(local26 != null) {
              local27.alternativa3d::processNext = local29;
            } else {
              local26 = local29;
            }
            local27 = local29;
          }
        } else if(!local41) {
          if(local23 != null) {
            local24.alternativa3d::processNext = local29;
          } else {
            local23 = local29;
          }
          local24 = local29;
        } else {
          local5.alternativa3d::offset = local37;
          local6.alternativa3d::offset = local38;
          local7.alternativa3d::offset = local39;
          local43 = local29.alternativa3d::create();
          local43.material = local29.material;
          this.alternativa3d::lastFace.alternativa3d::next = local43;
          this.alternativa3d::lastFace = local43;
          local44 = local29.alternativa3d::create();
          local44.material = local29.material;
          this.alternativa3d::lastFace.alternativa3d::next = local44;
          this.alternativa3d::lastFace = local44;
          local45 = null;
          local46 = null;
          local4 = local29.alternativa3d::wrapper.alternativa3d::next.alternativa3d::next;
          while(local4.alternativa3d::next != null) {
            local4 = local4.alternativa3d::next;
          }
          local5 = local4.alternativa3d::vertex;
          local37 = Number(local5.alternativa3d::offset);
          local48 = local29.material != null && Boolean(local29.material.alternativa3d::useVerticesNormals);
          local4 = local29.alternativa3d::wrapper;
          while(local4 != null) {
            local6 = local4.alternativa3d::vertex;
            local38 = Number(local6.alternativa3d::offset);
            if(local37 < local21 && local38 > local22 || local37 > local22 && local38 < local21) {
              local49 = (local19 - local37) / (local38 - local37);
              local8 = local6.alternativa3d::create();
              this.alternativa3d::lastVertex.alternativa3d::next = local8;
              this.alternativa3d::lastVertex = local8;
              local8.alternativa3d::cameraX = local5.alternativa3d::cameraX + (local6.alternativa3d::cameraX - local5.alternativa3d::cameraX) * local49;
              local8.alternativa3d::cameraY = local5.alternativa3d::cameraY + (local6.alternativa3d::cameraY - local5.alternativa3d::cameraY) * local49;
              local8.alternativa3d::cameraZ = local5.alternativa3d::cameraZ + (local6.alternativa3d::cameraZ - local5.alternativa3d::cameraZ) * local49;
              local8.u = local5.u + (local6.u - local5.u) * local49;
              local8.v = local5.v + (local6.v - local5.v) * local49;
              if(local48) {
                local8.x = local5.x + (local6.x - local5.x) * local49;
                local8.y = local5.y + (local6.y - local5.y) * local49;
                local8.z = local5.z + (local6.z - local5.z) * local49;
                local8.normalX = local5.normalX + (local6.normalX - local5.normalX) * local49;
                local8.normalY = local5.normalY + (local6.normalY - local5.normalY) * local49;
                local8.normalZ = local5.normalZ + (local6.normalZ - local5.normalZ) * local49;
              }
              local47 = local4.alternativa3d::create();
              local47.alternativa3d::vertex = local8;
              if(local45 != null) {
                local45.alternativa3d::next = local47;
              } else {
                local43.alternativa3d::wrapper = local47;
              }
              local45 = local47;
              local47 = local4.alternativa3d::create();
              local47.alternativa3d::vertex = local8;
              if(local46 != null) {
                local46.alternativa3d::next = local47;
              } else {
                local44.alternativa3d::wrapper = local47;
              }
              local46 = local47;
            }
            if(local38 <= local22) {
              local47 = local4.alternativa3d::create();
              local47.alternativa3d::vertex = local6;
              if(local45 != null) {
                local45.alternativa3d::next = local47;
              } else {
                local43.alternativa3d::wrapper = local47;
              }
              local45 = local47;
            }
            if(local38 >= local21) {
              local47 = local4.alternativa3d::create();
              local47.alternativa3d::vertex = local6;
              if(local46 != null) {
                local46.alternativa3d::next = local47;
              } else {
                local44.alternativa3d::wrapper = local47;
              }
              local46 = local47;
            }
            local5 = local6;
            local37 = local38;
            local4 = local4.alternativa3d::next;
          }
          if(local23 != null) {
            local24.alternativa3d::processNext = local43;
          } else {
            local23 = local43;
          }
          local24 = local43;
          if(local26 != null) {
            local27.alternativa3d::processNext = local44;
          } else {
            local26 = local44;
          }
          local27 = local44;
          local29.alternativa3d::processNext = null;
        }
        local29 = local28;
      }
      if(local26 != null) {
        local27.alternativa3d::processNext = null;
        if(local26.alternativa3d::processNext != null) {
          param3 = this.alternativa3d::sortByDynamicBSP(local26,param2,param3);
        } else {
          local26.alternativa3d::processNext = param3;
          param3 = local26;
        }
      }
      local25.alternativa3d::processNext = param3;
      param3 = local9;
      if(local23 != null) {
        local24.alternativa3d::processNext = null;
        if(local23.alternativa3d::processNext != null) {
          param3 = this.alternativa3d::sortByDynamicBSP(local23,param2,param3);
        } else {
          local23.alternativa3d::processNext = param3;
          param3 = local23;
        }
      }
      return param3;
    }

    alternativa3d function cull(param1:Face, param2:int) : Face {
      var local3:Face = null;
      var local4:Face = null;
      var local5:Face = null;
      var local6:Vertex = null;
      var local7:Vertex = null;
      var local8:Vertex = null;
      var local9:Wrapper = null;
      var local10:Vertex = null;
      var local11:Wrapper = null;
      var local12:Number = NaN;
      var local13:Number = NaN;
      var local14:Number = NaN;
      var local15:Number = NaN;
      var local16:Number = NaN;
      var local17:Number = NaN;
      var local18:Number = NaN;
      var local19:Number = NaN;
      var local20:Number = NaN;
      var local21:Boolean = (param2 & 1) > 0;
      var local22:Boolean = (param2 & 2) > 0;
      var local23:Boolean = (param2 & 4) > 0;
      var local24:Boolean = (param2 & 8) > 0;
      var local25:Boolean = (param2 & 0x10) > 0;
      var local26:Boolean = (param2 & 0x20) > 0;
      var local27:Number = this.nearClipping;
      var local28:Number = this.farClipping;
      var local29:Boolean = local23 || local24;
      var local30:Boolean = local25 || local26;
      var local31:Face = param1;
      for(; local31 != null; local31 = local5) {
        local5 = local31.alternativa3d::processNext;
        local9 = local31.alternativa3d::wrapper;
        local6 = local9.alternativa3d::vertex;
        local9 = local9.alternativa3d::next;
        local7 = local9.alternativa3d::vertex;
        local9 = local9.alternativa3d::next;
        local8 = local9.alternativa3d::vertex;
        local9 = local9.alternativa3d::next;
        if(local29) {
          local12 = Number(local6.alternativa3d::cameraX);
          local15 = Number(local7.alternativa3d::cameraX);
          local18 = Number(local8.alternativa3d::cameraX);
        }
        if(local30) {
          local13 = Number(local6.alternativa3d::cameraY);
          local16 = Number(local7.alternativa3d::cameraY);
          local19 = Number(local8.alternativa3d::cameraY);
        }
        local14 = Number(local6.alternativa3d::cameraZ);
        local17 = Number(local7.alternativa3d::cameraZ);
        local20 = Number(local8.alternativa3d::cameraZ);
        if(local21) {
          if(local14 <= local27 || local17 <= local27 || local20 <= local27) {
            local31.alternativa3d::processNext = null;
            continue;
          }
          local11 = local9;
          while(local11 != null) {
            if(local11.alternativa3d::vertex.alternativa3d::cameraZ <= local27) {
              break;
            }
            local11 = local11.alternativa3d::next;
          }
          if(local11 != null) {
            local31.alternativa3d::processNext = null;
            continue;
          }
        }
        if(local22 && local14 >= local28 && local17 >= local28 && local20 >= local28) {
          local11 = local9;
          while(local11 != null) {
            if(local11.alternativa3d::vertex.alternativa3d::cameraZ < local28) {
              break;
            }
            local11 = local11.alternativa3d::next;
          }
          if(local11 == null) {
            local31.alternativa3d::processNext = null;
            continue;
          }
        }
        if(local23 && local14 <= -local12 && local17 <= -local15 && local20 <= -local18) {
          local11 = local9;
          while(local11 != null) {
            local10 = local11.alternativa3d::vertex;
            if(-local10.alternativa3d::cameraX < local10.alternativa3d::cameraZ) {
              break;
            }
            local11 = local11.alternativa3d::next;
          }
          if(local11 == null) {
            local31.alternativa3d::processNext = null;
            continue;
          }
        }
        if(local24 && local14 <= local12 && local17 <= local15 && local20 <= local18) {
          local11 = local9;
          while(local11 != null) {
            local10 = local11.alternativa3d::vertex;
            if(local10.alternativa3d::cameraX < local10.alternativa3d::cameraZ) {
              break;
            }
            local11 = local11.alternativa3d::next;
          }
          if(local11 == null) {
            local31.alternativa3d::processNext = null;
            continue;
          }
        }
        if(local25 && local14 <= -local13 && local17 <= -local16 && local20 <= -local19) {
          local11 = local9;
          while(local11 != null) {
            local10 = local11.alternativa3d::vertex;
            if(-local10.alternativa3d::cameraY < local10.alternativa3d::cameraZ) {
              break;
            }
            local11 = local11.alternativa3d::next;
          }
          if(local11 == null) {
            local31.alternativa3d::processNext = null;
            continue;
          }
        }
        if(local26 && local14 <= local13 && local17 <= local16 && local20 <= local19) {
          local11 = local9;
          while(local11 != null) {
            local10 = local11.alternativa3d::vertex;
            if(local10.alternativa3d::cameraY < local10.alternativa3d::cameraZ) {
              break;
            }
            local11 = local11.alternativa3d::next;
          }
          if(local11 == null) {
            local31.alternativa3d::processNext = null;
            continue;
          }
        }
        if(local3 != null) {
          local4.alternativa3d::processNext = local31;
        } else {
          local3 = local31;
        }
        local4 = local31;
      }
      if(local4 != null) {
        local4.alternativa3d::processNext = null;
      }
      return local3;
    }

    alternativa3d function clip(param1:Face, param2:int) : Face {
      var local3:Face = null;
      var local4:Face = null;
      var local5:Face = null;
      var local6:Vertex = null;
      var local7:Vertex = null;
      var local8:Vertex = null;
      var local9:Wrapper = null;
      var local10:Vertex = null;
      var local11:Wrapper = null;
      var local12:Wrapper = null;
      var local13:Wrapper = null;
      var local14:Wrapper = null;
      var local15:Wrapper = null;
      var local16:Number = NaN;
      var local17:Number = NaN;
      var local18:Number = NaN;
      var local19:Number = NaN;
      var local20:Number = NaN;
      var local21:Number = NaN;
      var local22:Number = NaN;
      var local23:Number = NaN;
      var local24:Number = NaN;
      var local25:Boolean = false;
      var local26:Boolean = false;
      var local27:Boolean = false;
      var local28:Boolean = false;
      var local29:Boolean = false;
      var local30:Boolean = false;
      var local31:Number = NaN;
      var local32:Number = NaN;
      var local33:Boolean = false;
      var local34:Boolean = false;
      var local35:int = 0;
      var local36:Number = NaN;
      var local37:Face = null;
      var local38:Boolean = false;
      var local39:Face = null;
      local25 = (param2 & 1) > 0;
      local26 = (param2 & 2) > 0;
      local27 = (param2 & 4) > 0;
      local28 = (param2 & 8) > 0;
      local29 = (param2 & 0x10) > 0;
      local30 = (param2 & 0x20) > 0;
      local31 = this.nearClipping;
      local32 = this.farClipping;
      local33 = local27 || local28;
      local34 = local29 || local30;
      local37 = param1;
      for(; local37 != null; local37 = local5) {
        local5 = local37.alternativa3d::processNext;
        local9 = local37.alternativa3d::wrapper;
        local6 = local9.alternativa3d::vertex;
        local9 = local9.alternativa3d::next;
        local7 = local9.alternativa3d::vertex;
        local9 = local9.alternativa3d::next;
        local8 = local9.alternativa3d::vertex;
        local9 = local9.alternativa3d::next;
        if(local33) {
          local16 = Number(local6.alternativa3d::cameraX);
          local19 = Number(local7.alternativa3d::cameraX);
          local22 = Number(local8.alternativa3d::cameraX);
        }
        if(local34) {
          local17 = Number(local6.alternativa3d::cameraY);
          local20 = Number(local7.alternativa3d::cameraY);
          local23 = Number(local8.alternativa3d::cameraY);
        }
        local18 = Number(local6.alternativa3d::cameraZ);
        local21 = Number(local7.alternativa3d::cameraZ);
        local24 = Number(local8.alternativa3d::cameraZ);
        local35 = 0;
        if(local25) {
          if(local18 <= local31 && local21 <= local31 && local24 <= local31) {
            local11 = local9;
            while(local11 != null) {
              if(local11.alternativa3d::vertex.alternativa3d::cameraZ > local31) {
                local35 |= 1;
                break;
              }
              local11 = local11.alternativa3d::next;
            }
            if(local11 == null) {
              local37.alternativa3d::processNext = null;
              continue;
            }
          } else if(local18 > local31 && local21 > local31 && local24 > local31) {
            local11 = local9;
            while(local11 != null) {
              if(local11.alternativa3d::vertex.alternativa3d::cameraZ <= local31) {
                local35 |= 1;
                break;
              }
              local11 = local11.alternativa3d::next;
            }
          } else {
            local35 |= 1;
          }
        }
        if(local26) {
          if(local18 >= local32 && local21 >= local32 && local24 >= local32) {
            local11 = local9;
            while(local11 != null) {
              if(local11.alternativa3d::vertex.alternativa3d::cameraZ < local32) {
                local35 |= 2;
                break;
              }
              local11 = local11.alternativa3d::next;
            }
            if(local11 == null) {
              local37.alternativa3d::processNext = null;
              continue;
            }
          } else if(local18 < local32 && local21 < local32 && local24 < local32) {
            local11 = local9;
            while(local11 != null) {
              if(local11.alternativa3d::vertex.alternativa3d::cameraZ >= local32) {
                local35 |= 2;
                break;
              }
              local11 = local11.alternativa3d::next;
            }
          } else {
            local35 |= 2;
          }
        }
        if(local27) {
          if(local18 <= -local16 && local21 <= -local19 && local24 <= -local22) {
            local11 = local9;
            while(local11 != null) {
              local10 = local11.alternativa3d::vertex;
              if(-local10.alternativa3d::cameraX < local10.alternativa3d::cameraZ) {
                local35 |= 4;
                break;
              }
              local11 = local11.alternativa3d::next;
            }
            if(local11 == null) {
              local37.alternativa3d::processNext = null;
              continue;
            }
          } else if(local18 > -local16 && local21 > -local19 && local24 > -local22) {
            local11 = local9;
            while(local11 != null) {
              local10 = local11.alternativa3d::vertex;
              if(-local10.alternativa3d::cameraX >= local10.alternativa3d::cameraZ) {
                local35 |= 4;
                break;
              }
              local11 = local11.alternativa3d::next;
            }
          } else {
            local35 |= 4;
          }
        }
        if(local28) {
          if(local18 <= local16 && local21 <= local19 && local24 <= local22) {
            local11 = local9;
            while(local11 != null) {
              local10 = local11.alternativa3d::vertex;
              if(local10.alternativa3d::cameraX < local10.alternativa3d::cameraZ) {
                local35 |= 8;
                break;
              }
              local11 = local11.alternativa3d::next;
            }
            if(local11 == null) {
              local37.alternativa3d::processNext = null;
              continue;
            }
          } else if(local18 > local16 && local21 > local19 && local24 > local22) {
            local11 = local9;
            while(local11 != null) {
              local10 = local11.alternativa3d::vertex;
              if(local10.alternativa3d::cameraX >= local10.alternativa3d::cameraZ) {
                local35 |= 8;
                break;
              }
              local11 = local11.alternativa3d::next;
            }
          } else {
            local35 |= 8;
          }
        }
        if(local29) {
          if(local18 <= -local17 && local21 <= -local20 && local24 <= -local23) {
            local11 = local9;
            while(local11 != null) {
              local10 = local11.alternativa3d::vertex;
              if(-local10.alternativa3d::cameraY < local10.alternativa3d::cameraZ) {
                local35 |= 16;
                break;
              }
              local11 = local11.alternativa3d::next;
            }
            if(local11 == null) {
              local37.alternativa3d::processNext = null;
              continue;
            }
          } else if(local18 > -local17 && local21 > -local20 && local24 > -local23) {
            local11 = local9;
            while(local11 != null) {
              local10 = local11.alternativa3d::vertex;
              if(-local10.alternativa3d::cameraY >= local10.alternativa3d::cameraZ) {
                local35 |= 16;
                break;
              }
              local11 = local11.alternativa3d::next;
            }
          } else {
            local35 |= 16;
          }
        }
        if(local30) {
          if(local18 <= local17 && local21 <= local20 && local24 <= local23) {
            local11 = local9;
            while(local11 != null) {
              local10 = local11.alternativa3d::vertex;
              if(local10.alternativa3d::cameraY < local10.alternativa3d::cameraZ) {
                local35 |= 32;
                break;
              }
              local11 = local11.alternativa3d::next;
            }
            if(local11 == null) {
              local37.alternativa3d::processNext = null;
              continue;
            }
          } else if(local18 > local17 && local21 > local20 && local24 > local23) {
            local11 = local9;
            while(local11 != null) {
              local10 = local11.alternativa3d::vertex;
              if(local10.alternativa3d::cameraY >= local10.alternativa3d::cameraZ) {
                local35 |= 32;
                break;
              }
              local11 = local11.alternativa3d::next;
            }
          } else {
            local35 |= 32;
          }
        }
        if(local35 > 0) {
          local38 = local37.material != null && Boolean(local37.material.alternativa3d::useVerticesNormals);
          local12 = null;
          local13 = null;
          local11 = local37.alternativa3d::wrapper;
          while(local11 != null) {
            local15 = local11.alternativa3d::create();
            local15.alternativa3d::vertex = local11.alternativa3d::vertex;
            if(local12 != null) {
              local13.alternativa3d::next = local15;
            } else {
              local12 = local15;
            }
            local13 = local15;
            local11 = local11.alternativa3d::next;
          }
          if(Boolean(local35 & 1)) {
            local6 = local13.alternativa3d::vertex;
            local18 = Number(local6.alternativa3d::cameraZ);
            local11 = local12;
            local12 = null;
            local13 = null;
            while(local11 != null) {
              local14 = local11.alternativa3d::next;
              local7 = local11.alternativa3d::vertex;
              local21 = Number(local7.alternativa3d::cameraZ);
              if(local21 > local31 && local18 <= local31 || local21 <= local31 && local18 > local31) {
                local36 = (local31 - local18) / (local21 - local18);
                local10 = local7.alternativa3d::create();
                this.alternativa3d::lastVertex.alternativa3d::next = local10;
                this.alternativa3d::lastVertex = local10;
                local10.alternativa3d::cameraX = local6.alternativa3d::cameraX + (local7.alternativa3d::cameraX - local6.alternativa3d::cameraX) * local36;
                local10.alternativa3d::cameraY = local6.alternativa3d::cameraY + (local7.alternativa3d::cameraY - local6.alternativa3d::cameraY) * local36;
                local10.alternativa3d::cameraZ = local18 + (local21 - local18) * local36;
                local10.x = local6.x + (local7.x - local6.x) * local36;
                local10.y = local6.y + (local7.y - local6.y) * local36;
                local10.z = local6.z + (local7.z - local6.z) * local36;
                local10.u = local6.u + (local7.u - local6.u) * local36;
                local10.v = local6.v + (local7.v - local6.v) * local36;
                if(local38) {
                  local10.normalX = local6.normalX + (local7.normalX - local6.normalX) * local36;
                  local10.normalY = local6.normalY + (local7.normalY - local6.normalY) * local36;
                  local10.normalZ = local6.normalZ + (local7.normalZ - local6.normalZ) * local36;
                }
                local15 = local11.alternativa3d::create();
                local15.alternativa3d::vertex = local10;
                if(local12 != null) {
                  local13.alternativa3d::next = local15;
                } else {
                  local12 = local15;
                }
                local13 = local15;
              }
              if(local21 > local31) {
                if(local12 != null) {
                  local13.alternativa3d::next = local11;
                } else {
                  local12 = local11;
                }
                local13 = local11;
                local11.alternativa3d::next = null;
              } else {
                local11.alternativa3d::vertex = null;
                local11.alternativa3d::next = Wrapper.alternativa3d::collector;
                Wrapper.alternativa3d::collector = local11;
              }
              local6 = local7;
              local18 = local21;
              local11 = local14;
            }
            if(local12 == null) {
              local37.alternativa3d::processNext = null;
              continue;
            }
          }
          if(Boolean(local35 & 2)) {
            local6 = local13.alternativa3d::vertex;
            local18 = Number(local6.alternativa3d::cameraZ);
            local11 = local12;
            local12 = null;
            local13 = null;
            while(local11 != null) {
              local14 = local11.alternativa3d::next;
              local7 = local11.alternativa3d::vertex;
              local21 = Number(local7.alternativa3d::cameraZ);
              if(local21 < local32 && local18 >= local32 || local21 >= local32 && local18 < local32) {
                local36 = (local32 - local18) / (local21 - local18);
                local10 = local7.alternativa3d::create();
                this.alternativa3d::lastVertex.alternativa3d::next = local10;
                this.alternativa3d::lastVertex = local10;
                local10.alternativa3d::cameraX = local6.alternativa3d::cameraX + (local7.alternativa3d::cameraX - local6.alternativa3d::cameraX) * local36;
                local10.alternativa3d::cameraY = local6.alternativa3d::cameraY + (local7.alternativa3d::cameraY - local6.alternativa3d::cameraY) * local36;
                local10.alternativa3d::cameraZ = local18 + (local21 - local18) * local36;
                local10.x = local6.x + (local7.x - local6.x) * local36;
                local10.y = local6.y + (local7.y - local6.y) * local36;
                local10.z = local6.z + (local7.z - local6.z) * local36;
                local10.u = local6.u + (local7.u - local6.u) * local36;
                local10.v = local6.v + (local7.v - local6.v) * local36;
                if(local38) {
                  local10.normalX = local6.normalX + (local7.normalX - local6.normalX) * local36;
                  local10.normalY = local6.normalY + (local7.normalY - local6.normalY) * local36;
                  local10.normalZ = local6.normalZ + (local7.normalZ - local6.normalZ) * local36;
                }
                local15 = local11.alternativa3d::create();
                local15.alternativa3d::vertex = local10;
                if(local12 != null) {
                  local13.alternativa3d::next = local15;
                } else {
                  local12 = local15;
                }
                local13 = local15;
              }
              if(local21 < local32) {
                if(local12 != null) {
                  local13.alternativa3d::next = local11;
                } else {
                  local12 = local11;
                }
                local13 = local11;
                local11.alternativa3d::next = null;
              } else {
                local11.alternativa3d::vertex = null;
                local11.alternativa3d::next = Wrapper.alternativa3d::collector;
                Wrapper.alternativa3d::collector = local11;
              }
              local6 = local7;
              local18 = local21;
              local11 = local14;
            }
            if(local12 == null) {
              local37.alternativa3d::processNext = null;
              continue;
            }
          }
          if(Boolean(local35 & 4)) {
            local6 = local13.alternativa3d::vertex;
            local16 = Number(local6.alternativa3d::cameraX);
            local18 = Number(local6.alternativa3d::cameraZ);
            local11 = local12;
            local12 = null;
            local13 = null;
            while(local11 != null) {
              local14 = local11.alternativa3d::next;
              local7 = local11.alternativa3d::vertex;
              local19 = Number(local7.alternativa3d::cameraX);
              local21 = Number(local7.alternativa3d::cameraZ);
              if(local21 > -local19 && local18 <= -local16 || local21 <= -local19 && local18 > -local16) {
                local36 = (local16 + local18) / (local16 + local18 - local19 - local21);
                local10 = local7.alternativa3d::create();
                this.alternativa3d::lastVertex.alternativa3d::next = local10;
                this.alternativa3d::lastVertex = local10;
                local10.alternativa3d::cameraX = local16 + (local19 - local16) * local36;
                local10.alternativa3d::cameraY = local6.alternativa3d::cameraY + (local7.alternativa3d::cameraY - local6.alternativa3d::cameraY) * local36;
                local10.alternativa3d::cameraZ = local18 + (local21 - local18) * local36;
                local10.x = local6.x + (local7.x - local6.x) * local36;
                local10.y = local6.y + (local7.y - local6.y) * local36;
                local10.z = local6.z + (local7.z - local6.z) * local36;
                local10.u = local6.u + (local7.u - local6.u) * local36;
                local10.v = local6.v + (local7.v - local6.v) * local36;
                if(local38) {
                  local10.normalX = local6.normalX + (local7.normalX - local6.normalX) * local36;
                  local10.normalY = local6.normalY + (local7.normalY - local6.normalY) * local36;
                  local10.normalZ = local6.normalZ + (local7.normalZ - local6.normalZ) * local36;
                }
                local15 = local11.alternativa3d::create();
                local15.alternativa3d::vertex = local10;
                if(local12 != null) {
                  local13.alternativa3d::next = local15;
                } else {
                  local12 = local15;
                }
                local13 = local15;
              }
              if(local21 > -local19) {
                if(local12 != null) {
                  local13.alternativa3d::next = local11;
                } else {
                  local12 = local11;
                }
                local13 = local11;
                local11.alternativa3d::next = null;
              } else {
                local11.alternativa3d::vertex = null;
                local11.alternativa3d::next = Wrapper.alternativa3d::collector;
                Wrapper.alternativa3d::collector = local11;
              }
              local6 = local7;
              local16 = local19;
              local18 = local21;
              local11 = local14;
            }
            if(local12 == null) {
              local37.alternativa3d::processNext = null;
              continue;
            }
          }
          if(Boolean(local35 & 8)) {
            local6 = local13.alternativa3d::vertex;
            local16 = Number(local6.alternativa3d::cameraX);
            local18 = Number(local6.alternativa3d::cameraZ);
            local11 = local12;
            local12 = null;
            local13 = null;
            while(local11 != null) {
              local14 = local11.alternativa3d::next;
              local7 = local11.alternativa3d::vertex;
              local19 = Number(local7.alternativa3d::cameraX);
              local21 = Number(local7.alternativa3d::cameraZ);
              if(local21 > local19 && local18 <= local16 || local21 <= local19 && local18 > local16) {
                local36 = (local18 - local16) / (local18 - local16 + local19 - local21);
                local10 = local7.alternativa3d::create();
                this.alternativa3d::lastVertex.alternativa3d::next = local10;
                this.alternativa3d::lastVertex = local10;
                local10.alternativa3d::cameraX = local16 + (local19 - local16) * local36;
                local10.alternativa3d::cameraY = local6.alternativa3d::cameraY + (local7.alternativa3d::cameraY - local6.alternativa3d::cameraY) * local36;
                local10.alternativa3d::cameraZ = local18 + (local21 - local18) * local36;
                local10.x = local6.x + (local7.x - local6.x) * local36;
                local10.y = local6.y + (local7.y - local6.y) * local36;
                local10.z = local6.z + (local7.z - local6.z) * local36;
                local10.u = local6.u + (local7.u - local6.u) * local36;
                local10.v = local6.v + (local7.v - local6.v) * local36;
                if(local38) {
                  local10.normalX = local6.normalX + (local7.normalX - local6.normalX) * local36;
                  local10.normalY = local6.normalY + (local7.normalY - local6.normalY) * local36;
                  local10.normalZ = local6.normalZ + (local7.normalZ - local6.normalZ) * local36;
                }
                local15 = local11.alternativa3d::create();
                local15.alternativa3d::vertex = local10;
                if(local12 != null) {
                  local13.alternativa3d::next = local15;
                } else {
                  local12 = local15;
                }
                local13 = local15;
              }
              if(local21 > local19) {
                if(local12 != null) {
                  local13.alternativa3d::next = local11;
                } else {
                  local12 = local11;
                }
                local13 = local11;
                local11.alternativa3d::next = null;
              } else {
                local11.alternativa3d::vertex = null;
                local11.alternativa3d::next = Wrapper.alternativa3d::collector;
                Wrapper.alternativa3d::collector = local11;
              }
              local6 = local7;
              local16 = local19;
              local18 = local21;
              local11 = local14;
            }
            if(local12 == null) {
              local37.alternativa3d::processNext = null;
              continue;
            }
          }
          if(Boolean(local35 & 0x10)) {
            local6 = local13.alternativa3d::vertex;
            local17 = Number(local6.alternativa3d::cameraY);
            local18 = Number(local6.alternativa3d::cameraZ);
            local11 = local12;
            local12 = null;
            local13 = null;
            while(local11 != null) {
              local14 = local11.alternativa3d::next;
              local7 = local11.alternativa3d::vertex;
              local20 = Number(local7.alternativa3d::cameraY);
              local21 = Number(local7.alternativa3d::cameraZ);
              if(local21 > -local20 && local18 <= -local17 || local21 <= -local20 && local18 > -local17) {
                local36 = (local17 + local18) / (local17 + local18 - local20 - local21);
                local10 = local7.alternativa3d::create();
                this.alternativa3d::lastVertex.alternativa3d::next = local10;
                this.alternativa3d::lastVertex = local10;
                local10.alternativa3d::cameraX = local6.alternativa3d::cameraX + (local7.alternativa3d::cameraX - local6.alternativa3d::cameraX) * local36;
                local10.alternativa3d::cameraY = local17 + (local20 - local17) * local36;
                local10.alternativa3d::cameraZ = local18 + (local21 - local18) * local36;
                local10.x = local6.x + (local7.x - local6.x) * local36;
                local10.y = local6.y + (local7.y - local6.y) * local36;
                local10.z = local6.z + (local7.z - local6.z) * local36;
                local10.u = local6.u + (local7.u - local6.u) * local36;
                local10.v = local6.v + (local7.v - local6.v) * local36;
                if(local38) {
                  local10.normalX = local6.normalX + (local7.normalX - local6.normalX) * local36;
                  local10.normalY = local6.normalY + (local7.normalY - local6.normalY) * local36;
                  local10.normalZ = local6.normalZ + (local7.normalZ - local6.normalZ) * local36;
                }
                local15 = local11.alternativa3d::create();
                local15.alternativa3d::vertex = local10;
                if(local12 != null) {
                  local13.alternativa3d::next = local15;
                } else {
                  local12 = local15;
                }
                local13 = local15;
              }
              if(local21 > -local20) {
                if(local12 != null) {
                  local13.alternativa3d::next = local11;
                } else {
                  local12 = local11;
                }
                local13 = local11;
                local11.alternativa3d::next = null;
              } else {
                local11.alternativa3d::vertex = null;
                local11.alternativa3d::next = Wrapper.alternativa3d::collector;
                Wrapper.alternativa3d::collector = local11;
              }
              local6 = local7;
              local17 = local20;
              local18 = local21;
              local11 = local14;
            }
            if(local12 == null) {
              local37.alternativa3d::processNext = null;
              continue;
            }
          }
          if(Boolean(local35 & 0x20)) {
            local6 = local13.alternativa3d::vertex;
            local17 = Number(local6.alternativa3d::cameraY);
            local18 = Number(local6.alternativa3d::cameraZ);
            local11 = local12;
            local12 = null;
            local13 = null;
            while(local11 != null) {
              local14 = local11.alternativa3d::next;
              local7 = local11.alternativa3d::vertex;
              local20 = Number(local7.alternativa3d::cameraY);
              local21 = Number(local7.alternativa3d::cameraZ);
              if(local21 > local20 && local18 <= local17 || local21 <= local20 && local18 > local17) {
                local36 = (local18 - local17) / (local18 - local17 + local20 - local21);
                local10 = local7.alternativa3d::create();
                this.alternativa3d::lastVertex.alternativa3d::next = local10;
                this.alternativa3d::lastVertex = local10;
                local10.alternativa3d::cameraX = local6.alternativa3d::cameraX + (local7.alternativa3d::cameraX - local6.alternativa3d::cameraX) * local36;
                local10.alternativa3d::cameraY = local17 + (local20 - local17) * local36;
                local10.alternativa3d::cameraZ = local18 + (local21 - local18) * local36;
                local10.x = local6.x + (local7.x - local6.x) * local36;
                local10.y = local6.y + (local7.y - local6.y) * local36;
                local10.z = local6.z + (local7.z - local6.z) * local36;
                local10.u = local6.u + (local7.u - local6.u) * local36;
                local10.v = local6.v + (local7.v - local6.v) * local36;
                if(local38) {
                  local10.normalX = local6.normalX + (local7.normalX - local6.normalX) * local36;
                  local10.normalY = local6.normalY + (local7.normalY - local6.normalY) * local36;
                  local10.normalZ = local6.normalZ + (local7.normalZ - local6.normalZ) * local36;
                }
                local15 = local11.alternativa3d::create();
                local15.alternativa3d::vertex = local10;
                if(local12 != null) {
                  local13.alternativa3d::next = local15;
                } else {
                  local12 = local15;
                }
                local13 = local15;
              }
              if(local21 > local20) {
                if(local12 != null) {
                  local13.alternativa3d::next = local11;
                } else {
                  local12 = local11;
                }
                local13 = local11;
                local11.alternativa3d::next = null;
              } else {
                local11.alternativa3d::vertex = null;
                local11.alternativa3d::next = Wrapper.alternativa3d::collector;
                Wrapper.alternativa3d::collector = local11;
              }
              local6 = local7;
              local17 = local20;
              local18 = local21;
              local11 = local14;
            }
            if(local12 == null) {
              local37.alternativa3d::processNext = null;
              continue;
            }
          }
          local37.alternativa3d::processNext = null;
          local39 = local37.alternativa3d::create();
          local39.material = local37.material;
          this.alternativa3d::lastFace.alternativa3d::next = local39;
          this.alternativa3d::lastFace = local39;
          local39.alternativa3d::wrapper = local12;
          local37 = local39;
        }
        if(local3 != null) {
          local4.alternativa3d::processNext = local37;
        } else {
          local3 = local37;
        }
        local4 = local37;
      }
      if(local4 != null) {
        local4.alternativa3d::processNext = null;
      }
      return local3;
    }
  }
}
