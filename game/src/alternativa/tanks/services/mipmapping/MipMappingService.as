package alternativa.tanks.services.mipmapping {
  import alternativa.utils.TextureMaterialRegistry;

  public interface MipMappingService {
    function isMipMappingEnabled() : Boolean;
    function setMipMapping(param1:Boolean) : void;
    function toggleMipMapping() : void;
    function addMaterialRegistry(param1:TextureMaterialRegistry) : void;
  }
}
