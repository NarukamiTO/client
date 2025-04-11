package alternativa.gfx.core {
  import alternativa.gfx.alternativagfx;
  import flash.display.BitmapData;
  import flash.display.Stage;
  import flash.display.Stage3D;
  import flash.display3D.Context3D;
  import flash.display3D.Context3DProgramType;
  import flash.events.Event;
  import flash.events.EventDispatcher;
  import flash.geom.Rectangle;
  import flash.utils.Dictionary;

  use namespace alternativagfx;

  [Event(name="context3DCreate",type="flash.events.Event")]
  public class Device extends EventDispatcher {
    private static const RESOURCE_NOT_AVAILABLE_ERROR:String = "Resource is not available.";

    private var _stage:Stage;
    private var _renderMode:String;
    private var _profile:String;
    private var _x:int;
    private var _y:int;
    private var _width:int;
    private var _height:int;
    private var _antiAlias:int;
    private var _enableDepthAndStencil:Boolean;
    private var _enableErrorChecking:Boolean;
    private var _stage3D:Stage3D;
    private var _available:Boolean = true;
    private var _renderState:RenderState = new RenderState();
    private var configured:Boolean = false;
    private var backBufferWidth:int = -1;
    private var backBufferHeight:int = -1;
    private var backBufferAntiAlias:int = -1;
    private var backBufferEnableDepthAndStencil:Boolean = false;
    private var resourcesToUpload:Dictionary = new Dictionary();

    public function Device(param1:Stage, param2:String = "auto", param3:String = "baseline") {
      super();
      this._stage = param1;
      this._renderMode = param2;
      this._profile = param3;
      this._stage3D = this._stage.stage3Ds[0];
      this._x = this._stage3D.x;
      this._y = this._stage3D.y;
      this._width = param1.stageWidth;
      this._height = param1.stageHeight;
      this._antiAlias = 0;
      this._enableDepthAndStencil = true;
      this._enableErrorChecking = false;
      this._stage3D.addEventListener(Event.CONTEXT3D_CREATE,this.onContext3DCreate);
      if(this._stage3D.requestContext3D.length > 1) {
        this._stage3D.requestContext3D(param2,param3);
      } else {
        this._stage3D.requestContext3D(param2);
      }
    }

    private function onContext3DCreate(param1:Event) : void {
      var local3:* = undefined;
      var local5:TextureResource = null;
      var local6:VertexBufferResource = null;
      this.configured = false;
      this.backBufferWidth = -1;
      this.backBufferHeight = -1;
      this.backBufferAntiAlias = -1;
      this.backBufferEnableDepthAndStencil = false;
      var local2:Context3D = this._stage3D.context3D;
      local2.enableErrorChecking = this._enableErrorChecking;
      for(local3 in this.resourcesToUpload) {
        this.uploadResource(local3);
        delete this.resourcesToUpload[local3];
      }
      local2.setBlendFactors(this._renderState.blendSourceFactor,this._renderState.blendDestinationFactor);
      local2.setColorMask(this._renderState.colorMaskRed,this._renderState.colorMaskGreen,this._renderState.colorMaskBlue,this._renderState.colorMaskAlpha);
      local2.setCulling(this._renderState.culling);
      local2.setDepthTest(this._renderState.depthTestMask,this._renderState.depthTestPassCompareMode);
      if(this._renderState.program != null) {
        if(!this._renderState.program.available) {
          throw new Error(RESOURCE_NOT_AVAILABLE_ERROR);
        }
        this.prepareResource(local2,this._renderState.program);
        local2.setProgram(this._renderState.program.alternativagfx::program);
      }
      if(this._renderState.renderTarget != null) {
        if(!this._renderState.renderTarget.available) {
          throw new Error(RESOURCE_NOT_AVAILABLE_ERROR);
        }
        this.prepareResource(local2,this._renderState.renderTarget);
        local2.setRenderToTexture(this._renderState.renderTarget.texture,this._renderState.renderTargetEnableDepthAndStencil,this._renderState.renderTargetAntiAlias,this._renderState.renderTargetSurfaceSelector);
      }
      if(this._renderState.scissor) {
        local2.setScissorRectangle(this._renderState.scissorRectangle);
      } else {
        local2.setScissorRectangle(null);
      }
      local2.setStencilActions(this._renderState.stencilActionTriangleFace,this._renderState.stencilActionCompareMode,this._renderState.stencilActionOnBothPass,this._renderState.stencilActionOnDepthFail,this._renderState.stencilActionOnDepthPassStencilFail);
      local2.setStencilReferenceValue(this._renderState.stencilReferenceValue,this._renderState.stencilReadMask,this._renderState.stencilWriteMask);
      var local4:int = 0;
      while(local4 < 8) {
        local5 = this._renderState.textures[local4];
        if(local5 != null) {
          if(!local5.available) {
            throw new Error(RESOURCE_NOT_AVAILABLE_ERROR);
          }
          this.prepareResource(local2,local5);
          local2.setTextureAt(local4,local5.texture);
        }
        local6 = this._renderState.vertexBuffers[local4];
        if(local6 != null) {
          if(!local6.available) {
            throw new Error(RESOURCE_NOT_AVAILABLE_ERROR);
          }
          this.prepareResource(local2,local6);
          local2.setVertexBufferAt(local4,local6.alternativagfx::buffer,this._renderState.vertexBuffersOffsets[local4],this._renderState.vertexBuffersFormats[local4]);
        }
        local4++;
      }
      local2.setProgramConstantsFromVector(Context3DProgramType.VERTEX,0,this._renderState.vertexConstants,128);
      local2.setProgramConstantsFromVector(Context3DProgramType.FRAGMENT,0,this._renderState.fragmentConstants,28);
      dispatchEvent(new Event(Event.CONTEXT3D_CREATE));
    }

    public function dispose() : void {
      var local1:* = undefined;
      this._stage3D.removeEventListener(Event.CONTEXT3D_CREATE,this.onContext3DCreate);
      if(this._stage3D.context3D != null) {
        this._stage3D.context3D.dispose();
      }
      for(local1 in this.resourcesToUpload) {
        delete this.resourcesToUpload[local1];
      }
      this._renderState = new RenderState();
      this._available = false;
    }

    public function reset() : void {
      var local1:* = undefined;
      if(this._stage3D.context3D != null) {
        this._stage3D.context3D.dispose();
      } else {
        for(local1 in this.resourcesToUpload) {
          delete this.resourcesToUpload[local1];
        }
      }
      this._renderState = new RenderState();
    }

    public function get available() : Boolean {
      return this._available;
    }

    public function get ready() : Boolean {
      return this._stage3D.context3D != null;
    }

    public function get stage() : Stage {
      return this._stage;
    }

    public function get stage3DIndex() : int {
      return 0;
    }

    public function get renderMode() : String {
      return this._renderMode;
    }

    public function get profile() : String {
      return this._profile;
    }

    public function get x() : int {
      return this._x;
    }

    public function set x(param1:int) : void {
      this._x = param1;
    }

    public function get y() : int {
      return this._y;
    }

    public function set y(param1:int) : void {
      this._y = param1;
    }

    public function get width() : int {
      return this._width;
    }

    public function set width(param1:int) : void {
      this._width = param1;
    }

    public function get height() : int {
      return this._height;
    }

    public function set height(param1:int) : void {
      this._height = param1;
    }

    public function get antiAlias() : int {
      return this._antiAlias;
    }

    public function set antiAlias(param1:int) : void {
      if(param1 != 0 && param1 != 2 && param1 != 4 && param1 != 16) {
        throw new Error("Invalid antialiasing value.");
      }
      this._antiAlias = param1;
    }

    public function get enableDepthAndStencil() : Boolean {
      return this._enableDepthAndStencil;
    }

    public function set enableDepthAndStencil(param1:Boolean) : void {
      this._enableDepthAndStencil = param1;
    }

    public function get enableErrorChecking() : Boolean {
      return this._enableErrorChecking;
    }

    public function set enableErrorChecking(param1:Boolean) : void {
      this._enableErrorChecking = param1;
      var local2:Context3D = this._stage3D.context3D;
      if(local2 != null && local2.enableErrorChecking != this._enableErrorChecking) {
        local2.enableErrorChecking = this._enableErrorChecking;
      }
    }

    public function uploadResource(param1:Resource) : void {
      if(!param1.available) {
        throw new Error(RESOURCE_NOT_AVAILABLE_ERROR);
      }
      var local2:Context3D = this._stage3D.context3D;
      if(local2 != null) {
        if(!param1.isCreated(local2)) {
          param1.alternativagfx::create(local2);
        }
        param1.alternativagfx::upload();
      } else {
        this.resourcesToUpload[param1] = true;
      }
    }

    private function prepareResource(param1:Context3D, param2:Resource) : void {
      if(!param2.isCreated(param1)) {
        param2.alternativagfx::create(param1);
        param2.alternativagfx::upload();
      }
    }

    public function setBlendFactors(param1:String, param2:String) : void {
      var local3:Context3D = null;
      if(param1 != this._renderState.blendSourceFactor || param2 != this._renderState.blendDestinationFactor) {
        this._renderState.blendSourceFactor = param1;
        this._renderState.blendDestinationFactor = param2;
        local3 = this._stage3D.context3D;
        if(local3 != null) {
          local3.setBlendFactors(param1,param2);
        }
      }
    }

    public function setColorMask(param1:Boolean, param2:Boolean, param3:Boolean, param4:Boolean) : void {
      var local5:Context3D = null;
      if(param1 != this._renderState.colorMaskRed || param2 != this._renderState.colorMaskGreen || param3 != this._renderState.colorMaskBlue || param4 != this._renderState.colorMaskAlpha) {
        this._renderState.colorMaskRed = param1;
        this._renderState.colorMaskGreen = param2;
        this._renderState.colorMaskBlue = param3;
        this._renderState.colorMaskAlpha = param4;
        local5 = this._stage3D.context3D;
        if(local5 != null) {
          local5.setColorMask(param1,param2,param3,param4);
        }
      }
    }

    public function setCulling(param1:String) : void {
      var local2:Context3D = null;
      if(param1 != this._renderState.culling) {
        this._renderState.culling = param1;
        local2 = this._stage3D.context3D;
        if(local2 != null) {
          local2.setCulling(param1);
        }
      }
    }

    public function setDepthTest(param1:Boolean, param2:String) : void {
      var local3:Context3D = null;
      if(param1 != this._renderState.depthTestMask || param2 != this._renderState.depthTestPassCompareMode) {
        this._renderState.depthTestMask = param1;
        this._renderState.depthTestPassCompareMode = param2;
        local3 = this._stage3D.context3D;
        if(local3 != null) {
          local3.setDepthTest(param1,param2);
        }
      }
    }

    public function setProgram(param1:ProgramResource) : void {
      var local2:Context3D = null;
      if(param1 != this._renderState.program) {
        if(!param1.available) {
          throw new Error(RESOURCE_NOT_AVAILABLE_ERROR);
        }
        this._renderState.program = param1;
        local2 = this._stage3D.context3D;
        if(local2 != null) {
          this.prepareResource(local2,param1);
          local2.setProgram(param1.alternativagfx::program);
        }
      }
    }

    public function setRenderToBackBuffer() : void {
      var local1:Context3D = null;
      if(this._renderState.renderTarget != null) {
        this._renderState.renderTarget = null;
        local1 = this._stage3D.context3D;
        if(local1 != null) {
          local1.setRenderToBackBuffer();
        }
      }
    }

    public function setRenderToTexture(param1:TextureResource, param2:Boolean = false, param3:int = 0, param4:int = 0) : void {
      var local5:Context3D = null;
      if(param1 != this._renderState.renderTarget || param2 != this._renderState.renderTargetEnableDepthAndStencil || param3 != this._renderState.renderTargetAntiAlias || param4 != this._renderState.renderTargetSurfaceSelector) {
        if(param1 != null && !param1.available) {
          throw new Error(RESOURCE_NOT_AVAILABLE_ERROR);
        }
        this._renderState.renderTarget = param1;
        this._renderState.renderTargetEnableDepthAndStencil = param2;
        this._renderState.renderTargetAntiAlias = param3;
        this._renderState.renderTargetSurfaceSelector = param4;
        local5 = this._stage3D.context3D;
        if(local5 != null) {
          if(param1 != null) {
            this.prepareResource(local5,param1);
            local5.setRenderToTexture(param1.texture,param2,param3,param4);
          } else {
            local5.setRenderToBackBuffer();
          }
        }
      }
    }

    public function setScissorRectangle(param1:Rectangle) : void {
      var local2:Context3D = this._stage3D.context3D;
      if(param1 != null) {
        if(this._renderState.scissor) {
          if(param1.x != this._renderState.scissorRectangle.x || param1.y != this._renderState.scissorRectangle.y || param1.width != this._renderState.scissorRectangle.width || param1.height != this._renderState.scissorRectangle.height) {
            this._renderState.scissorRectangle.x = param1.x;
            this._renderState.scissorRectangle.y = param1.y;
            this._renderState.scissorRectangle.width = param1.width;
            this._renderState.scissorRectangle.height = param1.height;
            if(local2 != null) {
              local2.setScissorRectangle(param1);
            }
          }
        } else {
          this._renderState.scissor = true;
          this._renderState.scissorRectangle.x = param1.x;
          this._renderState.scissorRectangle.y = param1.y;
          this._renderState.scissorRectangle.width = param1.width;
          this._renderState.scissorRectangle.height = param1.height;
          if(local2 != null) {
            local2.setScissorRectangle(param1);
          }
        }
      } else {
        this._renderState.scissor = false;
        if(local2 != null) {
          local2.setScissorRectangle(null);
        }
      }
    }

    public function setStencilActions(param1:String = "frontAndBack", param2:String = "always", param3:String = "keep", param4:String = "keep", param5:String = "keep") : void {
      var local6:Context3D = null;
      if(param1 != this._renderState.stencilActionTriangleFace || param2 != this._renderState.stencilActionCompareMode || param3 != this._renderState.stencilActionOnBothPass || param4 != this._renderState.stencilActionOnDepthFail || param5 != this._renderState.stencilActionOnDepthPassStencilFail) {
        this._renderState.stencilActionTriangleFace = param1;
        this._renderState.stencilActionCompareMode = param2;
        this._renderState.stencilActionOnBothPass = param3;
        this._renderState.stencilActionOnDepthFail = param4;
        this._renderState.stencilActionOnDepthPassStencilFail = param5;
        local6 = this._stage3D.context3D;
        if(local6 != null) {
          local6.setStencilActions(param1,param2,param3,param4,param5);
        }
      }
    }

    public function setStencilReferenceValue(param1:uint, param2:uint = 255, param3:uint = 255) : void {
      var local4:Context3D = null;
      if(param1 != this._renderState.stencilReferenceValue || param2 != this._renderState.stencilReadMask || param3 != this._renderState.stencilWriteMask) {
        this._renderState.stencilReferenceValue = param1;
        this._renderState.stencilReadMask = param2;
        this._renderState.stencilWriteMask = param3;
        local4 = this._stage3D.context3D;
        if(local4 != null) {
          local4.setStencilReferenceValue(param1,param2,param3);
        }
      }
    }

    public function setTextureAt(param1:int, param2:TextureResource) : void {
      var local3:Context3D = null;
      if(param2 != this._renderState.textures[param1]) {
        if(param2 != null && !param2.available) {
          throw new Error(RESOURCE_NOT_AVAILABLE_ERROR);
        }
        this._renderState.textures[param1] = param2;
        local3 = this._stage3D.context3D;
        if(local3 != null) {
          if(param2 != null) {
            this.prepareResource(local3,param2);
            local3.setTextureAt(param1,param2.texture);
          } else {
            local3.setTextureAt(param1,null);
          }
        }
      }
    }

    public function setVertexBufferAt(param1:int, param2:VertexBufferResource, param3:int = 0, param4:String = "float4") : void {
      var local5:Context3D = null;
      if(param2 != this._renderState.vertexBuffers[param1] || param3 != this._renderState.vertexBuffersOffsets[param1] || param4 != this._renderState.vertexBuffersFormats[param1]) {
        if(param2 != null && !param2.available) {
          throw new Error(RESOURCE_NOT_AVAILABLE_ERROR);
        }
        this._renderState.vertexBuffers[param1] = param2;
        this._renderState.vertexBuffersOffsets[param1] = param3;
        this._renderState.vertexBuffersFormats[param1] = param4;
        local5 = this._stage3D.context3D;
        if(local5 != null) {
          if(param2 != null) {
            this.prepareResource(local5,param2);
            local5.setVertexBufferAt(param1,param2.alternativagfx::buffer,param3,param4);
          } else {
            local5.setVertexBufferAt(param1,null);
          }
        }
      }
    }

    public function setProgramConstantsFromVector(param1:String, param2:int, param3:Vector.<Number>, param4:int = -1, param5:Boolean = true) : void {
      var local6:Context3D = null;
      var local11:Boolean = false;
      var local12:Number = NaN;
      var local7:int = 0;
      var local8:int = param2 << 2;
      var local9:int = param4 < 0 ? int(param3.length) : param4 << 2;
      var local10:Vector.<Number> = param1 == "vertex" ? this._renderState.vertexConstants : this._renderState.fragmentConstants;
      if(param5) {
        local11 = false;
        while(local7 < local9) {
          local12 = param3[local7];
          if(local12 != local10[local8]) {
            local10[local8] = local12;
            local11 = true;
          }
          local7++;
          local8++;
        }
        if(local11) {
          local6 = this._stage3D.context3D;
          if(local6 != null) {
            local6.setProgramConstantsFromVector(param1,param2,param3,param4);
          }
        }
      } else {
        while(local7 < local9) {
          local10[local8] = param3[local7];
          local7++;
          local8++;
        }
        local6 = this._stage3D.context3D;
        if(local6 != null) {
          local6.setProgramConstantsFromVector(param1,param2,param3,param4);
        }
      }
    }

    public function clear(param1:Number = 0, param2:Number = 0, param3:Number = 0, param4:Number = 1, param5:Number = 1, param6:uint = 0, param7:uint = 4294967295) : void {
      var local9:int = 0;
      var local10:int = 0;
      var local11:int = 0;
      var local12:int = 0;
      var local13:int = 0;
      var local8:Context3D = this._stage3D.context3D;
      if(local8 != null) {
        if(!this.configured) {
          local9 = 50;
          local10 = this._width;
          local11 = this._height;
          if(this._profile == "baselineConstrained") {
            local12 = this._x;
            local13 = this._y;
            if(local12 < 0) {
              local12 = 0;
            }
            if(local13 < 0) {
              local13 = 0;
            }
            if(local12 + local10 > this.stage.stageWidth) {
              local10 = this.stage.stageWidth - local12;
            }
            if(local13 + local11 > this.stage.stageHeight) {
              local11 = this.stage.stageHeight - local13;
            }
            if(local12 != this._stage3D.x || local13 != this._stage3D.y || local10 != this.backBufferWidth || local11 != this.backBufferHeight || this._enableDepthAndStencil != this.backBufferEnableDepthAndStencil) {
              local8.configureBackBuffer(local9,local9,0,this._enableDepthAndStencil);
              this._stage3D.x = local12;
              this._stage3D.y = local13;
              local8.configureBackBuffer(local10,local11,0,this._enableDepthAndStencil);
              this.backBufferWidth = local10;
              this.backBufferHeight = local11;
              this.backBufferAntiAlias = this._antiAlias;
              this.backBufferEnableDepthAndStencil = this._enableDepthAndStencil;
            }
          } else {
            if(this._stage3D.x != this._x) {
              this._stage3D.x = this._x;
            }
            if(this._stage3D.y != this._y) {
              this._stage3D.y = this._y;
            }
            if(local10 < local9) {
              local10 = local9;
            }
            if(local11 < local9) {
              local11 = local9;
            }
            if(local10 != this.backBufferWidth || local11 != this.backBufferHeight || this._antiAlias != this.backBufferAntiAlias || this._enableDepthAndStencil != this.backBufferEnableDepthAndStencil) {
              local8.configureBackBuffer(local10,local11,this._antiAlias,this._enableDepthAndStencil);
              this.backBufferWidth = local10;
              this.backBufferHeight = local11;
              this.backBufferAntiAlias = this._antiAlias;
              this.backBufferEnableDepthAndStencil = this._enableDepthAndStencil;
            }
          }
          this.configured = true;
        }
        local8.clear(param1,param2,param3,param4,param5,param6,param7);
      }
    }

    public function drawToBitmapData(param1:BitmapData) : void {
      var local2:Context3D = this._stage3D.context3D;
      if(local2 != null) {
        local2.drawToBitmapData(param1);
      }
    }

    public function drawTriangles(param1:IndexBufferResource, param2:int = 0, param3:int = -1) : void {
      if(!param1.available) {
        throw new Error(RESOURCE_NOT_AVAILABLE_ERROR);
      }
      var local4:Context3D = this._stage3D.context3D;
      if(local4 != null) {
        this.prepareResource(local4,param1);
        try {
          local4.drawTriangles(param1.alternativagfx::buffer,param2,param3);
        }
        catch(e:Error) {
        }
      }
    }

    public function present() : void {
      this._renderState.renderTarget = null;
      var local1:Context3D = this._stage3D.context3D;
      if(local1 != null) {
        local1.present();
      }
      this.configured = false;
    }
  }
}
