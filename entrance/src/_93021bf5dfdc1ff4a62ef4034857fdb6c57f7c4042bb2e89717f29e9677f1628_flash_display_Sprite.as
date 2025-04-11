package {
  import flash.display.Sprite;
  import flash.system.Security;

  [ExcludeClass]
  public class _93021bf5dfdc1ff4a62ef4034857fdb6c57f7c4042bb2e89717f29e9677f1628_flash_display_Sprite extends Sprite {
    public function _93021bf5dfdc1ff4a62ef4034857fdb6c57f7c4042bb2e89717f29e9677f1628_flash_display_Sprite() {
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
