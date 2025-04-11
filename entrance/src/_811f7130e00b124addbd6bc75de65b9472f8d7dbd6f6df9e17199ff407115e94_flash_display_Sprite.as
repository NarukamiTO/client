package {
  import flash.display.Sprite;
  import flash.system.Security;

  [ExcludeClass]
  public class _811f7130e00b124addbd6bc75de65b9472f8d7dbd6f6df9e17199ff407115e94_flash_display_Sprite extends Sprite {
    public function _811f7130e00b124addbd6bc75de65b9472f8d7dbd6f6df9e17199ff407115e94_flash_display_Sprite() {
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
