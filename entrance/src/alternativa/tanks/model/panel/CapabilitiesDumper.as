package alternativa.tanks.model.panel {
  import alternativa.osgi.service.dump.IDumper;
  import flash.system.Capabilities;

  public class CapabilitiesDumper implements IDumper {
    public function CapabilitiesDumper() {
      super();
    }

    public function dump(param1:Array) : String {
      return "Capabilities" + "\n os: " + Capabilities.os + "\n version: " + Capabilities.version + "\n playerType: " + Capabilities.playerType + "\n isDebugger: " + Capabilities.isDebugger + "\n language: " + Capabilities.language + "\n screenResolution: " + Capabilities.screenResolutionX + "x" + Capabilities.screenResolutionY;
    }

    public function get dumperName() : String {
      return "capabilities";
    }
  }
}
