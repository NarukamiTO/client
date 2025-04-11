package alternativa.tanks.utils {
  import alternativa.osgi.OSGi;
  import alternativa.tanks.battle.events.BattleEventDispatcher;

  public class DataValidatorImpl implements DataValidator {
    private static const zero:EncryptedInt = new EncryptedIntImpl();
    private static const one:EncryptedInt = new EncryptedIntImpl(1);
    private static const numChecksPerTick:EncryptedInt = new EncryptedIntImpl(5);

    private const currentIndex:EncryptedInt = new EncryptedIntImpl();

    private var battleEventDispatcher:BattleEventDispatcher;
    private var validators:Vector.<DataUnitValidator> = new Vector.<DataUnitValidator>();

    public function DataValidatorImpl(param1:OSGi) {
      super();
      this.battleEventDispatcher = BattleEventDispatcher(param1.getService(BattleEventDispatcher));
    }

    public function addValidator(param1:DataUnitValidator) : void {
      if(this.validators.indexOf(param1) < zero.getInt()) {
        this.validators.push(param1);
      }
    }

    public function removeValidator(param1:DataUnitValidator) : void {
      var local2:int = int(this.validators.indexOf(param1));
      if(local2 >= zero.getInt()) {
        this.validators.splice(local2,one.getInt());
      }
    }

    public function removeAllValidators() : void {
      this.validators.length = zero.getInt();
    }

    public function tick() : void {
      var local1:int = 0;
      var local2:DataUnitValidator = null;
      if(this.validators.length > zero.getInt()) {
        local1 = int(zero.getInt());
        while(local1 < numChecksPerTick.getInt()) {
          local2 = this.getNextValidator();
          if(local2.hasIncorrectData()) {
            this.battleEventDispatcher.dispatchEvent(new DataValidationErrorEvent(local2.getType()));
            break;
          }
          local1++;
        }
      }
    }

    private function getNextValidator() : DataUnitValidator {
      return this.validators[this.getNextIndex()];
    }

    private function getNextIndex() : int {
      var local1:int = int(this.currentIndex.getInt());
      local1++;
      if(local1 >= this.validators.length) {
        local1 = int(zero.getInt());
      }
      this.currentIndex.setInt(local1);
      return local1;
    }
  }
}
