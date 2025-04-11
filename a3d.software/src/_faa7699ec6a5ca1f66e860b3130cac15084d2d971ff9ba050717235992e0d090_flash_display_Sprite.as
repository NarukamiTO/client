package {
  import flash.display.Sprite;
  import flash.system.Security;

  [ExcludeClass]
  public class _faa7699ec6a5ca1f66e860b3130cac15084d2d971ff9ba050717235992e0d090_flash_display_Sprite extends Sprite {
    public function _faa7699ec6a5ca1f66e860b3130cac15084d2d971ff9ba050717235992e0d090_flash_display_Sprite() {
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
