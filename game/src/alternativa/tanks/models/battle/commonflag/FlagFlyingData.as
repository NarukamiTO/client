package alternativa.tanks.models.battle.commonflag {
  import alternativa.math.Quaternion;
  import alternativa.math.Vector3;
  import projects.tanks.client.battlefield.models.battle.pointbased.flag.ClientFlagFlyingData;
  import projects.tanks.client.battlefield.models.battle.pointbased.flag.FlagFlyPoint;
  import projects.tanks.client.battlefield.models.battle.pointbased.flag.FlyingMode;

  public class FlagFlyingData {
    private static const TIME_TO_MARK:int = 3000;
    private static const APOS:Vector3 = new Vector3();
    private static const BPOS:Vector3 = new Vector3();
    private static const aQ:Quaternion = new Quaternion();
    private static const bQ:Quaternion = new Quaternion();

    private var points:Vector.<FlagFlyPoint> = new Vector.<FlagFlyPoint>();

    public var isFlying:Boolean = false;

    private var time:int = 0;

    public var currentPosition:Vector3 = new Vector3();
    public var instantSpeed:Number = 0;

    private var currentIndex:int = 0;
    private var finalPosition:Vector3 = new Vector3();

    public var currentOrientation:Quaternion = new Quaternion();
    public var isKilled:Boolean;

    public function FlagFlyingData() {
      super();
    }

    public function init(param1:ClientFlagFlyingData) : void {
      var local2:FlagFlyPoint = null;
      this.points.length = 0;
      for each(local2 in param1.points) {
        this.points.push(local2);
      }
      this.isFlying = param1.falling;
      this.time = param1.currentTime;
      this.currentIndex = 0;
      this.finalPosition.copyFromVector3d(this.getLastPoint().position);
      this.isKilled = false;
      this.update(0);
    }

    public function update(param1:Number) : void {
      var local3:FlagFlyPoint = null;
      var local4:FlagFlyPoint = null;
      var local8:int = 0;
      this.time += param1 * 1000;
      var local2:FlagFlyPoint = this.getLastPoint();
      if(this.time >= local2.time) {
        this.currentPosition.copy(this.getFinalPosition());
        this.time = local2.time;
        this.isFlying = false;
        if(local2.mode == FlyingMode.KILL) {
          this.isKilled = true;
        }
        return;
      }
      if(this.points.length == 2) {
        local4 = this.points[0];
        local3 = this.points[1];
      } else {
        local8 = this.currentIndex;
        while(local8 < this.points.length - 1) {
          local4 = this.points[local8];
          local3 = this.points[local8 + 1];
          if(local4.time <= this.time && this.time < local3.time) {
            this.currentIndex = local8;
            break;
          }
          local8++;
        }
      }
      var local5:int = local3.time - local4.time;
      var local6:Number = (this.time - local4.time) / local5;
      BPOS.copyFromVector3d(local3.position);
      this.currentPosition.copy(BPOS);
      APOS.copyFromVector3d(local4.position);
      this.currentPosition.subtract(APOS);
      this.currentPosition.scale(local6);
      this.currentPosition.add(APOS);
      aQ.reset(local4.rotation_w,local4.rotation_x,local4.rotation_y,local4.rotation_z).normalize();
      bQ.reset(local3.rotation_w,local3.rotation_x,local3.rotation_y,local3.rotation_z).normalize();
      this.currentOrientation.slerp(aQ,bQ,local6).normalize();
      var local7:Number = BPOS.distanceTo(APOS);
      this.instantSpeed = local7 / (local5 * 1000);
    }

    public function getFinalPosition() : Vector3 {
      return this.finalPosition;
    }

    private function getLastPoint() : FlagFlyPoint {
      return this.points[this.points.length - 1];
    }

    public function isMarked() : Boolean {
      return this.time > TIME_TO_MARK;
    }
  }
}
