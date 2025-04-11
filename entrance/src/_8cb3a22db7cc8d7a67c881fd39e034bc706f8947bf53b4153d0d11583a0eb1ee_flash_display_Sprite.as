package {
  import flash.display.Sprite;
  import flash.system.Security;

  [ExcludeClass]
  public class _8cb3a22db7cc8d7a67c881fd39e034bc706f8947bf53b4153d0d11583a0eb1ee_flash_display_Sprite extends Sprite {
    public function _8cb3a22db7cc8d7a67c881fd39e034bc706f8947bf53b4153d0d11583a0eb1ee_flash_display_Sprite() {
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
