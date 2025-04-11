package {
  import flash.display.Sprite;
  import flash.system.Security;

  [ExcludeClass]
  public class _d71c21c37e3ccb3ef436aeb7afbf4267399e648c077f71173c219a98826c4795_flash_display_Sprite extends Sprite {
    public function _d71c21c37e3ccb3ef436aeb7afbf4267399e648c077f71173c219a98826c4795_flash_display_Sprite() {
      super();
    }

    public function allowDomainInRSL(... rest) : void {
      Security.allowDomain(rest);
    }

    public function allowInsecureDomainInRSL(... rest) : void {
      Security.allowInsecureDomain(rest);
    }
  }
}
