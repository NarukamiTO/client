package {
  import flash.display.Sprite;
  import flash.system.Security;

  [ExcludeClass]
  public class _4815a52172f7deb95cfa695947343310ebe083df2c993fffc3a85528f7493dea_flash_display_Sprite extends Sprite {
    public function _4815a52172f7deb95cfa695947343310ebe083df2c993fffc3a85528f7493dea_flash_display_Sprite() {
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
