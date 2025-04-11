package alternativa.tanks.battle.objects.tank {
  import alternativa.math.Quaternion;
  import alternativa.math.Vector3;
  import alternativa.physics.Body;
  import alternativa.physics.BodyState;
  import alternativa.tanks.battle.events.BattleEventDispatcher;
  import alternativa.tanks.utils.DataValidationErrorEvent;
  import alternativa.tanks.utils.DataValidatorType;
  import alternativa.tanks.utils.EncryptedNumber;
  import alternativa.tanks.utils.EncryptedNumberImpl;

  public class BodyPhysicsStateValidator {
    private const hash:EncryptedNumber = new EncryptedNumberImpl();
    private const cx:EncryptedNumber = new EncryptedNumberImpl(Math.random() + 1);
    private const cy:EncryptedNumber = new EncryptedNumberImpl(Math.random() + 1);
    private const cz:EncryptedNumber = new EncryptedNumberImpl(Math.random() + 1);
    private const cw:EncryptedNumber = new EncryptedNumberImpl(Math.random() + 1);

    private var body:Body;

    private const prevPosition:Vector3 = new Vector3();
    private const prevOrientation:Quaternion = new Quaternion();

    private var eventDispatcher:BattleEventDispatcher;

    public function BodyPhysicsStateValidator(param1:Body, param2:BattleEventDispatcher) {
      super();
      this.body = param1;
      this.eventDispatcher = param2;
      this.refresh();
    }

    public function refresh() : void {
      var local1:BodyState = this.body.state;
      var local2:Vector3 = local1.position;
      var local3:Quaternion = local1.orientation;
      var local4:Number = Number(this.cx.getNumber());
      var local5:Number = Number(this.cy.getNumber());
      var local6:Number = Number(this.cz.getNumber());
      this.hash.setNumber(local4 * local2.x + local5 * local2.y + local6 * local2.z + local4 * local3.x + local5 * local3.y + local6 * local3.z + this.cw.getNumber() * local3.w);
      this.prevPosition.copy(local2);
      this.prevOrientation.copy(local3);
    }

    public function validate() : void {
      var local1:BodyState = this.body.state;
      var local2:Vector3 = local1.position;
      var local3:Quaternion = local1.orientation;
      var local4:Number = Number(this.cx.getNumber());
      var local5:Number = Number(this.cy.getNumber());
      var local6:Number = Number(this.cz.getNumber());
      var local7:Number = local4 * local2.x + local5 * local2.y + local6 * local2.z + local4 * local3.x + local5 * local3.y + local6 * local3.z + this.cw.getNumber() * local3.w;
      if(local7 != this.hash.getNumber()) {
        this.eventDispatcher.dispatchEvent(new DataValidationErrorEvent(DataValidatorType.TANK_POSITION));
      }
    }
  }
}
