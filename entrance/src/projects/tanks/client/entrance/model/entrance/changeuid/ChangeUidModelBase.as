package projects.tanks.client.entrance.model.entrance.changeuid {
  import alternativa.osgi.OSGi;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.types.Long;
  import platform.client.fp10.core.model.IModel;
  import platform.client.fp10.core.model.impl.Model;

  public class ChangeUidModelBase extends Model {
    private var _protocol:IProtocol = IProtocol(OSGi.getInstance().getService(IProtocol));

    protected var server:ChangeUidModelServer;

    private var client:IChangeUidModelBase = IChangeUidModelBase(this);
    private var modelId:Long = Long.getLong(334342439,-2018007012);
    private var _parametersIncorrectId:Long = Long.getLong(1949708153,-764796546);
    private var _passwordIncorrectId:Long = Long.getLong(1732735615,-984327503);
    private var _startChangingUidId:Long = Long.getLong(1298373875,-653902182);
    private var _startChangingUidViaPartnerId:Long = Long.getLong(786315527,795427604);
    private var _uidChangedId:Long = Long.getLong(1017952359,-15692477);
    private var _uidIncorrectId:Long = Long.getLong(1000326761,-673076882);

    public function ChangeUidModelBase() {
      super();
      this.initCodecs();
    }

    protected function initCodecs() : void {
      this.server = new ChangeUidModelServer(IModel(this));
    }

    override public function invoke(param1:Long, param2:ProtocolBuffer) : void {
      switch(param1) {
        case this._parametersIncorrectId:
          this.client.parametersIncorrect();
          break;
        case this._passwordIncorrectId:
          this.client.passwordIncorrect();
          break;
        case this._startChangingUidId:
          this.client.startChangingUid();
          break;
        case this._startChangingUidViaPartnerId:
          this.client.startChangingUidViaPartner();
          break;
        case this._uidChangedId:
          this.client.uidChanged();
          break;
        case this._uidIncorrectId:
          this.client.uidIncorrect();
      }
    }

    override public function get id() : Long {
      return this.modelId;
    }
  }
}
