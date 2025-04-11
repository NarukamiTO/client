package projects.tanks.client.battlefield.models.tankparts.weapons.artillery.rotation {
  import alternativa.osgi.OSGi;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.types.Long;
  import platform.client.fp10.core.model.IModel;
  import platform.client.fp10.core.model.impl.Model;

  public class ArtilleryRotatingTurretModelBase extends Model {
    private var _protocol:IProtocol = IProtocol(OSGi.getInstance().getService(IProtocol));

    protected var server:ArtilleryRotatingTurretModelServer;

    private var client:IArtilleryRotatingTurretModelBase = IArtilleryRotatingTurretModelBase(this);
    private var modelId:Long = Long.getLong(1240706018,-961658094);

    public function ArtilleryRotatingTurretModelBase() {
      super();
      this.initCodecs();
    }

    protected function initCodecs() : void {
      this.server = new ArtilleryRotatingTurretModelServer(IModel(this));
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
