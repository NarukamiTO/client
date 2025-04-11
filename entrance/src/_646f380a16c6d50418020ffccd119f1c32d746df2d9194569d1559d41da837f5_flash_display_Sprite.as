package {
  import flash.display.Sprite;
  import flash.system.Security;

  [ExcludeClass]
  public class _646f380a16c6d50418020ffccd119f1c32d746df2d9194569d1559d41da837f5_flash_display_Sprite extends Sprite {
    public function _646f380a16c6d50418020ffccd119f1c32d746df2d9194569d1559d41da837f5_flash_display_Sprite() {
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
