package {
  import flash.display.Sprite;
  import flash.system.Security;

  public class _94a1da8e22a2c6b985d5245debdf86fd15df9f417d92201a6b36b2cb9f179ba6_flash_display_Sprite extends Sprite {
    public function _94a1da8e22a2c6b985d5245debdf86fd15df9f417d92201a6b36b2cb9f179ba6_flash_display_Sprite() {
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
