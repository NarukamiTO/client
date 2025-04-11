package {
  import flash.display.Sprite;
  import flash.system.Security;

  [ExcludeClass]
  public class _37fe85d039ca525c8b5495d307a56ee5ca27b99efdd7f81a4cb1d94e0a96cbe3_flash_display_Sprite extends Sprite {
    public function _37fe85d039ca525c8b5495d307a56ee5ca27b99efdd7f81a4cb1d94e0a96cbe3_flash_display_Sprite() {
      super();
    }

    public function allowDomainInRSL(... rest) : void {
      Security.allowDomain.apply(null,rest);
    }

    public function allowInsecureDomainInRSL(... rest) : void {
      Security.allowInsecureDomain.apply(null,rest);
    }
  }
}
