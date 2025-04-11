package {
  import flash.display.Sprite;
  import flash.system.Security;

  [ExcludeClass]
  public class _6a39ad10b0a5034b7f18b8fdf3adecf2d1daf72546a07bfff5440ac49311bcfa_flash_display_Sprite extends Sprite {
    public function _6a39ad10b0a5034b7f18b8fdf3adecf2d1daf72546a07bfff5440ac49311bcfa_flash_display_Sprite() {
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
