package projects.tanks.client.tanksservices.model.notifier.online {
  import alternativa.osgi.OSGi;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.CollectionCodecInfo;
  import alternativa.protocol.info.TypeCodecInfo;
  import alternativa.types.Long;
  import platform.client.fp10.core.model.IModel;
  import platform.client.fp10.core.model.impl.Model;

  public class OnlineNotifierModelBase extends Model {
    private var _protocol:IProtocol = IProtocol(OSGi.getInstance().getService(IProtocol));

    protected var server:OnlineNotifierModelServer;

    private var client:IOnlineNotifierModelBase = IOnlineNotifierModelBase(this);
    private var modelId:Long = Long.getLong(467887314,-1426971041);
    private var _setOnlineId:Long = Long.getLong(1815033699,-407485089);
    private var _setOnline_usersCodec:ICodec;

    public function OnlineNotifierModelBase() {
      super();
      this.initCodecs();
    }

    protected function initCodecs() : void {
      this.server = new OnlineNotifierModelServer(IModel(this));
      this._setOnline_usersCodec = this._protocol.getCodec(new CollectionCodecInfo(new TypeCodecInfo(OnlineNotifierData,false),false,1));
    }

    override public function invoke(param1:Long, param2:ProtocolBuffer) : void {
      switch(param1) {
        case this._setOnlineId:
          this.client.setOnline(this._setOnline_usersCodec.decode(param2) as Vector.<OnlineNotifierData>);
      }
    }

    override public function get id() : Long {
      return this.modelId;
    }
  }
}
