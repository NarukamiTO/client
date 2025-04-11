package alternativa.tanks.battle.objects.tank {
  import alternativa.physics.collision.CollisionShape;
  import alternativa.physics.collision.primitives.CollisionBox;
  import alternativa.tanks.utils.DataUnitValidator;
  import alternativa.tanks.utils.DataValidatorType;
  import alternativa.tanks.utils.EncryptedCollisionBoxData;

  public class TankDataValidator implements DataUnitValidator {
    private var encryptedData:Vector.<EncryptedCollisionBoxData>;

    public function TankDataValidator(param1:Vector.<CollisionShape>) {
      super();
      this.encryptedData = new Vector.<EncryptedCollisionBoxData>(param1.length);
      var local2:int = 0;
      while(local2 < param1.length) {
        this.encryptedData[local2] = new EncryptedCollisionBoxData(CollisionBox(param1[local2]));
        local2++;
      }
    }

    public function hasIncorrectData() : Boolean {
      var local1:EncryptedCollisionBoxData = null;
      for each(local1 in this.encryptedData) {
        if(local1.isInvalid()) {
          return true;
        }
      }
      return false;
    }

    public function getType() : int {
      return DataValidatorType.TANK;
    }

    public function destroy() : void {
      this.encryptedData.length = 0;
    }
  }
}
