package alternativa.gfx.core {
  import alternativa.engine3d.materials.TextureResourcesRegistry;
  import alternativa.gfx.alternativagfx;
  import flash.display.BitmapData;
  import flash.display3D.Context3D;
  import flash.display3D.Context3DTextureFormat;
  import flash.display3D.textures.Texture;
  import flash.geom.Matrix;
  import flash.geom.Point;
  import flash.geom.Rectangle;

  use namespace alternativagfx;

  public class BitmapTextureResource extends TextureResource {
    private static var nullTexture:Texture;
    private static var nullTextureContext:Context3D;

    private static const point:Point = new Point();
    private static const rectangle:Rectangle = new Rectangle();
    private static const matrix:Matrix = new Matrix();

    private var referencesCount:int = 1;
    private var _bitmapData:BitmapData;
    private var _mipMapping:Boolean;
    private var _stretchNotPowerOf2Textures:Boolean;
    private var _calculateMipMapsUsingGPU:Boolean;
    private var _correctionU:Number = 1;
    private var _correctionV:Number = 1;
    private var correctedWidth:int;
    private var correctedHeight:int;

    public function BitmapTextureResource(param1:BitmapData, param2:Boolean, param3:Boolean = false, param4:Boolean = false) {
      super();
      this._bitmapData = param1;
      this._mipMapping = param2;
      this._stretchNotPowerOf2Textures = param3;
      this._calculateMipMapsUsingGPU = param4;
      this.correctedWidth = Math.pow(2,Math.ceil(Math.log(this._bitmapData.width) / Math.LN2));
      this.correctedHeight = Math.pow(2,Math.ceil(Math.log(this._bitmapData.height) / Math.LN2));
      if(this.correctedWidth > 2048) {
        this.correctedWidth = 2048;
      }
      if(this.correctedHeight > 2048) {
        this.correctedHeight = 2048;
      }
      if((this._bitmapData.width != this.correctedWidth || this._bitmapData.height != this.correctedHeight) && !this._stretchNotPowerOf2Textures && this._bitmapData.width <= 2048 && this._bitmapData.height <= 2048) {
        this._correctionU = this._bitmapData.width / this.correctedWidth;
        this._correctionV = this._bitmapData.height / this.correctedHeight;
      }
    }

    public function get bitmapData() : BitmapData {
      return this._bitmapData;
    }

    public function get mipMapping() : Boolean {
      return this._mipMapping;
    }

    public function get stretchNotPowerOf2Textures() : Boolean {
      return this._stretchNotPowerOf2Textures;
    }

    public function get correctionU() : Number {
      return this._correctionU;
    }

    public function get correctionV() : Number {
      return this._correctionV;
    }

    public function get calculateMipMapsUsingGPU() : Boolean {
      return this._calculateMipMapsUsingGPU;
    }

    public function set calculateMipMapsUsingGPU(param1:Boolean) : void {
      this._calculateMipMapsUsingGPU = param1;
    }

    public function forceDispose() : void {
      this.referencesCount = 1;
      this.dispose();
      this._bitmapData = null;
    }

    override public function dispose() : void {
      if(this.referencesCount == 0) {
        return;
      }
      --this.referencesCount;
      if(this.referencesCount == 0) {
        TextureResourcesRegistry.release(this._bitmapData);
        this._bitmapData = null;
        super.dispose();
      }
    }

    override public function get available() : Boolean {
      return this._bitmapData != null;
    }

    override protected function getNullTexture() : Texture {
      return nullTexture;
    }

    private function freeMemory() : void {
      useNullTexture = true;
      this._mipMapping = false;
      this.forceDispose();
    }

    override alternativagfx function create(param1:Context3D) : void {
      var context:Context3D = param1;
      super.alternativagfx::create(context);
      if(nullTexture == null || nullTextureContext != context) {
        nullTexture = context.createTexture(1,1,Context3DTextureFormat.BGRA,false);
        nullTexture.uploadFromBitmapData(new BitmapData(1,1,true,1439485132));
        nullTextureContext = context;
      }
      if(!useNullTexture) {
        try {
          texture = context.createTexture(this.correctedWidth,this.correctedHeight,Context3DTextureFormat.BGRA,false);
        }
        catch(e:Error) {
          freeMemory();
        }
      }
    }

    override alternativagfx function upload() : void {
      var local1:BitmapData = null;
      var local2:BitmapData = null;
      var local3:int = 0;
      var local4:int = 0;
      var local5:int = 0;
      var local6:BitmapData = null;
      if(useNullTexture) {
        return;
      }
      if(this._bitmapData.width == this.correctedWidth && this._bitmapData.height == this.correctedHeight) {
        local1 = this._bitmapData;
      } else {
        local1 = new BitmapData(this.correctedWidth,this.correctedHeight,this._bitmapData.transparent,0);
        if(this._bitmapData.width <= 2048 && this._bitmapData.height <= 2048 && !this._stretchNotPowerOf2Textures) {
          local1.copyPixels(this._bitmapData,this._bitmapData.rect,point);
          if(this._bitmapData.width < local1.width) {
            local2 = new BitmapData(1,this._bitmapData.height,this._bitmapData.transparent,0);
            rectangle.setTo(this._bitmapData.width - 1,0,1,this._bitmapData.height);
            local2.copyPixels(this._bitmapData,rectangle,point);
            matrix.setTo(local1.width - this._bitmapData.width,0,0,1,this._bitmapData.width,0);
            local1.draw(local2,matrix,null,null,null,false);
            local2.dispose();
          }
          if(this._bitmapData.height < local1.height) {
            local2 = new BitmapData(this._bitmapData.width,1,this._bitmapData.transparent,0);
            rectangle.setTo(0,this._bitmapData.height - 1,this._bitmapData.width,1);
            local2.copyPixels(this._bitmapData,rectangle,point);
            matrix.setTo(1,0,0,local1.height - this._bitmapData.height,0,this._bitmapData.height);
            local1.draw(local2,matrix,null,null,null,false);
            local2.dispose();
          }
          if(this._bitmapData.width < local1.width && this._bitmapData.height < local1.height) {
            local2 = new BitmapData(1,1,this._bitmapData.transparent,0);
            rectangle.setTo(this._bitmapData.width - 1,this._bitmapData.height - 1,1,1);
            local2.copyPixels(this._bitmapData,rectangle,point);
            matrix.setTo(local1.width - this._bitmapData.width,0,0,local1.height - this._bitmapData.height,this._bitmapData.width,this._bitmapData.height);
            local1.draw(local2,matrix,null,null,null,false);
            local2.dispose();
          }
        } else {
          matrix.setTo(this.correctedWidth / this._bitmapData.width,0,0,this.correctedHeight / this._bitmapData.height,0,0);
          local1.draw(this._bitmapData,matrix,null,null,null,true);
        }
      }
      if(this._mipMapping > 0) {
        this.uploadTexture(local1,0);
        matrix.identity();
        local3 = 1;
        local4 = local1.width;
        local5 = local1.height;
        while(local4 % 2 == 0 || local5 % 2 == 0) {
          local4 >>= 1;
          local5 >>= 1;
          if(local4 == 0) {
            local4 = 1;
          }
          if(local5 == 0) {
            local5 = 1;
          }
          local6 = new BitmapData(local4,local5,local1.transparent,0);
          matrix.a = local4 / local1.width;
          matrix.d = local5 / local1.height;
          local6.draw(local1,matrix,null,null,null,false);
          this.uploadTexture(local6,local3++);
          local6.dispose();
        }
      } else {
        this.uploadTexture(local1,0);
      }
      if(local1 != this._bitmapData) {
        local1.dispose();
      }
    }

    protected function uploadTexture(param1:BitmapData, param2:uint) : void {
      var source:BitmapData = param1;
      var mipLevel:uint = param2;
      try {
        if(texture != nullTexture) {
          texture.uploadFromBitmapData(source,mipLevel);
        }
      }
      catch(e:Error) {
        freeMemory();
      }
    }

    public function increaseReferencesCount() : void {
      ++this.referencesCount;
    }
  }
}
