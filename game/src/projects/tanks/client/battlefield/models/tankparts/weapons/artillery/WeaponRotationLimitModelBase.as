package projects.tanks.client.battlefield.models.tankparts.weapons.artillery {
  import alternativa.osgi.OSGi;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.types.Long;
  import platform.client.fp10.core.model.IModel;
  import platform.client.fp10.core.model.impl.Model;

  public class WeaponRotationLimitModelBase extends Model {
    private var _protocol:IProtocol = IProtocol(OSGi.getInstance().getService(IProtocol));

    protected var server:WeaponRotationLimitModelServer;

    private var client:IWeaponRotationLimitModelBase = IWeaponRotationLimitModelBase(this);
    private var modelId:Long = Long.getLong(1326062457,-784723685);

    public function WeaponRotationLimitModelBase() {
      super();
      this.initCodecs();
    }

    protected function initCodecs() : void {
      this.server = new WeaponRotationLimitModelServer(IModel(this));
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
