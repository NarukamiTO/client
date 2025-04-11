package {
  import flash.display.Sprite;
  import flash.system.Security;

  [ExcludeClass]
  public class _01547ee4d3c4958823b2fea0587533b8bb6b29b2e7bcdb0235135fa28086b020_flash_display_Sprite extends Sprite {
    public function _01547ee4d3c4958823b2fea0587533b8bb6b29b2e7bcdb0235135fa28086b020_flash_display_Sprite() {
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
