package projects.tanks.client.battlefield.models.user.turnover {
  import alternativa.osgi.OSGi;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.types.Long;
  import platform.client.fp10.core.model.IModel;
  import platform.client.fp10.core.model.impl.Model;

  public class TankTurnOverModelBase extends Model {
    private var _protocol:IProtocol = IProtocol(OSGi.getInstance().getService(IProtocol));

    protected var server:TankTurnOverModelServer;

    private var client:ITankTurnOverModelBase = ITankTurnOverModelBase(this);
    private var modelId:Long = Long.getLong(979293197,-632476978);

    public function TankTurnOverModelBase() {
      super();
      this.initCodecs();
    }

    protected function initCodecs() : void {
      this.server = new TankTurnOverModelServer(IModel(this));
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
