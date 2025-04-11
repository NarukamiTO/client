package alternativa.tanks.engine3d {
  import alternativa.engine3d.core.MipMapping;
  import alternativa.engine3d.materials.TextureMaterial;
  import alternativa.tanks.battle.BattleService;
  import alternativa.tanks.materials.AnimatedPaintMaterial;
  import alternativa.tanks.materials.PaintMaterial;
  import alternativa.types.Long;
  import alternativa.utils.TextureMaterialRegistry;
  import alternativa.utils.clearDictionary;
  import flash.display.BitmapData;
  import flash.utils.Dictionary;
  import platform.client.fp10.core.resource.types.MultiframeTextureResource;
  import platform.client.fp10.core.resource.types.TextureResource;

  public class TextureMaterialRegistryBase implements TextureMaterialRegistry {
    [Inject]
    public static var battleService:BattleService;

    private var materialStat:CachedEntityStat = new CachedEntityStat();
    private var materialFactory:TextureMaterialFactory;
    private var mipMappingEnabled:Boolean;

    private const materials:Vector.<TextureMaterial> = new Vector.<TextureMaterial>();
    private const entryForTexture:Dictionary = new Dictionary();
    private const entryForMaterial:Dictionary = new Dictionary();

    public function TextureMaterialRegistryBase(param1:TextureMaterialFactory) {
      super();
      this.materialFactory = param1;
    }

    public function getMaterialStat() : CachedEntityStat {
      return this.materialStat;
    }

    public function getAnimatedPaint(param1:MultiframeTextureResource, param2:BitmapData, param3:BitmapData, param4:Long) : AnimatedPaintMaterial {
      var local9:MaterialEntry = null;
      ++this.materialStat.requestCount;
      var local5:String = param1.id + " " + param4;
      if(local5 in this.entryForTexture) {
        local9 = this.entryForTexture[local5];
        ++local9.referenceCount;
        return local9.material as AnimatedPaintMaterial;
      }
      var local6:int = param1.data.width / param1.frameWidth;
      var local7:int = param1.data.height / param1.frameHeight;
      var local8:AnimatedPaintMaterial = new AnimatedPaintMaterial(param1.data,param2,param3,local6,local7,param1.fps,param1.numFrames,this.mipMappingEnabled ? int(MipMapping.PER_PIXEL) : 0);
      local9 = this.createPaintMaterialEntry(local5,local8);
      ++local9.referenceCount;
      this.materials.push(local8);
      ++this.materialStat.createCount;
      return local8;
    }

    public function getPaint(param1:TextureResource, param2:BitmapData, param3:BitmapData, param4:Long) : PaintMaterial {
      var local7:MaterialEntry = null;
      ++this.materialStat.requestCount;
      var local5:String = param1.id + " " + param4;
      if(local5 in this.entryForTexture) {
        local7 = this.entryForTexture[local5];
        ++local7.referenceCount;
        return local7.material as PaintMaterial;
      }
      var local6:PaintMaterial = new PaintMaterial(param1.data,param2,param3,this.mipMappingEnabled ? int(MipMapping.PER_PIXEL) : 0);
      local7 = this.createPaintMaterialEntry(local5,local6);
      ++local7.referenceCount;
      this.materials.push(local6);
      ++this.materialStat.createCount;
      return local6;
    }

    public function getMaterial(param1:BitmapData, param2:Boolean = true) : TextureMaterial {
      if(param1 == null) {
        throw new ArgumentError("Texture is null");
      }
      ++this.materialStat.requestCount;
      var local3:MaterialEntry = this.getOrCreateEntry(param1,param2);
      ++local3.referenceCount;
      return local3.material;
    }

    private function getOrCreateEntry(param1:BitmapData, param2:Boolean) : MaterialEntry {
      var local4:TextureMaterial = null;
      var local3:MaterialEntry = this.entryForTexture[param1];
      if(local3 == null) {
        local4 = this.createMaterial(param1,param2);
        local3 = this.createMaterialEntry(param1,local4);
      }
      return local3;
    }

    private function createMaterial(param1:BitmapData, param2:Boolean) : TextureMaterial {
      var local3:BitmapData = this.getTexture(param1,param2);
      var local4:TextureMaterial = this.materialFactory.createTextureMaterial(local3,this.mipMappingEnabled);
      this.materials.push(local4);
      ++this.materialStat.createCount;
      return local4;
    }

    protected function getTexture(param1:BitmapData, param2:Boolean) : BitmapData {
      throw new Error("Not implemented");
    }

    private function createPaintMaterialEntry(param1:String, param2:TextureMaterial) : MaterialEntry {
      var local3:MaterialEntry = new MaterialEntry(param1,param2);
      this.entryForTexture[param1] = local3;
      this.entryForMaterial[param2] = local3;
      return local3;
    }

    private function createMaterialEntry(param1:BitmapData, param2:TextureMaterial) : MaterialEntry {
      var local3:MaterialEntry = new MaterialEntry(param1,param2);
      this.entryForTexture[param1] = local3;
      this.entryForMaterial[param2] = local3;
      return local3;
    }

    public function addMaterial(param1:TextureMaterial) : void {
      var local2:MaterialEntry = this.createMaterialEntry(null,param1);
      ++local2.referenceCount;
      this.entryForMaterial[param1] = local2;
      this.materials.push(param1);
    }

    public function releaseMaterial(param1:TextureMaterial) : void {
      if(param1 == null) {
        return;
      }
      var local2:MaterialEntry = this.entryForMaterial[param1];
      if(local2 != null) {
        ++this.materialStat.releaseCount;
        --local2.referenceCount;
        if(local2.referenceCount == 0) {
          this.removeMaterialEntry(local2);
        }
      }
    }

    private function removeMaterialEntry(param1:MaterialEntry) : void {
      ++this.materialStat.destroyCount;
      var local2:TextureMaterial = param1.material;
      if(param1.keyData in this.entryForTexture) {
        delete this.entryForTexture[param1.keyData];
      }
      delete this.entryForMaterial[local2];
      param1.material = null;
      var local3:int = int(this.materials.indexOf(local2));
      this.materials.splice(local3,1);
      local2.dispose();
    }

    protected function forEachMaterial(param1:Function) : void {
      var local2:TextureMaterial = null;
      for each(local2 in this.materials) {
        param1(local2);
      }
    }

    public function setMipMapping(param1:Boolean) : void {
      if(this.mipMappingEnabled != param1) {
        if(param1) {
          this.enableMipMapping();
        } else {
          this.disableMipMapping();
        }
      }
    }

    private function enableMipMapping() : void {
      if(!this.mipMappingEnabled) {
        this.mipMappingEnabled = true;
        this.forEachMaterial(this.disposeResource);
        this.forEachMaterial(this._enableMipMapping);
      }
    }

    private function _enableMipMapping(param1:TextureMaterial) : void {
      param1.mipMapping = MipMapping.PER_PIXEL;
    }

    private function disableMipMapping() : void {
      if(this.mipMappingEnabled) {
        this.mipMappingEnabled = false;
        this.forEachMaterial(this.disposeResource);
        this.forEachMaterial(this._disableMipMapping);
      }
    }

    private function disposeResource(param1:TextureMaterial) : void {
      param1.disposeResource();
    }

    private function _disableMipMapping(param1:TextureMaterial) : void {
      param1.mipMapping = MipMapping.NONE;
    }

    public function clear() : void {
      this.forEachMaterial(this._clearTexture);
      this.materials.length = 0;
      clearDictionary(this.entryForTexture);
      clearDictionary(this.entryForMaterial);
      this.materialStat.clear();
    }

    private function _clearTexture(param1:TextureMaterial) : void {
      param1.texture = null;
    }

    protected function getEntry(param1:TextureMaterial) : MaterialEntry {
      return this.entryForMaterial[param1];
    }
  }
}
