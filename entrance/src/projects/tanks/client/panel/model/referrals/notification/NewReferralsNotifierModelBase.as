package projects.tanks.client.panel.model.referrals.notification {
  import alternativa.osgi.OSGi;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.TypeCodecInfo;
  import alternativa.types.Long;
  import platform.client.fp10.core.model.IModel;
  import platform.client.fp10.core.model.impl.Model;

  public class NewReferralsNotifierModelBase extends Model {
    private var _protocol:IProtocol = IProtocol(OSGi.getInstance().getService(IProtocol));

    protected var server:NewReferralsNotifierModelServer;

    private var client:INewReferralsNotifierModelBase = INewReferralsNotifierModelBase(this);
    private var modelId:Long = Long.getLong(1159964427,-343700957);
    private var _notifyNewReferralsCountUpdatedId:Long = Long.getLong(2091301631,441198109);
    private var _notifyNewReferralsCountUpdated_countCodec:ICodec;
    private var _notifyReferralAddedId:Long = Long.getLong(1626332809,1880389982);
    private var _notifyReferralAdded_newReferralsCountCodec:ICodec;

    public function NewReferralsNotifierModelBase() {
      super();
      this.initCodecs();
    }

    protected function initCodecs() : void {
      this.server = new NewReferralsNotifierModelServer(IModel(this));
      this._notifyNewReferralsCountUpdated_countCodec = this._protocol.getCodec(new TypeCodecInfo(int,false));
      this._notifyReferralAdded_newReferralsCountCodec = this._protocol.getCodec(new TypeCodecInfo(int,false));
    }

    override public function invoke(param1:Long, param2:ProtocolBuffer) : void {
      switch(param1) {
        case this._notifyNewReferralsCountUpdatedId:
          this.client.notifyNewReferralsCountUpdated(int(this._notifyNewReferralsCountUpdated_countCodec.decode(param2)));
          break;
        case this._notifyReferralAddedId:
          this.client.notifyReferralAdded(int(this._notifyReferralAdded_newReferralsCountCodec.decode(param2)));
      }
    }

    override public function get id() : Long {
      return this.modelId;
    }
  }
}
