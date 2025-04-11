package alternativa.tanks.models.weapon {
  import alternativa.tanks.utils.ConstEncryptedNumber;
  import alternativa.tanks.utils.EncryptedNumber;

  public class WeaponConst {
    private static const BASE_IMPACT_FORCE1:Number = 5000000;

    public static const BASE_IMPACT_FORCE:EncryptedNumber = new ConstEncryptedNumber(BASE_IMPACT_FORCE1);
    public static const DEFAULT_BARREL_INDEX:int = 0;

    public function WeaponConst() {
      super();
    }
  }
}
