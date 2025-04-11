package platform.client.fp10.core.resource {
  import flash.display.Bitmap;
  import flash.display.BitmapData;
  import flash.display.LoaderInfo;
  import flash.events.Event;
  import flash.events.EventDispatcher;
  import flash.utils.ByteArray;
  import flash.utils.Dictionary;
  import flash.utils.setTimeout;

  public class BatchImageConstructor extends EventDispatcher {
    public var images:Vector.<BitmapData>;

    private var imageBytes:Vector.<ByteArray>;
    private var loaders:Dictionary = new Dictionary();
    private var maxParallelThreads:int;
    private var numRunningLoaders:int;
    private var lastImageIndex:int;
    private var isRunning:Boolean;
    private var numCreatedImages:int;

    public function BatchImageConstructor() {
      super();
    }

    public function buildImages(param1:Vector.<ByteArray>, param2:int) : void {
      if(this.isRunning) {
        throw new Error("Already running");
      }
      if(param1 == null) {
        throw new ArgumentError("Parameter imageDatas is null");
      }
      this.imageBytes = param1;
      this.maxParallelThreads = param2;
      this.isRunning = true;
      this.images = new Vector.<BitmapData>(param1.length);
      this.numCreatedImages = 0;
      this.numRunningLoaders = 0;
      this.lastImageIndex = 0;
      if(param1.length > 0) {
        this.runLoaders();
      } else {
        setTimeout(this.complete,0);
      }
    }

    private function runLoaders() : void {
      var local1:ImageLoader = null;
      while(this.numRunningLoaders < this.maxParallelThreads && this.lastImageIndex < this.imageBytes.length) {
        local1 = this.createLoader(this.lastImageIndex);
        this.loaders[local1] = true;
        ++this.numRunningLoaders;
        ++this.lastImageIndex;
      }
    }

    private function onImageComplete(param1:Event) : void {
      var local2:ImageLoader = ImageLoader(LoaderInfo(param1.target).loader);
      --this.numRunningLoaders;
      ++this.numCreatedImages;
      delete this.loaders[local2];
      this.images[local2.index] = Bitmap(local2.content).bitmapData;
      if(this.numCreatedImages == this.imageBytes.length) {
        this.complete();
      } else {
        this.runLoaders();
      }
    }

    private function createLoader(param1:int) : ImageLoader {
      var local2:ImageLoader = new ImageLoader(param1);
      local2.contentLoaderInfo.addEventListener(Event.COMPLETE,this.onImageComplete);
      local2.loadBytes(this.imageBytes[this.lastImageIndex]);
      return local2;
    }

    private function complete() : void {
      this.isRunning = false;
      this.imageBytes = null;
      dispatchEvent(new Event(Event.COMPLETE));
    }
  }
}

import flash.display.DisplayObject;
import flash.display.DisplayObjectContainer;
import flash.display.InteractiveObject;
import flash.display.Loader;
import flash.events.EventDispatcher;
class ImageLoader extends Loader {
  public var index:int;

  public function ImageLoader(param1:int) {
    super();
    this.index = param1;
  }
}
