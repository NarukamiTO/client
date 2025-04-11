package projects.tanks.client.battlefield.models.tankparts.weapons.shotgun.shot {
  import alternativa.osgi.OSGi;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.TypeCodecInfo;
  import alternativa.types.Long;
  import platform.client.fp10.core.model.IModel;
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.registry.ModelRegistry;

  public class ShotgunShotModelBase extends Model {
    private var _protocol:IProtocol = IProtocol(OSGi.getInstance().getService(IProtocol));

    protected var server:ShotgunShotModelServer;

    private var client:IShotgunShotModelBase = IShotgunShotModelBase(this);
    private var modelId:Long = Long.getLong(1366230363,-857495328);
    private var _setRemainingShotsId:Long = Long.getLong(29952874,-1613932368);
    private var _setRemainingShots_shotsCodec:ICodec;

    public function ShotgunShotModelBase() {
      super();
      this.initCodecs();
    }

    protected function initCodecs() : void {
      this.server = new ShotgunShotModelServer(IModel(this));
      var local1:ModelRegistry = ModelRegistry(OSGi.getInstance().getService(ModelRegistry));
      local1.registerModelConstructorCodec(this.modelId,this._protocol.getCodec(new TypeCodecInfo(ShotgunShotCC,false)));
      this._setRemainingShots_shotsCodec = this._protocol.getCodec(new TypeCodecInfo(int,false));
    }

    protected function getInitParam() : ShotgunShotCC {
      return ShotgunShotCC(initParams[Model.object]);
    }

    override public function invoke(param1:Long, param2:ProtocolBuffer) : void {
      switch(param1) {
        case this._setRemainingShotsId:
          this.client.setRemainingShots(int(this._setRemainingShots_shotsCodec.decode(param2)));
      }
    }

    override public function get id() : Long {
      return this.modelId;
    }
  }
}
