package {
  import flash.display.Sprite;
  import flash.system.Security;

  [ExcludeClass]
  public class _889e776d06902fc46f2063fe83990fa6bf81a6b3ad478649e679a4f24415fe62_flash_display_Sprite extends Sprite {
    public function _889e776d06902fc46f2063fe83990fa6bf81a6b3ad478649e679a4f24415fe62_flash_display_Sprite() {
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
