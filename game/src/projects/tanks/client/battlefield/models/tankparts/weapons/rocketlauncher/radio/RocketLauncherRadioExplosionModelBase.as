package projects.tanks.client.battlefield.models.tankparts.weapons.rocketlauncher.radio {
  import alternativa.osgi.OSGi;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.TypeCodecInfo;
  import alternativa.types.Long;
  import platform.client.fp10.core.model.IModel;
  import platform.client.fp10.core.model.impl.Model;

  public class RocketLauncherRadioExplosionModelBase extends Model {
    private var _protocol:IProtocol = IProtocol(OSGi.getInstance().getService(IProtocol));

    protected var server:RocketLauncherRadioExplosionModelServer;

    private var client:IRocketLauncherRadioExplosionModelBase = IRocketLauncherRadioExplosionModelBase(this);
    private var modelId:Long = Long.getLong(993900446,591673085);
    private var _shellDestroyedId:Long = Long.getLong(189748645,-2129436767);
    private var _shellDestroyed_shellIdCodec:ICodec;

    public function RocketLauncherRadioExplosionModelBase() {
      super();
      this.initCodecs();
    }

    protected function initCodecs() : void {
      this.server = new RocketLauncherRadioExplosionModelServer(IModel(this));
      this._shellDestroyed_shellIdCodec = this._protocol.getCodec(new TypeCodecInfo(int,false));
    }

    override public function invoke(param1:Long, param2:ProtocolBuffer) : void {
      switch(param1) {
        case this._shellDestroyedId:
          this.client.shellDestroyed(int(this._shellDestroyed_shellIdCodec.decode(param2)));
      }
    }

    override public function get id() : Long {
      return this.modelId;
    }
  }
}
