package projects.tanks.client.panel.model.userscounter.panel {
  import alternativa.osgi.OSGi;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.TypeCodecInfo;
  import alternativa.types.Long;
  import platform.client.fp10.core.model.IModel;
  import platform.client.fp10.core.model.impl.Model;

  public class UsersCounterPanelModelBase extends Model {
    private var _protocol:IProtocol = IProtocol(OSGi.getInstance().getService(IProtocol));

    protected var server:UsersCounterPanelModelServer;

    private var client:IUsersCounterPanelModelBase = IUsersCounterPanelModelBase(this);
    private var modelId:Long = Long.getLong(1626818804,-815772060);
    private var _saveUniqueUserIdId:Long = Long.getLong(2097016898,-518819579);
    private var _saveUniqueUserId_idCodec:ICodec;

    public function UsersCounterPanelModelBase() {
      super();
      this.initCodecs();
    }

    protected function initCodecs() : void {
      this.server = new UsersCounterPanelModelServer(IModel(this));
      this._saveUniqueUserId_idCodec = this._protocol.getCodec(new TypeCodecInfo(Long,false));
    }

    override public function invoke(param1:Long, param2:ProtocolBuffer) : void {
      switch(param1) {
        case this._saveUniqueUserIdId:
          this.client.saveUniqueUserId(Long(this._saveUniqueUserId_idCodec.decode(param2)));
      }
    }

    override public function get id() : Long {
      return this.modelId;
    }
  }
}
