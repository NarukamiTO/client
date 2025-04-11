package alternativa.tanks.services.colortransform {
  import alternativa.osgi.OSGi;
  import alternativa.osgi.service.command.FormattedOutput;

  public class ColorTransformServiceConsoleCommands {
    private static var keys:Array;

    private var osgi:OSGi;

    public function ColorTransformServiceConsoleCommands(param1:OSGi) {
      super();
      this.osgi = param1;
    }

    private function initKeys() : void {
    }

    private function initConsoleCommands(param1:OSGi) : void {
    }

    private function _cmdShowColorTransform(param1:FormattedOutput) : void {
    }

    private function _cmdSetColorTransform(param1:FormattedOutput, param2:String) : void {
    }

    private function getColorTransformService() : ColorTransformService {
      return ColorTransformService(this.osgi.getService(ColorTransformService));
    }
  }
}
