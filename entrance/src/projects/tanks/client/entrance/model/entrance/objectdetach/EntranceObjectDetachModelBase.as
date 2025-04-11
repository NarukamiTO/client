package projects.tanks.client.entrance.model.entrance.objectdetach {
  import alternativa.osgi.OSGi;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.types.Long;
  import platform.client.fp10.core.model.IModel;
  import platform.client.fp10.core.model.impl.Model;

  public class EntranceObjectDetachModelBase extends Model {
    private var _protocol:IProtocol = IProtocol(OSGi.getInstance().getService(IProtocol));

    protected var server:EntranceObjectDetachModelServer;

    private var client:IEntranceObjectDetachModelBase = IEntranceObjectDetachModelBase(this);
    private var modelId:Long = Long.getLong(1377053011,190397042);
    private var _objectDetachId:Long = Long.getLong(5859656,-1143601287);

    public function EntranceObjectDetachModelBase() {
      super();
      this.initCodecs();
    }

    protected function initCodecs() : void {
      this.server = new EntranceObjectDetachModelServer(IModel(this));
    }

    override public function invoke(param1:Long, param2:ProtocolBuffer) : void {
      switch(param1) {
        case this._objectDetachId:
          this.client.objectDetach();
      }
    }

    override public function get id() : Long {
      return this.modelId;
    }
  }
}
