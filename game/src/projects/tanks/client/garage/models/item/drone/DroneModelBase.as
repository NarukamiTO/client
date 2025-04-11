package projects.tanks.client.garage.models.item.drone {
  import alternativa.osgi.OSGi;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.types.Long;
  import platform.client.fp10.core.model.IModel;
  import platform.client.fp10.core.model.impl.Model;

  public class DroneModelBase extends Model {
    private var _protocol:IProtocol = IProtocol(OSGi.getInstance().getService(IProtocol));

    protected var server:DroneModelServer;

    private var client:IDroneModelBase = IDroneModelBase(this);
    private var modelId:Long = Long.getLong(627088635,-688861677);

    public function DroneModelBase() {
      super();
      this.initCodecs();
    }

    protected function initCodecs() : void {
      this.server = new DroneModelServer(IModel(this));
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
