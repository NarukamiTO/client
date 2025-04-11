package platform.client.fp10.core.service.errormessage {
  import platform.client.fp10.core.service.errormessage.errors.ErrorType;

  public interface IErrorMessageService {
    function showMessage(param1:ErrorType) : void;
    function hideMessage() : void;
    function setMessageBox(param1:IMessageBox) : void;
  }
}
