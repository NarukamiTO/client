package projects.tanks.client.clans.clan.block {
  import alternativa.osgi.OSGi;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.TypeCodecInfo;
  import alternativa.types.Long;
  import platform.client.fp10.core.model.IModel;
  import platform.client.fp10.core.model.impl.Model;

  public class ClanBlockModelBase extends Model {
    private var _protocol:IProtocol = IProtocol(OSGi.getInstance().getService(IProtocol));

    protected var server:ClanBlockModelServer;

    private var client:IClanBlockModelBase = IClanBlockModelBase(this);
    private var modelId:Long = Long.getLong(525873271,1744909560);
    private var _clanBanedId:Long = Long.getLong(123212251,-1982333947);
    private var _clanBaned_reasonCodec:ICodec;

    public function ClanBlockModelBase() {
      super();
      this.initCodecs();
    }

    protected function initCodecs() : void {
      this.server = new ClanBlockModelServer(IModel(this));
      this._clanBaned_reasonCodec = this._protocol.getCodec(new TypeCodecInfo(String,false));
    }

    override public function invoke(param1:Long, param2:ProtocolBuffer) : void {
      switch(param1) {
        case this._clanBanedId:
          this.client.clanBaned(String(this._clanBaned_reasonCodec.decode(param2)));
      }
    }

    override public function get id() : Long {
      return this.modelId;
    }
  }
}
