package projects.tanks.client.battlefield.models.user.damageindicator {
  import alternativa.osgi.OSGi;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.CollectionCodecInfo;
  import alternativa.protocol.info.TypeCodecInfo;
  import alternativa.types.Long;
  import platform.client.fp10.core.model.IModel;
  import platform.client.fp10.core.model.impl.Model;

  public class DamageIndicatorModelBase extends Model {
    private var _protocol:IProtocol = IProtocol(OSGi.getInstance().getService(IProtocol));

    protected var server:DamageIndicatorModelServer;

    private var client:IDamageIndicatorModelBase = IDamageIndicatorModelBase(this);
    private var modelId:Long = Long.getLong(756280393,-1366394900);
    private var _showDamageForShooterId:Long = Long.getLong(371898920,859714904);
    private var _showDamageForShooter_damagesCodec:ICodec;

    public function DamageIndicatorModelBase() {
      super();
      this.initCodecs();
    }

    protected function initCodecs() : void {
      this.server = new DamageIndicatorModelServer(IModel(this));
      this._showDamageForShooter_damagesCodec = this._protocol.getCodec(new CollectionCodecInfo(new TypeCodecInfo(TargetTankDamage,false),false,1));
    }

    override public function invoke(param1:Long, param2:ProtocolBuffer) : void {
      switch(param1) {
        case this._showDamageForShooterId:
          this.client.showDamageForShooter(this._showDamageForShooter_damagesCodec.decode(param2) as Vector.<TargetTankDamage>);
      }
    }

    override public function get id() : Long {
      return this.modelId;
    }
  }
}
