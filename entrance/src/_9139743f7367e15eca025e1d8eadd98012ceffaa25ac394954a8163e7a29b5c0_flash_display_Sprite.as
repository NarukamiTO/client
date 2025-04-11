package {
  import flash.display.Sprite;
  import flash.system.Security;

  [ExcludeClass]
  public class _9139743f7367e15eca025e1d8eadd98012ceffaa25ac394954a8163e7a29b5c0_flash_display_Sprite extends Sprite {
    public function _9139743f7367e15eca025e1d8eadd98012ceffaa25ac394954a8163e7a29b5c0_flash_display_Sprite() {
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
