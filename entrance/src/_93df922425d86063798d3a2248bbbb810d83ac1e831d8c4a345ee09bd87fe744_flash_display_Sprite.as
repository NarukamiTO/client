package {
  import flash.display.Sprite;
  import flash.system.Security;

  [ExcludeClass]
  public class _93df922425d86063798d3a2248bbbb810d83ac1e831d8c4a345ee09bd87fe744_flash_display_Sprite extends Sprite {
    public function _93df922425d86063798d3a2248bbbb810d83ac1e831d8c4a345ee09bd87fe744_flash_display_Sprite() {
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
