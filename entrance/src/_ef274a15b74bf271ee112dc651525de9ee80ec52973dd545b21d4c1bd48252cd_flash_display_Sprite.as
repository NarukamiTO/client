package {
  import flash.display.Sprite;
  import flash.system.Security;

  [ExcludeClass]
  public class _ef274a15b74bf271ee112dc651525de9ee80ec52973dd545b21d4c1bd48252cd_flash_display_Sprite extends Sprite {
    public function _ef274a15b74bf271ee112dc651525de9ee80ec52973dd545b21d4c1bd48252cd_flash_display_Sprite() {
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
