package alternativa.tanks.services.mipmapping.impl {
  import alternativa.osgi.OSGi;
  import alternativa.osgi.service.command.FormattedOutput;
  import alternativa.tanks.services.mipmapping.MipMappingService;

  public class MipMappingServiceConsoleCommands {
    private var osgi:OSGi;

    public function MipMappingServiceConsoleCommands(param1:OSGi) {
      super();
      this.osgi = param1;
    }

    private function registerConsoleCommands(param1:OSGi) : void {
    }

    private function _showMipMapping(param1:FormattedOutput) : void {
    }

    private function _setMipMapping(param1:FormattedOutput, param2:int) : void {
    }

    private function getService() : MipMappingService {
      return MipMappingService(this.osgi.getService(MipMappingService));
    }
  }
}
