package alternativa.tanks.battle.objects.tank {
  import alternativa.math.Matrix3;
  import alternativa.math.Quaternion;
  import alternativa.math.Vector3;
  import alternativa.physics.Body;
  import alternativa.physics.BodyState;
  import alternativa.tanks.utils.EncryptedNumber;
  import alternativa.tanks.utils.EncryptedNumberImpl;

  public class RemoteHullTransformUpdater implements HullTransformUpdater {
    private static const position:Vector3 = new Vector3();
    private static const m3:Matrix3 = new Matrix3();
    private static const SMOOTHING_COEFF:EncryptedNumber = new EncryptedNumberImpl(Math.PI / 10.4719);
    private static const smoothedEulerAngles:Vector3 = new Vector3();

    private const smoothedPosition:Vector3 = new Vector3();
    private const smoothedOrientation:Quaternion = new Quaternion();

    private var tank:Tank;

    public function RemoteHullTransformUpdater(param1:Tank) {
      super();
      this.tank = param1;
    }

    private static function smoothValue(param1:Number, param2:Number, param3:Number, param4:Number, param5:Number) : Number {
      param1 += param2 * param3;
      return param1 + (param4 - param1) * param5;
    }

    public function reset() : void {
      var local1:BodyState = this.tank.getBody().prevState;
      this.smoothedPosition.copy(local1.position);
      this.smoothedOrientation.copy(local1.orientation);
    }

    public function update(param1:Number) : void {
      var local2:Body = this.tank.getBody();
      var local3:BodyState = local2.prevState;
      var local4:Vector3 = local3.velocity;
      var local5:Vector3 = this.tank.interpolatedPosition;
      var local6:Number = Number(SMOOTHING_COEFF.getNumber());
      this.smoothedPosition.x = smoothValue(this.smoothedPosition.x,local4.x,param1,local5.x,local6);
      this.smoothedPosition.y = smoothValue(this.smoothedPosition.y,local4.y,param1,local5.y,local6);
      this.smoothedPosition.z = smoothValue(this.smoothedPosition.z,local4.z,param1,local5.z,local6);
      var local7:Vector3 = local3.angularVelocity;
      this.smoothedOrientation.addScaledVector(local7,param1);
      this.smoothedOrientation.slerp(this.smoothedOrientation,this.tank.interpolatedOrientation,local6);
      this.smoothedOrientation.getEulerAngles(smoothedEulerAngles);
      this.smoothedOrientation.toMatrix3(m3);
      position.copy(this.tank.skinCenterOffset);
      position.transform3(m3);
      position.add(this.smoothedPosition);
      this.tank.getSkin().updateHullTransform(position,smoothedEulerAngles);
    }
  }
}
