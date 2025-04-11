package {
  import flash.display.Sprite;
  import flash.system.Security;

  [ExcludeClass]
  public class _16074f4b0f4af855fa38d92843579a2f6069db8e9c176f3324999061de251bcf_flash_display_Sprite extends Sprite {
    public function _16074f4b0f4af855fa38d92843579a2f6069db8e9c176f3324999061de251bcf_flash_display_Sprite() {
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
