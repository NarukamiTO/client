package alternativa.engine3d.core {
  import alternativa.engine3d.alternativa3d;
  import alternativa.engine3d.lights.DirectionalLight;
  import flash.display.Bitmap;
  import flash.display.BitmapData;
  import flash.display.DisplayObject;
  import flash.display.Sprite;
  import flash.display.StageAlign;
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
    public var view:View;
    public var fov:Number = 1.5707963267948966;
    public var nearClipping:Number = 1;
    public var farClipping:Number = 1000000;
    public var onRender:Function;

    alternativa3d var viewSizeX:Number;
    alternativa3d var viewSizeY:Number;
    alternativa3d var focalLength:Number;
    alternativa3d var lights:Vector.<Light3D> = new Vector.<Light3D>();
    alternativa3d var lightsLength:int = 0;
    alternativa3d var occluders:Vector.<Vertex> = new Vector.<Vertex>();
    alternativa3d var numOccluders:int;
    alternativa3d var occludedAll:Boolean;
    alternativa3d var numDraws:int;
    alternativa3d var numPolygons:int;
    alternativa3d var numTriangles:int;

    private var shadows:Dictionary = new Dictionary();

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
    private var polygonsTextField:TextField;
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
      var local1:Object3D = null;
      var local2:Light3D = null;
      var local3:int = 0;
      this.alternativa3d::numDraws = 0;
      this.alternativa3d::numPolygons = 0;
      this.alternativa3d::numTriangles = 0;
      if(this.view != null) {
        this.alternativa3d::viewSizeX = this.view.alternativa3d::_width * 0.5;
        this.alternativa3d::viewSizeY = this.view.alternativa3d::_height * 0.5;
        this.alternativa3d::focalLength = Math.sqrt(this.alternativa3d::viewSizeX * this.alternativa3d::viewSizeX + this.alternativa3d::viewSizeY * this.alternativa3d::viewSizeY) / Math.tan(this.fov * 0.5);
        this.alternativa3d::composeCameraMatrix();
        local1 = this;
        while(local1.alternativa3d::_parent != null) {
          local1 = local1.alternativa3d::_parent;
          local1.alternativa3d::composeMatrix();
          alternativa3d::appendMatrix(local1);
        }
        alternativa3d::invertMatrix();
        this.alternativa3d::numOccluders = 0;
        this.alternativa3d::occludedAll = false;
        this.view.alternativa3d::numDraws = 0;
        if(local1 != this && local1.visible) {
          this.alternativa3d::lightsLength = 0;
          local2 = (local1 as Object3DContainer).alternativa3d::lightList;
          while(local2 != null) {
            if(local2.visible) {
              local2.alternativa3d::calculateCameraMatrix(this);
              if(local2.alternativa3d::checkFrustumCulling(this)) {
                this.alternativa3d::lights[this.alternativa3d::lightsLength] = local2;
                ++this.alternativa3d::lightsLength;
              }
            }
            local2 = local2.alternativa3d::nextLight;
          }
          local1.alternativa3d::appendMatrix(this);
          if(local1.alternativa3d::cullingInCamera(this,63) >= 0) {
            if(this.debug) {
              local3 = 0;
              while(local3 < this.alternativa3d::lightsLength) {
                (this.alternativa3d::lights[local3] as Light3D).alternativa3d::drawDebug(this,this.view);
                local3++;
              }
            }
            local1.alternativa3d::draw(this,this.view);
            this.alternativa3d::deferredDestroy();
            this.alternativa3d::clearOccluders();
          }
        }
        this.view.alternativa3d::remChildren(this.view.alternativa3d::numDraws);
        this.view.alternativa3d::onRender(this);
        if(this.onRender != null) {
          this.onRender();
        }
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
      super.clonePropertiesFrom(param1);
      var local2:Camera3D = param1 as Camera3D;
      this.fov = local2.fov;
      this.nearClipping = local2.nearClipping;
      this.farClipping = local2.farClipping;
      this.debug = local2.debug;
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
        polygonsTextField = new TextField();
        polygonsTextField.defaultTextFormat = new TextFormat("Tahoma",10,16711731);
        polygonsTextField.autoSize = TextFieldAutoSize.LEFT;
        polygonsTextField.text = "PLG:";
        polygonsTextField.selectable = false;
        polygonsTextField.x = -3;
        polygonsTextField.y = 31;
        diagram.addChild(polygonsTextField);
        polygonsTextField = new TextField();
        polygonsTextField.defaultTextFormat = new TextFormat("Tahoma",10,16711731);
        polygonsTextField.autoSize = TextFieldAutoSize.RIGHT;
        polygonsTextField.text = "0";
        polygonsTextField.selectable = false;
        polygonsTextField.x = -3;
        polygonsTextField.y = 31;
        polygonsTextField.width = 52;
        diagram.addChild(polygonsTextField);
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
        polygonsTextField = null;
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
      this.polygonsTextField.text = String(this.alternativa3d::numPolygons);
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
      var local35:int = 0;
      var local36:Number = NaN;
      var local38:Boolean = false;
      var local39:Face = null;
      var local25:Boolean = (param2 & 1) > 0;
      var local26:Boolean = (param2 & 2) > 0;
      var local27:Boolean = (param2 & 4) > 0;
      var local28:Boolean = (param2 & 8) > 0;
      var local29:Boolean = (param2 & 0x10) > 0;
      var local30:Boolean = (param2 & 0x20) > 0;
      var local31:Number = this.nearClipping;
      var local32:Number = this.farClipping;
      var local33:Boolean = local27 || local28;
      var local34:Boolean = local29 || local30;
      var local37:Face = param1;
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
