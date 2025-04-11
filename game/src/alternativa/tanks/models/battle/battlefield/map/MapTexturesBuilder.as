package alternativa.tanks.models.battle.battlefield.map {
  import alternativa.tanks.engine3d.IndexedTextureConstructor;
  import alternativa.utils.TextureMaterialRegistry;
  import alternativa.utils.textureutils.ITextureConstructorListener;
  import alternativa.utils.textureutils.TextureConstructor;
  import flash.display.BitmapData;
  import flash.events.Event;
  import flash.events.EventDispatcher;

  public class MapTexturesBuilder extends EventDispatcher implements ITextureConstructorListener {
    private var materialRegistry:TextureMaterialRegistry;
    private var maxBatchSize:int;
    private var totalCounter:int;
    private var lastCollectionIndex:int;
    private var texturedPropsCollections:Vector.<TexturedPropsCollection>;
    private var constructors:Vector.<IndexedTextureConstructor>;
    private var killed:Boolean;
    private var textures:Vector.<BitmapData> = new Vector.<BitmapData>();

    public function MapTexturesBuilder(param1:TextureMaterialRegistry, param2:int) {
      super();
      this.materialRegistry = param1;
      this.maxBatchSize = param2;
    }

    public function destroy() : void {
      var local1:BitmapData = null;
      this.killed = true;
      this.texturedPropsCollections = null;
      this.constructors = null;
      for each(local1 in this.textures) {
        local1.dispose();
      }
      this.textures = null;
    }

    public function run(param1:Vector.<TexturedPropsCollection>) : void {
      this.texturedPropsCollections = param1.concat();
      this.totalCounter = 0;
      this.lastCollectionIndex = 0;
      this.createTextureConstructors();
      this.runConstructors();
    }

    private function createTextureConstructors() : void {
      this.constructors = new Vector.<IndexedTextureConstructor>(this.maxBatchSize);
      var local1:int = 0;
      while(local1 < this.maxBatchSize) {
        this.constructors[local1] = new IndexedTextureConstructor();
        local1++;
      }
    }

    private function runConstructors() : void {
      var local1:IndexedTextureConstructor = null;
      for each(local1 in this.constructors) {
        this.runConstructor(local1);
      }
    }

    private function runConstructor(param1:IndexedTextureConstructor) : void {
      var local2:TexturedPropsCollection = null;
      if(this.lastCollectionIndex < this.texturedPropsCollections.length) {
        param1.index = this.lastCollectionIndex;
        local2 = this.texturedPropsCollections[this.lastCollectionIndex++];
        param1.createTexture(local2.getTextureData(),this);
      }
    }

    [Obfuscation(rename="false")]
    public function onTextureReady(param1:TextureConstructor) : void {
      var local2:IndexedTextureConstructor = IndexedTextureConstructor(param1);
      if(this.killed) {
        local2.disposeTexture();
      } else {
        this.textures.push(local2.texture);
        this.assignMaterialToProps(local2);
        ++this.totalCounter;
        if(this.totalCounter == this.texturedPropsCollections.length) {
          this.complete();
        } else {
          this.runConstructor(local2);
        }
      }
    }

    private function assignMaterialToProps(param1:IndexedTextureConstructor) : void {
      var local2:TexturedPropsCollection = this.texturedPropsCollections[param1.index];
      local2.setMaterial(this.materialRegistry.getMaterial(param1.texture));
    }

    private function complete() : void {
      this.texturedPropsCollections = null;
      this.constructors = null;
      dispatchEvent(new Event(Event.COMPLETE));
    }

    public function getTextures() : Vector.<BitmapData> {
      return this.textures;
    }
  }
}
