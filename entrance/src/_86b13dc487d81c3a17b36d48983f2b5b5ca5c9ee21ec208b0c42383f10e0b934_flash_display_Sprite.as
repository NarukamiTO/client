package {
  import flash.display.Sprite;
  import flash.system.Security;

  [ExcludeClass]
  public class _86b13dc487d81c3a17b36d48983f2b5b5ca5c9ee21ec208b0c42383f10e0b934_flash_display_Sprite extends Sprite {
    public function _86b13dc487d81c3a17b36d48983f2b5b5ca5c9ee21ec208b0c42383f10e0b934_flash_display_Sprite() {
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
