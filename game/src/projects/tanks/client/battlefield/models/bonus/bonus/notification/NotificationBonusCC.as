package projects.tanks.client.battlefield.models.bonus.bonus.notification {
  import platform.client.fp10.core.resource.types.SoundResource;

  public class NotificationBonusCC {
    private var _notificationMessage:String;
    private var _notificationMessageContainsUid:String;
    private var _soundNotification:SoundResource;

    public function NotificationBonusCC(param1:String = null, param2:String = null, param3:SoundResource = null) {
      super();
      this._notificationMessage = param1;
      this._notificationMessageContainsUid = param2;
      this._soundNotification = param3;
    }

    public function get notificationMessage() : String {
      return this._notificationMessage;
    }

    public function set notificationMessage(param1:String) : void {
      this._notificationMessage = param1;
    }

    public function get notificationMessageContainsUid() : String {
      return this._notificationMessageContainsUid;
    }

    public function set notificationMessageContainsUid(param1:String) : void {
      this._notificationMessageContainsUid = param1;
    }

    public function get soundNotification() : SoundResource {
      return this._soundNotification;
    }

    public function set soundNotification(param1:SoundResource) : void {
      this._soundNotification = param1;
    }

    public function toString() : String {
      var local1:String = "NotificationBonusCC [";
      local1 += "notificationMessage = " + this.notificationMessage + " ";
      local1 += "notificationMessageContainsUid = " + this.notificationMessageContainsUid + " ";
      local1 += "soundNotification = " + this.soundNotification + " ";
      return local1 + "]";
    }
  }
}
