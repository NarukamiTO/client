package projects.tanks.client.battlefield.models.user.reloader {
  import alternativa.osgi.OSGi;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.TypeCodecInfo;
  import alternativa.types.Long;
  import platform.client.fp10.core.model.IModel;
  import platform.client.fp10.core.model.impl.Model;

  public class TankReloaderModelBase extends Model {
    private var _protocol:IProtocol = IProtocol(OSGi.getInstance().getService(IProtocol));

    protected var server:TankReloaderModelServer;

    private var client:ITankReloaderModelBase = ITankReloaderModelBase(this);
    private var modelId:Long = Long.getLong(1286074115,-176946994);
    private var _dieId:Long = Long.getLong(343596326,-230405373);
    private var _die_respawnDelayCodec:ICodec;
    private var _onDeathScheduledId:Long = Long.getLong(208555485,-6667003);
    private var _onDeathScheduled_suicideDelayMSCodec:ICodec;
    private var _onReloadId:Long = Long.getLong(154981282,1951339013);

    public function TankReloaderModelBase() {
      super();
      this.initCodecs();
    }

    protected function initCodecs() : void {
      this.server = new TankReloaderModelServer(IModel(this));
      this._die_respawnDelayCodec = this._protocol.getCodec(new TypeCodecInfo(int,false));
      this._onDeathScheduled_suicideDelayMSCodec = this._protocol.getCodec(new TypeCodecInfo(int,false));
    }

    override public function invoke(param1:Long, param2:ProtocolBuffer) : void {
      switch(param1) {
        case this._dieId:
          this.client.die(int(this._die_respawnDelayCodec.decode(param2)));
          break;
        case this._onDeathScheduledId:
          this.client.onDeathScheduled(int(this._onDeathScheduled_suicideDelayMSCodec.decode(param2)));
          break;
        case this._onReloadId:
          this.client.onReload();
      }
    }

    override public function get id() : Long {
      return this.modelId;
    }
  }
}
