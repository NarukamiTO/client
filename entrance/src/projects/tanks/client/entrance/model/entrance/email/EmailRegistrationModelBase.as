package projects.tanks.client.entrance.model.entrance.email {
  import alternativa.osgi.OSGi;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.types.Long;
  import platform.client.fp10.core.model.IModel;
  import platform.client.fp10.core.model.impl.Model;

  public class EmailRegistrationModelBase extends Model {
    private var _protocol:IProtocol = IProtocol(OSGi.getInstance().getService(IProtocol));

    protected var server:EmailRegistrationModelServer;

    private var client:IEmailRegistrationModelBase = IEmailRegistrationModelBase(this);
    private var modelId:Long = Long.getLong(674978907,-800007187);
    private var _emailDomainIsForbiddenId:Long = Long.getLong(1032699189,-304498487);
    private var _emailIsBusyId:Long = Long.getLong(718682178,-910726889);
    private var _emailIsFreeId:Long = Long.getLong(718682178,-910611062);
    private var _emailIsInvalidId:Long = Long.getLong(151182286,-1562975769);
    private var _emailWithPasswordSuccessfullySentId:Long = Long.getLong(83485577,828374700);

    public function EmailRegistrationModelBase() {
      super();
      this.initCodecs();
    }

    protected function initCodecs() : void {
      this.server = new EmailRegistrationModelServer(IModel(this));
    }

    override public function invoke(param1:Long, param2:ProtocolBuffer) : void {
      switch(param1) {
        case this._emailDomainIsForbiddenId:
          this.client.emailDomainIsForbidden();
          break;
        case this._emailIsBusyId:
          this.client.emailIsBusy();
          break;
        case this._emailIsFreeId:
          this.client.emailIsFree();
          break;
        case this._emailIsInvalidId:
          this.client.emailIsInvalid();
          break;
        case this._emailWithPasswordSuccessfullySentId:
          this.client.emailWithPasswordSuccessfullySent();
      }
    }

    override public function get id() : Long {
      return this.modelId;
    }
  }
}
