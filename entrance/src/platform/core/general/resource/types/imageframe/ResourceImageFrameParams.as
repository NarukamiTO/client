package platform.core.general.resource.types.imageframe {
  public class ResourceImageFrameParams {
    private var _fps:Number;
    private var _frameHeight:int;
    private var _frameWidth:int;
    private var _imageHeight:int;
    private var _imageWidth:int;
    private var _numFrames:int;

    public function ResourceImageFrameParams(param1:Number = 0, param2:int = 0, param3:int = 0, param4:int = 0, param5:int = 0, param6:int = 0) {
      super();
      this._fps = param1;
      this._frameHeight = param2;
      this._frameWidth = param3;
      this._imageHeight = param4;
      this._imageWidth = param5;
      this._numFrames = param6;
    }

    public function get fps() : Number {
      return this._fps;
    }

    public function set fps(param1:Number) : void {
      this._fps = param1;
    }

    public function get frameHeight() : int {
      return this._frameHeight;
    }

    public function set frameHeight(param1:int) : void {
      this._frameHeight = param1;
    }

    public function get frameWidth() : int {
      return this._frameWidth;
    }

    public function set frameWidth(param1:int) : void {
      this._frameWidth = param1;
    }

    public function get imageHeight() : int {
      return this._imageHeight;
    }

    public function set imageHeight(param1:int) : void {
      this._imageHeight = param1;
    }

    public function get imageWidth() : int {
      return this._imageWidth;
    }

    public function set imageWidth(param1:int) : void {
      this._imageWidth = param1;
    }

    public function get numFrames() : int {
      return this._numFrames;
    }

    public function set numFrames(param1:int) : void {
      this._numFrames = param1;
    }

    public function toString() : String {
      var local1:String = "ResourceImageFrameParams [";
      local1 += "fps = " + this.fps + " ";
      local1 += "frameHeight = " + this.frameHeight + " ";
      local1 += "frameWidth = " + this.frameWidth + " ";
      local1 += "imageHeight = " + this.imageHeight + " ";
      local1 += "imageWidth = " + this.imageWidth + " ";
      local1 += "numFrames = " + this.numFrames + " ";
      return local1 + "]";
    }
  }
}
