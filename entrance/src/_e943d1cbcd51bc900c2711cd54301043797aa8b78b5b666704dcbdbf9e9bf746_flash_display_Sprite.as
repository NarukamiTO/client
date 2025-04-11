package {
  import flash.display.Sprite;
  import flash.system.Security;

  [ExcludeClass]
  public class _e943d1cbcd51bc900c2711cd54301043797aa8b78b5b666704dcbdbf9e9bf746_flash_display_Sprite extends Sprite {
    public function _e943d1cbcd51bc900c2711cd54301043797aa8b78b5b666704dcbdbf9e9bf746_flash_display_Sprite() {
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
