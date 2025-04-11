package projects.tanks.clients.fp10.libraries.tanksservices.model.notifier.online {
  import alternativa.types.Long;

  public class ClientOnlineNotifierData {
    private var _userId:Long;
    private var _online:Boolean;
    private var _serverNumber:int;

    public function ClientOnlineNotifierData(param1:Long, param2:Boolean, param3:int) {
      super();
      this._userId = param1;
      this._online = param2;
      this._serverNumber = param3;
    }

    public function get userId() : Long {
      return this._userId;
    }

    public function get online() : Boolean {
      return this._online;
    }

    public function get serverNumber() : int {
      return this._serverNumber;
    }
  }
}
