package alternativa.tanks.services.mipmapping.impl {
  import alternativa.tanks.services.mipmapping.*;
  import alternativa.utils.TextureMaterialRegistry;

  public class DefaultMipMappingService implements MipMappingService {
    private var mipMappingEnabled:Boolean;
    private var materialRegistries:Vector.<TextureMaterialRegistry> = new Vector.<TextureMaterialRegistry>();

    public function DefaultMipMappingService() {
      super();
    }

    public function isMipMappingEnabled() : Boolean {
      return this.mipMappingEnabled;
    }

    public function setMipMapping(param1:Boolean) : void {
      var local2:TextureMaterialRegistry = null;
      if(this.mipMappingEnabled != param1) {
        this.mipMappingEnabled = param1;
        for each(local2 in this.materialRegistries) {
          local2.setMipMapping(param1);
        }
      }
    }

    public function toggleMipMapping() : void {
      this.setMipMapping(!this.mipMappingEnabled);
    }

    public function addMaterialRegistry(param1:TextureMaterialRegistry) : void {
      this.materialRegistries.push(param1);
      param1.setMipMapping(this.mipMappingEnabled);
    }
  }
}
