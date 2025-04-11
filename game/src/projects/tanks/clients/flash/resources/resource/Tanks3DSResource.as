package projects.tanks.clients.flash.resources.resource {
  import alternativa.engine3d.alternativa3d;
  import alternativa.engine3d.core.Clipping;
  import alternativa.engine3d.core.Object3D;
  import alternativa.engine3d.core.Sorting;
  import alternativa.engine3d.loaders.Parser3DS;
  import alternativa.engine3d.materials.TextureMaterial;
  import alternativa.engine3d.objects.Mesh;
  import alternativa.utils.textureutils.TextureByteData;
  import flash.display.BitmapData;
  import flash.events.ErrorEvent;
  import flash.events.Event;
  import flash.events.IOErrorEvent;
  import flash.events.SecurityErrorEvent;
  import flash.net.URLLoaderDataFormat;
  import flash.net.URLRequest;
  import flash.utils.ByteArray;
  import flash.utils.setTimeout;
  import platform.client.fp10.core.resource.IResourceLoadingListener;
  import platform.client.fp10.core.resource.IResourceSerializationListener;
  import platform.client.fp10.core.resource.Resource;
  import platform.client.fp10.core.resource.ResourceInfo;
  import platform.client.fp10.core.resource.SafeURLLoader;
  import platform.client.fp10.core.service.localstorage.IResourceLocalStorage;
  import projects.tanks.clients.flash.resources.resource.loaders.BatchTextureLoader;
  import projects.tanks.clients.flash.resources.resource.loaders.TextureInfo;
  import projects.tanks.clients.flash.resources.resource.loaders.events.BatchTextureLoaderErrorEvent;

  public class Tanks3DSResource extends Resource {
    [Inject]
    public static var resourceLocalStorage:IResourceLocalStorage;

    public static const TYPE:int = 17;

    private static const LOADING_STATE_INFO:int = 1;
    private static const LOADING_STATE_TEXTURE_INFO:int = LOADING_STATE_INFO + 1;
    private static const LOADING_STATE_TEXTURES:int = LOADING_STATE_INFO + 2;
    private static const LOADING_STATE_3DS:int = LOADING_STATE_INFO + 3;

    protected static const BIT_LOADED_WITH_ERROR:int = 1 << 2;
    protected static const BIT_LOCAL:int = 1 << 3;

    private static const IMAGES_FILE:String = "images.xml";
    private static const MODEL_FILE:String = "object.3ds";

    public var textures:Object;
    public var objects:Vector.<Object3D>;
    public var parents:Vector.<Object3D>;

    private var urlLoader:SafeURLLoader;
    private var batchTextureLoader:BatchTextureLoader;
    private var resourceData:ResourceData = new ResourceData();
    private var _modelBytes:ByteArray;
    private var loadingState:int = -1;

    public function Tanks3DSResource(param1:ResourceInfo) {
      super(param1);
    }

    override public function get description() : String {
      return "3DS";
    }

    public function getTextureForObject(param1:int) : BitmapData {
      var local2:Mesh = this.objects[param1] as Mesh;
      if(local2 == null || local2.alternativa3d::faceList == null) {
        return null;
      }
      var local3:TextureMaterial = local2.alternativa3d::faceList.material as TextureMaterial;
      if(local3 == null) {
        return null;
      }
      return this.textures[local3.diffuseMapURL];
    }

    public function getObjectsByName(param1:RegExp) : Vector.<Object3D> {
      var local5:Object3D = null;
      var local2:Vector.<Object3D> = null;
      var local3:int = int(this.objects.length);
      var local4:int = 0;
      while(local4 < local3) {
        local5 = this.objects[local4];
        if(local5.name != null && local5.name.match(param1) != null) {
          if(local2 == null) {
            local2 = new Vector.<Object3D>();
          }
          local2.push(local5);
        }
        local4++;
      }
      return local2;
    }

    override public function close() : void {
      switch(this.loadingState) {
        case LOADING_STATE_TEXTURE_INFO:
          this.urlLoader.close();
          this.destroyTextureInfoLoader();
          break;
        case LOADING_STATE_TEXTURES:
          this.batchTextureLoader.close();
          break;
        case LOADING_STATE_3DS:
          this.urlLoader.close();
      }
      this.textures = null;
      this.batchTextureLoader = null;
      this.urlLoader = null;
    }

    override public function unload() : void {
      var local1:BitmapData = null;
      if(this.textures != null) {
        for each(local1 in this.textures) {
          local1.dispose();
        }
      }
    }

    override public function load(param1:String, param2:IResourceLoadingListener) : void {
      super.load(param1,param2);
      this.loadTextureInfo();
    }

    override protected function doReload() : void {
      switch(this.loadingState) {
        case LOADING_STATE_TEXTURE_INFO:
          this.urlLoader.close();
          this.destroyTextureInfoLoader();
          this.loadTextureInfo();
          break;
        case LOADING_STATE_TEXTURES:
          this.batchTextureLoader.reload();
          break;
        case LOADING_STATE_3DS:
          this.urlLoader.close();
          this.destroyModelLoader();
          this.loadModel();
      }
    }

    override public function loadBytes(param1:ByteArray, param2:IResourceLoadingListener) : Boolean {
      var local6:String = null;
      var local7:int = 0;
      var local8:ByteArray = null;
      var local9:int = 0;
      var local10:ByteArray = null;
      this.listener = param2;
      var local3:int = param1.readInt();
      this.resourceData.modelData = new ByteArray();
      param1.readBytes(this.resourceData.modelData,0,local3);
      this._modelBytes = this.resourceData.modelData;
      var local4:int = param1.readInt();
      var local5:int = 0;
      while(local5 < local4) {
        local6 = param1.readUTF();
        local7 = param1.readInt();
        local8 = new ByteArray();
        param1.readBytes(local8,0,local7);
        local9 = param1.readInt();
        local10 = null;
        if(local9 > 0) {
          local10 = new ByteArray();
          param1.readBytes(local10,0,local9);
        }
        this.resourceData.imageData.push(new ImageData(local6,new TextureByteData(local8,local10)));
        local5++;
      }
      this.buildResourceData();
      return true;
    }

    override public function serialize(param1:IResourceSerializationListener) : void {
      var local5:ImageData = null;
      var local2:ByteArray = new ByteArray();
      local2.writeInt(this.resourceData.modelData.length);
      local2.writeBytes(this.resourceData.modelData);
      var local3:uint = this.resourceData.imageData.length;
      local2.writeInt(local3);
      var local4:int = 0;
      while(local4 < local3) {
        local5 = this.resourceData.imageData[local4];
        local2.writeUTF(local5.name);
        local2.writeInt(local5.data.diffuseData.length);
        local2.writeBytes(local5.data.diffuseData);
        if(local5.data.opacityData == null) {
          local2.writeInt(0);
        } else {
          local2.writeInt(local5.data.opacityData.length);
          local2.writeBytes(local5.data.opacityData);
        }
        local4++;
      }
      this.resourceData = null;
      param1.onSerializationComplete(this,local2);
    }

    private function loadTextureInfo() : void {
      this.urlLoader = new SafeURLLoader();
      this.urlLoader.addEventListener(Event.OPEN,this.onImagesXMLLoadingOpen);
      this.urlLoader.addEventListener(Event.COMPLETE,this.onImagesXMLLoadingComplete);
      this.urlLoader.addEventListener(IOErrorEvent.IO_ERROR,this.onFatalError);
      this.urlLoader.addEventListener(SecurityErrorEvent.SECURITY_ERROR,this.onFatalError);
      this.urlLoader.load(new URLRequest(baseUrl + IMAGES_FILE));
      startTimeoutTracking();
      this.loadingState = LOADING_STATE_TEXTURE_INFO;
    }

    private function onImagesXMLLoadingOpen(param1:Event) : void {
      updateLastActivityTime();
    }

    private function onImagesXMLLoadingComplete(param1:Event) : void {
      var local5:XML = null;
      var local2:XML = XML(this.urlLoader.data);
      this.destroyTextureInfoLoader();
      if(local2.name() != "images") {
        throw new Error("Invalid map.xml contents. ResourceId=" + this.id);
      }
      var local3:Object = {};
      var local4:int = 0;
      for each(local5 in local2.image) {
        local4++;
        local3[local5.@name] = new TextureInfo(local5.attribute("new-name"),local5.@alpha);
      }
      if(local4 > 0) {
        this.batchTextureLoader = new BatchTextureLoader(local3);
        this.batchTextureLoader.addEventListener(Event.OPEN,this.onBitmapsLoadingOpen);
        this.batchTextureLoader.addEventListener(Event.COMPLETE,this.onTexturesLoadingComplete);
        this.batchTextureLoader.addEventListener(BatchTextureLoaderErrorEvent.LOADER_ERROR,this.onBatchLoadingError);
        this.batchTextureLoader.load(baseUrl);
        this.loadingState = LOADING_STATE_TEXTURES;
        startTimeoutTracking();
      } else {
        this.loadModel();
      }
    }

    private function onBatchLoadingError(param1:BatchTextureLoaderErrorEvent) : void {
      setFlags(BIT_LOADED_WITH_ERROR);
    }

    private function onBitmapsLoadingOpen(param1:Event) : void {
      updateLastActivityTime();
    }

    private function onTexturesLoadingComplete(param1:Event) : void {
      var local3:String = null;
      var local2:Object = this.batchTextureLoader.textures.data;
      for(local3 in local2) {
        this.resourceData.imageData.push(new ImageData(local3,this.batchTextureLoader.textures.getValue(local3)));
      }
      this.destroyBatchLoader();
      this.loadModel();
    }

    private function loadModel() : void {
      this.urlLoader = new SafeURLLoader();
      this.urlLoader.dataFormat = URLLoaderDataFormat.BINARY;
      this.urlLoader.addEventListener(Event.OPEN,this.onModelLoadingOpen);
      this.urlLoader.addEventListener(Event.COMPLETE,this.onModelLoadingComplete);
      this.urlLoader.addEventListener(IOErrorEvent.IO_ERROR,this.onFatalError);
      this.urlLoader.addEventListener(SecurityErrorEvent.SECURITY_ERROR,this.onFatalError);
      this.urlLoader.load(new URLRequest(baseUrl + MODEL_FILE));
      this.loadingState = LOADING_STATE_3DS;
      startTimeoutTracking();
    }

    private function onModelLoadingOpen(param1:Event) : void {
      updateLastActivityTime();
    }

    private function onModelLoadingComplete(param1:Event) : void {
      this.resourceData.modelData = this.urlLoader.data;
      this._modelBytes = this.resourceData.modelData;
      this.destroyModelLoader();
      this.buildResourceData();
    }

    private function buildResourceData() : void {
      var local3:Mesh = null;
      var local1:Parser3DS = new Parser3DS();
      local1.parse(this.resourceData.modelData);
      this.objects = local1.objects;
      this.parents = local1.parents;
      var local2:int = 0;
      while(local2 < this.objects.length) {
        local3 = this.objects[local2] as Mesh;
        if(local3 != null) {
          this.initMesh(local3);
        }
        local2++;
      }
      if(this.resourceData.imageData.length > 0) {
        this.resourceData.batchConstructor.addEventListener(Event.COMPLETE,this.onTexturesComplete);
        this.resourceData.batchConstructor.run(4,this.resourceData.imageData);
      } else {
        this.completeResourceLoading(false);
      }
    }

    private function onTexturesComplete(param1:Event) : void {
      this.textures = this.resourceData.batchConstructor.textures;
      this.completeResourceLoading(true);
    }

    private function completeResourceLoading(param1:Boolean) : void {
      if(Boolean(hasAnyFlags(BIT_LOADED_WITH_ERROR | BIT_LOCAL)) || !resourceLocalStorage.enabled) {
        this.resourceData = null;
      }
      if(param1) {
        completeLoading();
      } else {
        setTimeout(completeLoading,0);
      }
    }

    private function initMesh(param1:Mesh) : void {
      param1.weldVertices(0.001,0.0001);
      param1.weldFaces(0.01,0.001,0.01);
      param1.calculateVerticesNormalsByAngle(ResourceParams.ANGLE_THRESHOLD,0.01);
      param1.clipping = Clipping.FACE_CLIPPING;
      param1.sorting = Sorting.AVERAGE_Z;
      param1.calculateBounds();
    }

    private function onFatalError(param1:ErrorEvent) : void {
      listener.onResourceLoadingFatalError(this,param1.text);
    }

    private function destroyTextureInfoLoader() : void {
      if(this.urlLoader != null) {
        this.urlLoader.removeEventListener(Event.OPEN,this.onImagesXMLLoadingOpen);
        this.urlLoader.removeEventListener(Event.COMPLETE,this.onImagesXMLLoadingComplete);
        this.urlLoader.removeEventListener(IOErrorEvent.IO_ERROR,this.onFatalError);
        this.urlLoader.removeEventListener(SecurityErrorEvent.SECURITY_ERROR,this.onFatalError);
        this.urlLoader = null;
      }
    }

    private function destroyBatchLoader() : void {
      if(this.batchTextureLoader != null) {
        this.batchTextureLoader.removeEventListener(Event.OPEN,this.onBitmapsLoadingOpen);
        this.batchTextureLoader.removeEventListener(Event.COMPLETE,this.onTexturesLoadingComplete);
        this.batchTextureLoader.removeEventListener(BatchTextureLoaderErrorEvent.LOADER_ERROR,this.onBatchLoadingError);
        this.batchTextureLoader = null;
      }
    }

    private function destroyModelLoader() : void {
      if(this.urlLoader != null) {
        this.urlLoader.removeEventListener(Event.OPEN,this.onModelLoadingOpen);
        this.urlLoader.removeEventListener(Event.COMPLETE,this.onModelLoadingComplete);
        this.urlLoader.removeEventListener(IOErrorEvent.IO_ERROR,this.onFatalError);
        this.urlLoader.removeEventListener(SecurityErrorEvent.SECURITY_ERROR,this.onFatalError);
        this.urlLoader = null;
      }
    }
  }
}

import alternativa.utils.textureutils.ITextureConstructorListener;
import alternativa.utils.textureutils.TextureByteData;
import alternativa.utils.textureutils.TextureConstructor;
import flash.events.Event;
import flash.events.EventDispatcher;
import flash.utils.ByteArray;
class ResourceData {
  public var modelData:ByteArray;
  public var imageData:Vector.<ImageData> = new Vector.<ImageData>();
  public var batchConstructor:BatchTextureConstructor = new BatchTextureConstructor();

  public function ResourceData() {
    super();
  }
}

class ImageData {
  public var name:String;
  public var data:TextureByteData = new TextureByteData();

  public function ImageData(param1:String, param2:TextureByteData) {
    super();
    this.name = param1;
    this.data = param2;
  }
}

class BatchTextureConstructor extends EventDispatcher implements ITextureConstructorListener {
  public var textures:Object;

  private var entries:Vector.<ImageData>;
  private var maxBatchSize:int;
  private var batchSize:int;
  private var firstBatchIndex:int;
  private var batchCouner:int;
  private var totalCounter:int;
  private var constructors:Vector.<IndexedTextureConstructor>;

  public function BatchTextureConstructor() {
    super();
  }

  public function run(param1:int, param2:Vector.<ImageData>) : void {
    this.maxBatchSize = param1;
    this.entries = param2;
    this.textures = {};
    this.constructors = new Vector.<IndexedTextureConstructor>(param1);
    var local3:int = 0;
    while(local3 < param1) {
      this.constructors[local3] = new IndexedTextureConstructor();
      local3++;
    }
    this.totalCounter = 0;
    this.firstBatchIndex = 0;
    this.createBatch();
  }

  private function createBatch() : void {
    var local3:IndexedTextureConstructor = null;
    this.batchCouner = 0;
    var local1:int = this.firstBatchIndex + this.maxBatchSize;
    if(local1 > this.entries.length) {
      local1 = int(this.entries.length);
    }
    this.batchSize = local1 - this.firstBatchIndex;
    var local2:int = 0;
    while(local2 < this.batchSize) {
      local3 = this.constructors[local2];
      local3.index = this.firstBatchIndex + local2;
      local3.createTexture(this.entries[local3.index].data,this);
      local2++;
    }
    this.firstBatchIndex = local1;
  }

  private function complete() : void {
    this.constructors = null;
    this.entries = null;
    dispatchEvent(new Event(Event.COMPLETE));
  }

  public function onTextureReady(param1:TextureConstructor) : void {
    var local2:IndexedTextureConstructor = IndexedTextureConstructor(param1);
    this.textures[this.entries[local2.index].name] = local2.texture;
    ++this.totalCounter;
    ++this.batchCouner;
    if(this.totalCounter == this.entries.length) {
      this.complete();
    } else if(this.batchCouner == this.batchSize) {
      this.createBatch();
    }
  }
}

class IndexedTextureConstructor extends TextureConstructor {
  public var index:int;
  public function IndexedTextureConstructor() {
    super();
  }
}
