package {
  import flash.display.Sprite;
  import flash.system.Security;

  [ExcludeClass]
  public class _3137aaab840677c44145d29152eb3ea38f0ed49cd5676d3fdd49cdff0a163c5a_flash_display_Sprite extends Sprite {
    public function _3137aaab840677c44145d29152eb3ea38f0ed49cd5676d3fdd49cdff0a163c5a_flash_display_Sprite() {
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
