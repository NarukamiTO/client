package alternativa.tanks.utils {
  import alternativa.math.Vector3;
  import alternativa.physics.collision.primitives.CollisionBox;

  public class EncryptedCollisionBoxData {
    private var hs:Vector3;

    private const halfSizeX:EncryptedNumber = new EncryptedNumberImpl();
    private const halfSizeY:EncryptedNumber = new EncryptedNumberImpl();
    private const halfSizeZ:EncryptedNumber = new EncryptedNumberImpl();

    public function EncryptedCollisionBoxData(param1:CollisionBox) {
      super();
      this.hs = param1.hs;
      this.halfSizeX.setNumber(param1.hs.x);
      this.halfSizeY.setNumber(param1.hs.y);
      this.halfSizeZ.setNumber(param1.hs.z);
    }

    public function isInvalid() : Boolean {
      return this.hs.x != this.halfSizeX.getNumber() || this.hs.y != this.halfSizeY.getNumber() || this.hs.z != this.halfSizeZ.getNumber();
    }
  }
}
