package {
  import flash.display.Sprite;
  import flash.system.Security;

  [ExcludeClass]
  public class _2e53c076f335fabd50d0c7fa564016f7d6d01024a7efdc5e77520f30fbf10b39_flash_display_Sprite extends Sprite {
    public function _2e53c076f335fabd50d0c7fa564016f7d6d01024a7efdc5e77520f30fbf10b39_flash_display_Sprite() {
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
