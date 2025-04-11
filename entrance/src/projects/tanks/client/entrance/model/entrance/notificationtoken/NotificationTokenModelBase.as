package projects.tanks.client.entrance.model.entrance.notificationtoken {
  import alternativa.osgi.OSGi;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.types.Long;
  import platform.client.fp10.core.model.IModel;
  import platform.client.fp10.core.model.impl.Model;

  public class NotificationTokenModelBase extends Model {
    private var _protocol:IProtocol = IProtocol(OSGi.getInstance().getService(IProtocol));

    protected var server:NotificationTokenModelServer;

    private var client:INotificationTokenModelBase = INotificationTokenModelBase(this);
    private var modelId:Long = Long.getLong(185921630,-1096375880);

    public function NotificationTokenModelBase() {
      super();
      this.initCodecs();
    }

    protected function initCodecs() : void {
      this.server = new NotificationTokenModelServer(IModel(this));
    }

    override public function invoke(param1:Long, param2:ProtocolBuffer) : void {
      var local3:* = param1;
      switch(false ? 0 : 0) {
      }
    }

    override public function get id() : Long {
      return this.modelId;
    }
  }
}
