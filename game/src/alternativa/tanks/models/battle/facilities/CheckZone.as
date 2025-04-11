package alternativa.tanks.models.battle.facilities {
  import alternativa.math.Vector3;
  import alternativa.tanks.battle.objects.tank.Tank;

  public class CheckZone {
    private var _position:Vector3;
    private var _tank:Tank;
    private var _radiusSqr:Number;
    private var _checkRaycast:Boolean;

    public function CheckZone() {
      super();
    }

    public static function create(param1:Vector3, param2:Number, param3:Boolean) : CheckZone {
      var local4:CheckZone = new CheckZone();
      local4._position = param1;
      local4._tank = null;
      local4._radiusSqr = param2 * param2;
      local4._checkRaycast = param3;
      return local4;
    }

    public static function createDynamic(param1:Tank, param2:Number, param3:Boolean) : CheckZone {
      var local4:CheckZone = new CheckZone();
      local4._position = null;
      local4._tank = param1;
      local4._radiusSqr = param2 * param2;
      local4._checkRaycast = param3;
      return local4;
    }

    public function get position() : Vector3 {
      if(this._position == null) {
        return this._tank.getBody().state.position;
      }
      return this._position;
    }

    public function get radiusSqr() : Number {
      return this._radiusSqr;
    }

    public function get checkRaycast() : Boolean {
      return this._checkRaycast;
    }

    public function get tank() : Tank {
      return this._tank;
    }
  }
}
