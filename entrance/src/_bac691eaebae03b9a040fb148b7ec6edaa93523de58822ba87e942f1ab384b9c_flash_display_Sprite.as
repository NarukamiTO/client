package {
  import flash.display.Sprite;
  import flash.system.Security;

  [ExcludeClass]
  public class _bac691eaebae03b9a040fb148b7ec6edaa93523de58822ba87e942f1ab384b9c_flash_display_Sprite extends Sprite {
    public function _bac691eaebae03b9a040fb148b7ec6edaa93523de58822ba87e942f1ab384b9c_flash_display_Sprite() {
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
