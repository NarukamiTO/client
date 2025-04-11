package projects.tanks.client.panel.model.emailreminder {
  import alternativa.osgi.OSGi;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.TypeCodecInfo;
  import alternativa.types.Long;
  import platform.client.fp10.core.model.IModel;
  import platform.client.fp10.core.model.impl.Model;

  public class EmailReminderModelBase extends Model {
    private var _protocol:IProtocol = IProtocol(OSGi.getInstance().getService(IProtocol));

    protected var server:EmailReminderModelServer;

    private var client:IEmailReminderModelBase = IEmailReminderModelBase(this);
    private var modelId:Long = Long.getLong(1515742461,1294189212);
    private var _activateMessageId:Long = Long.getLong(1020345955,1337151235);
    private var _activateMessage_messageCodec:ICodec;
    private var _notifyEmailIsBusyId:Long = Long.getLong(975242164,1949003173);
    private var _notifyEmailIsBusy_emailCodec:ICodec;
    private var _notifyEmailIsForbiddenId:Long = Long.getLong(1157065731,337374157);
    private var _notifyEmailIsForbidden_emailCodec:ICodec;
    private var _notifyEmailIsFreeId:Long = Long.getLong(975242164,1949119000);
    private var _notifyEmailIsFree_emailCodec:ICodec;
    private var _openConfirmEmailReminderId:Long = Long.getLong(1878159224,-550346793);
    private var _openConfirmEmailReminder_emailCodec:ICodec;
    private var _openEnterEmailReminderId:Long = Long.getLong(532560185,-1848992209);
    private var _openThanksForConfirmationEmailWindowId:Long = Long.getLong(412946160,1704963022);

    public function EmailReminderModelBase() {
      super();
      this.initCodecs();
    }

    protected function initCodecs() : void {
      this.server = new EmailReminderModelServer(IModel(this));
      this._activateMessage_messageCodec = this._protocol.getCodec(new TypeCodecInfo(String,false));
      this._notifyEmailIsBusy_emailCodec = this._protocol.getCodec(new TypeCodecInfo(String,false));
      this._notifyEmailIsForbidden_emailCodec = this._protocol.getCodec(new TypeCodecInfo(String,false));
      this._notifyEmailIsFree_emailCodec = this._protocol.getCodec(new TypeCodecInfo(String,false));
      this._openConfirmEmailReminder_emailCodec = this._protocol.getCodec(new TypeCodecInfo(String,false));
    }

    override public function invoke(param1:Long, param2:ProtocolBuffer) : void {
      switch(param1) {
        case this._activateMessageId:
          this.client.activateMessage(String(this._activateMessage_messageCodec.decode(param2)));
          break;
        case this._notifyEmailIsBusyId:
          this.client.notifyEmailIsBusy(String(this._notifyEmailIsBusy_emailCodec.decode(param2)));
          break;
        case this._notifyEmailIsForbiddenId:
          this.client.notifyEmailIsForbidden(String(this._notifyEmailIsForbidden_emailCodec.decode(param2)));
          break;
        case this._notifyEmailIsFreeId:
          this.client.notifyEmailIsFree(String(this._notifyEmailIsFree_emailCodec.decode(param2)));
          break;
        case this._openConfirmEmailReminderId:
          this.client.openConfirmEmailReminder(String(this._openConfirmEmailReminder_emailCodec.decode(param2)));
          break;
        case this._openEnterEmailReminderId:
          this.client.openEnterEmailReminder();
          break;
        case this._openThanksForConfirmationEmailWindowId:
          this.client.openThanksForConfirmationEmailWindow();
      }
    }

    override public function get id() : Long {
      return this.modelId;
    }
  }
}
